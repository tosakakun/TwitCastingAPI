# TwitCasting API v2 Client in Swift

Swift client libraty for TwitCasting API v2

offical document => [https://apiv2-doc.twitcasting.tv/](https://apiv2-doc.twitcasting.tv/)

## Requirement

- iOS 15.0+
- macOS 12.0+

## Installation

### Swift Package Manager
Add `.package(url: "https://github.com/tosakakun/TwitCastingAPI.git", from: "1.0.0")` to your `Package.swift` file's dependencies.

## Usage

Sample Project is here.
You have to generate your client id via [the Developer page](https://ssl.twitcasting.tv/developer.php)

### Authentication
Create an instance of TwitCastingAuth with client ID and callback URL scheme.
```
import SwiftUI
import TwitCastingAPI

@main
struct TwitCastingAPIDevApp: App {
    
    @StateObject var auth = TwitCastingAuth(clientId: "YOUR_CLIENT_ID", callbackURLScheme: "YOUR_CALLBACK_URL_SCHEME")
    
    var body: some Scene {
        WindowGroup {
            
            if auth.token.isEmpty {
                LoginView(auth: auth)
            } else {
                APITestView()
                    .environmentObject(auth)
            }
            
        }
    }
}
```
Call the login method on the login screen.
```
import SwiftUI
import TwitCastingAPI

struct LoginView: View {
    
    @ObservedObject var auth: TwitCastingAuth

    var body: some View {
        
        Button {
            auth.login()
        } label: {
            Text("ツイキャスでログイン")
        }
        
    }
}
```
## License
MIT
