import SwiftUI

struct AnalysisResultView: View {
    let result: AnalysisResult
    let originalImage: UIImage?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                // Header with image
                VStack(spacing: 20) {
                    if let image = originalImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 300)
                            .cornerRadius(15)
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                    }
                    
                    // Species information
                    VStack(spacing: 15) {
                        Text(result.commonName)
                            .font(.system(size: 28, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                            .multilineTextAlignment(.center)
                        
                        Text(result.scientificName)
                            .font(.system(size: 16, weight: .medium, design: .serif))
                            .foregroundColor(.secondary)
                            .italic()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                // Safety status card
                VStack(spacing: 20) {
                    HStack(spacing: 15) {
                        Image(systemName: result.isVenomous ? "exclamationmark.triangle.fill" : "checkmark.circle.fill")
                            .font(.system(size: 24))
                            .foregroundColor(result.isVenomous ? .red : .green)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text(result.isVenomous ? "VENOMOUS" : "NON-VENOMOUS")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(result.isVenomous ? .red : .green)
                            
                            Text(result.isVenomous ? "Handle with extreme caution" : "Generally safe to observe")
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(result.isVenomous ? Color.red.opacity(0.1) : Color.green.opacity(0.1))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(result.isVenomous ? Color.red.opacity(0.3) : Color.green.opacity(0.3), lineWidth: 1)
                            )
                    )
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                // What to do section
                VStack(spacing: 15) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.green)
                        
                        Text("What To Do")
                            .font(.system(size: 18, weight: .bold))
                        
                        Spacer()
                    }
                    
                    Text(result.whatToDo)
                        .font(.system(size: 16))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.green.opacity(0.1))
                        )
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                // What not to do section
                VStack(spacing: 15) {
                    HStack {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.red)
                        
                        Text("What NOT To Do")
                            .font(.system(size: 18, weight: .bold))
                        
                        Spacer()
                    }
                    
                    Text(result.whatNotToDo)
                        .font(.system(size: 16))
                        .foregroundColor(.primary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 12)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.red.opacity(0.1))
                        )
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                // Emergency contacts
                VStack(spacing: 15) {
                    HStack {
                        Image(systemName: "phone.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.blue)
                        
                        Text("Emergency Contacts")
                            .font(.system(size: 18, weight: .bold))
                        
                        Spacer()
                    }
                    
                    VStack(spacing: 12) {
                        Button(action: {
                            if let url = URL(string: "tel:911") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Image(systemName: "phone.fill")
                                    .font(.system(size: 16))
                                Text("Call 911 (Emergency)")
                                    .font(.system(size: 16, weight: .semibold))
                                Spacer()
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 14))
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .background(Color.red)
                            .cornerRadius(10)
                        }
                        
                        Button(action: {
                            if let url = URL(string: "tel:1-800-222-1222") {
                                UIApplication.shared.open(url)
                            }
                        }) {
                            HStack {
                                Image(systemName: "phone.fill")
                                    .font(.system(size: 16))
                                Text("Poison Control Center")
                                    .font(.system(size: 16, weight: .semibold))
                                Spacer()
                                Image(systemName: "arrow.right")
                                    .font(.system(size: 14))
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 15)
                            .background(Color.orange)
                            .cornerRadius(10)
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 40)
            }
        }
        .navigationTitle("Analysis Result")
        .navigationBarTitleDisplayMode(.inline)
        .background(
            LinearGradient(
                colors: [Color.green.opacity(0.05), Color.blue.opacity(0.05)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
    }
}
