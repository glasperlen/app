import SwiftUI

@main struct App: SwiftUI.App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State private var session = Session()
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                if session.inventory.beads.isEmpty {
                    Onboard(session: $session)
                } else {
                    Game(session: $session)
                }
            }
            .background(Color.background
                            .edgesIgnoringSafeArea(.all))
            .preferredColorScheme(.dark)
        }
    }
}
