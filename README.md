# SnakeID
![image](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)
SnakeID is an iOS application built with SwiftUI that leverages OpenAI's GPT-4o to identify snakes from images. It analyzes an image, even if partially visible or blurred, and returns a JSON result containing the common name, scientific name, venomous status, safety advice, and emergency guidance.

## Requirements

- Xcode 15 or later
- iOS 17.0 or later (simulator or device)
- Swift 5.9
- An OpenAI API key (set as environment variable; see below)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/aicoder2009/SnakeID.git
   cd SnakeID
   ```
2. Set your OpenAI API key:
   ```bash
   export OPENAI_API_KEY=your_api_key_here
   ```
3. Open `SnakeID.xcodeproj` in Xcode.
4. (Optional) In Xcode, go to **Product** → **Scheme** → **Edit Scheme…**, select the **Run** action, and add an environment variable `OPENAI_API_KEY` with your key to persist it in the scheme.
5. Build and run the app on a simulator or physical device.

## Usage

- Tap **Identify Snake** and select or capture a photo containing a snake.
- The app will call the OpenAI API and display the identification result and safety guidance.

## Dependencies

- SwiftUI (built-in)
- URLSession (built-in)

No external Swift packages or package managers are required.

## Environment Variables

This project relies on the `OPENAI_API_KEY` environment variable. Make sure it is set before running the app. The existing `.gitignore` file for Swift projects ensures build artifacts and sensitive files (such as environment files) are not committed.
