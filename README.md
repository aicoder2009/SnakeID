# SnakeID
SnakeID is an iOS application built with SwiftUI that leverages OpenAI's GPT-5o-mini to identify snakes from images. It analyzes an image, even if partially visible or blurred, and returns a JSON result containing the common name, scientific name, venomous status, safety advice, and emergency guidance.  
![image](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)

## Requirements

- Xcode 15 or later
- iOS 17.0 or later (simulator or device)
- Swift 5.9
- OpenAI API key (configured in the app)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/aicoder2009/SnakeID.git
   cd SnakeID
   ```
2. Open `SnakeID.xcodeproj` in Xcode.
3. Build and run the app on a simulator or physical device.

## Usage

- Tap **Identify Snake** and select or capture a photo containing a snake.
- The app will call the OpenAI API and display the identification result and safety guidance.
- Emergency contact buttons are available for quick access to 911 and Poison Control Center.

## Features

- **AI-Powered Identification**: Uses GPT-5o-mini for accurate snake identification
- **Safety Information**: Provides venomous status and safety guidelines
- **Emergency Contacts**: Quick access to 911 and Poison Control Center
- **Modern UI**: Beautiful SwiftUI interface with gradient backgrounds
- **Image Processing**: Handles various image formats and sizes

## Dependencies

- SwiftUI (built-in)
- URLSession (built-in)

No external Swift packages or package managers are required.

## Security

The app includes a pre-configured API key for immediate use. For production deployment, consider using environment variables or secure key management systems.
