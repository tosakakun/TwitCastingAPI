# TwitCasting API v2 Client in Swift

Swift client library for TwitCasting API v2

offical document => [https://apiv2-doc.twitcasting.tv/](https://apiv2-doc.twitcasting.tv/)

## Requirement

- iOS 15.0+
- macOS 12.0+

## Installation

### Swift Package Manager
1. In Xcode, select File > Add Packages.... 
1. Spacify the repository https://github.com/tosakakun/TwitCastingAPI.git 
1. Spacify options and then click Add Package.

## Usage

You have to generate your client id and set Callback URL via [the Developer page](https://ssl.twitcasting.tv/developer.php). Make sure to set the appropriate scope.

### Authentication
Create an instance of TwitCastingAuth with your client ID and callback URL scheme.
```Swift
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
```Swift
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
### Getting Information
Get User Info
```Swift
import Foundation
import TwitCastingAPI

class GetUserInfoViewModel: ObservableObject {
    
    @Published var userInfo: TCUserInfoResponse?
    
    private let api = TwitCastingAPI()
    
    func getUserInfo(token: String, id: String) async {
        
        do {
            
            let userInfo = try await api.getUserInfo(token: token, userId: id)
            
            DispatchQueue.main.async {
                self.userInfo = userInfo
            }
            
        } catch let error as TCError {
            print(error.localizedDescription)
        } catch {
            print(error.localizedDescription)
        }
        
    }

}
```
```Swift
import SwiftUI
import TwitCastingAPI

struct GetUserInfoView: View {
    
    @EnvironmentObject var auth: TwitCastingAuth
    
    @StateObject var viewModel = GetUserInfoViewModel()
    
    @State private var id = ""

    var body: some View {
        
        VStack {
            TextField("id or screen_id を入力", text: $id)
                .textFieldStyle(.roundedBorder)
                .padding()
            Button {
                Task {
                    await viewModel.getUserInfo(token: auth.token, id: id)
                }
            } label: {
                Text("検索")
            }
            
            if let userInfo = viewModel.userInfo {
                
                AsyncImage(url: URL(string: userInfo.user.image))
                Text(userInfo.user.id)
                Text(userInfo.user.screenId)
                Text(userInfo.user.name)
                Text("\(userInfo.user.level)")
                Text(userInfo.user.profile)

            }

            Spacer()
            
        }
        .navigationTitle("Get User Info テスト")

    }
    
}
```
All TwitCasting API v2 can be used in the same way, except WebHook and Realtime API. 
## License
This library is released under the MIT License.
