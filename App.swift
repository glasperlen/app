import SwiftUI

@main struct App: SwiftUI.App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var session = Session()
    @AppStorage("user") private var user: String?
    
    var body: some Scene {
        WindowGroup {
            if user == nil {
                Onboard()
            } else {
                Game(session: $session)
                    .preferredColorScheme(.dark)
            }
        }
    }
}
