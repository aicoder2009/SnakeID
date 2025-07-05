import SwiftUI

struct ContentView: View {
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage?
    @State private var analysisResult: AnalysisResult?
    @State private var isShowingResult = false
    @State private var isAnalyzing = false
    @State private var showingAlert = false
    @State private var alertMessage = ""

    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [Color.green.opacity(0.1), Color.blue.opacity(0.05)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    Spacer()
                    
                    // App icon and title section
                    VStack(spacing: 25) {
                        // Snake emoji as app icon
                        Text("🐍")
                            .font(.system(size: 80))
                            .padding(.bottom, 10)
                        
                        VStack(spacing: 12) {
                            Text("SnakeID")
                                .font(.system(size: 42, weight: .black, design: .rounded))
                                .foregroundColor(.primary)
                            
                            Text("AI-Powered Snake Identification")
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.bottom, 40)
                    
                    // Description card
                    VStack(spacing: 20) {
                        Text("📸 Instant Species Identification")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        Text("⚠️ Emergency Safety Guidance")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primary)
                        
                        Text("🚨 Quick Emergency Contacts")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.primary)
                    }
                    .padding(.vertical, 25)
                    .padding(.horizontal, 30)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
                    )
                    .padding(.horizontal, 30)
                    
                    Spacer()
                    
                    // Large, prominent capture button
                    Button(action: {
                        isImagePickerPresented = true
                    }) {
                        HStack(spacing: 15) {
                            Image(systemName: "camera.fill")
                                .font(.system(size: 24, weight: .semibold))
                            Text("Identify Snake")
                                .font(.system(size: 22, weight: .bold, design: .rounded))
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                        .background(
                            LinearGradient(
                                colors: [Color.green, Color.green.opacity(0.8)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .shadow(color: .green.opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 50)
                    
                    // Safety disclaimer
                    Text("⚠️ For emergencies, always call 911 first")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                        .padding(.bottom, 30)
                }
            }
            .sheet(isPresented: $isImagePickerPresented, onDismiss: {
                if let selectedImage = selectedImage {
                    print("Image selected, size: \(selectedImage.size)")
                    analyzeImage(image: selectedImage)
                } else {
                    print("No image selected")
                }
            }) {
                ImagePicker(image: $selectedImage)
            }
            .overlay(
                Group {
                    if isAnalyzing {
                        ZStack {
                            Color.black.opacity(0.4)
                                .ignoresSafeArea()
                            
                            VStack(spacing: 20) {
                                ProgressView()
                                    .scaleEffect(1.5)
                                    .tint(.white)
                                
                                Text("Analyzing Snake...")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            }
                            .padding(30)
                            .background(Color.black.opacity(0.8))
                            .cornerRadius(15)
                        }
                    }
                }
            )
            .navigationDestination(isPresented: $isShowingResult) {
                if let result = analysisResult {
                    AnalysisResultView(result: result, originalImage: selectedImage)
                        .onAppear {
                            print("Showing result view with image: \(selectedImage != nil ? "present" : "nil")")
                        }
                        .onDisappear {
                            // Reset state when leaving result view
                            selectedImage = nil
                            analysisResult = nil
                        }
                }
            }
            .alert("Error", isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }

    func analyzeImage(image: UIImage) {
        // Resize image if too large
        let resizedImage = resizeImage(image: image, maxSize: CGSize(width: 800, height: 800))
        
        guard let imageData = resizedImage.jpegData(compressionQuality: 0.6) else {
            showError("Failed to process image")
            return
        }
        
        let base64String = imageData.base64EncodedString()
        print("Image size: \(imageData.count) bytes, Base64 size: \(base64String.count) characters")
        isAnalyzing = true
        
        Task {
            do {
                let result = try await analyzeWithGPT(base64Image: base64String)
                await MainActor.run {
                    print("Analysis successful: \(result.commonName)")
                    isAnalyzing = false
                    analysisResult = result
                    isShowingResult = true
                }
            } catch {
                await MainActor.run {
                    isAnalyzing = false
                    if let urlError = error as? URLError {
                        switch urlError.code {
                        case .notConnectedToInternet:
                            showError("No internet connection. Please check your network.")
                        case .timedOut:
                            showError("Request timed out. Please try again.")
                        case .cannotConnectToHost:
                            showError("Cannot connect to server. Please try again.")
                        case .userAuthenticationRequired:
                            showError("Invalid API key. Please check configuration.")
                        case .badServerResponse:
                            showError("Server error. Please try again.")
                        default:
                            showError("Network error (\(urlError.code.rawValue)): \(urlError.localizedDescription)")
                        }
                    } else {
                        showError("Failed to analyze image: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    func analyzeWithGPT(base64Image: String) async throws -> AnalysisResult {
		guard let apiKey = ProcessInfo.processInfo.environment["OPENAI_API_KEY"], !apiKey.isEmpty else {
			throw NSError(domain: "SnakeID", code: 1, userInfo: [NSLocalizedDescriptionKey: "Please set the OPENAI_API_KEY environment variable"])
		}

		print("Starting API call to OpenAI...")
        
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 30.0
        
        let payload: [String: Any] = [
            "model": "gpt-4o",
            "messages": [
                [
                    "role": "user",
                    "content": [
                        [
                            "type": "text",
                            "text": """
                            You are an expert herpetologist. Analyze this image for snake identification. 

                            If you see a snake (even partially visible, blurry, or distant), identify it. 

                            Respond with this JSON format:
                            {
                                "commonName": "Snake species name or 'Unidentified Snake' if unclear",
                                "scientificName": "Scientific name or 'Species uncertain'", 
                                "isVenomous": false,
                                "isSafe": false,
                                "whatToDo": "• Back away slowly • Observe from distance • Contact authorities if needed",
                                "whatNotToDo": "• Don't approach • Don't handle • Don't make sudden movements"
                            }
                            """
                        ],
                        [
                            "type": "image_url",
                            "image_url": [
                                "url": "data:image/jpeg;base64,\(base64Image)"
                            ]
                        ]
                    ]
                ]
            ],
            "max_tokens": 300,
            "temperature": 0.1
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: payload)
        
        // Create URLSession with configuration
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 30.0
        config.timeoutIntervalForResource = 60.0
        let session = URLSession(configuration: config)
        
        let (data, response) = try await session.data(for: request)
        
        // Check HTTP response
        if let httpResponse = response as? HTTPURLResponse {
            print("HTTP Status: \(httpResponse.statusCode)")
            if httpResponse.statusCode == 401 {
                print("Unauthorized - Invalid API Key")
                throw URLError(.userAuthenticationRequired)
            } else if httpResponse.statusCode == 400 {
                print("Bad Request - Invalid model or request format")
                if let errorData = String(data: data, encoding: .utf8) {
                    print("Error Response: \(errorData)")
                }
                throw URLError(.badServerResponse)
            } else if httpResponse.statusCode != 200 {
                print("API Error - Status Code: \(httpResponse.statusCode)")
                if let errorData = String(data: data, encoding: .utf8) {
                    print("Error Response: \(errorData)")
                }
                throw URLError(.badServerResponse)
            }
        }
        
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any],
              let choices = json["choices"] as? [[String: Any]],
              let firstChoice = choices.first,
              let message = firstChoice["message"] as? [String: Any],
              let content = message["content"] as? String else {
            print("Failed to parse API response structure")
            print("Raw response: \(String(data: data, encoding: .utf8) ?? "nil")")
            throw URLError(.badServerResponse)
        }
        
        print("GPT Response: \(content)")
        
        // Clean and parse JSON response
        var cleanContent = content.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Remove code block markers if present
        if cleanContent.hasPrefix("```json") {
            cleanContent = String(cleanContent.dropFirst(7))
        }
        if cleanContent.hasSuffix("```") {
            cleanContent = String(cleanContent.dropLast(3))
        }
        
        // Extract JSON object
        if let startIndex = cleanContent.firstIndex(of: "{"),
           let endIndex = cleanContent.lastIndex(of: "}") {
            cleanContent = String(cleanContent[startIndex...endIndex])
        }
        
        print("Cleaned content for parsing: \(cleanContent)")
        
        guard let jsonData = cleanContent.data(using: .utf8),
              let analysisData = try JSONSerialization.jsonObject(with: jsonData) as? [String: Any] else {
            print("Failed to parse JSON from GPT response")
            throw URLError(.badServerResponse)
        }
        
        print("Parsed analysis data: \(analysisData)")
        
        let commonName = analysisData["commonName"] as? String ?? "Unknown"
        
        return AnalysisResult(
            commonName: commonName,
            scientificName: analysisData["scientificName"] as? String ?? "Unknown",
            isVenomous: analysisData["isVenomous"] as? Bool ?? false,
            isSafe: analysisData["isSafe"] as? Bool ?? false,
            whatToDo: analysisData["whatToDo"] as? String ?? "Observe from distance",
            whatNotToDo: analysisData["whatNotToDo"] as? String ?? "Do not approach"
        )
    }
    
    func resizeImage(image: UIImage, maxSize: CGSize) -> UIImage {
        let size = image.size
        
        // If already smaller, return original
        if size.width <= maxSize.width && size.height <= maxSize.height {
            return image
        }
        
        // Calculate new size maintaining aspect ratio
        let widthRatio = maxSize.width / size.width
        let heightRatio = maxSize.height / size.height
        let ratio = min(widthRatio, heightRatio)
        
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: CGRect(origin: .zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resizedImage ?? image
    }
    
    func showError(_ message: String) {
        alertMessage = message
        showingAlert = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}