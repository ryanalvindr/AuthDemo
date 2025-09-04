# AuthDemo
iOS login demo built with UIKit, SnapKit, MVVM, and Combine.  
It does not connect to a real API. Instead, it simulates a login process with a short delay and basic validation, then navigates to a Welcome screen.

## What it shows
- Programmatic UI with SnapKit (no storyboards)
- MVVM architecture
- Combine for input validation
- Async/await to simulate a fake API call (1 second delay)
- Responsive layout for different devices

## Requirements
- Xcode 15+
- iOS 13+
- Swift 5+
- CocoaPods or Swift Package Manager

## Setup
1) pod install
2) open AuthDemo.xcworkspace  
3) Build & run  

## Test Accounts
The login credentials are hardcoded to simulate an API response.  
Use any of the following to log in successfully:

- Username: ryan - Password: password1  
- Username: testuser2 - Password: qwerty 
- Username: testuser3 - Password: 1234 

