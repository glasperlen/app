import SwiftUI

@main struct App: SwiftUI.App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var session = Session()
    
    var body: some Scene {
        WindowGroup {
            Game(session: $session)
                .preferredColorScheme(.dark)
                
        }
    }
}
