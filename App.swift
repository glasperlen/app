import SwiftUI

@main struct App: SwiftUI.App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var session = Session()
    
    var body: some Scene {
        WindowGroup {
            if session.inventory.beads.isEmpty {
                Onboard()
            } else {
                Game(session: $session)
                    .preferredColorScheme(.dark)
            }
        }
    }
}
