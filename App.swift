import SwiftUI

@main struct App: SwiftUI.App {
    @Environment(\.scenePhase) private var phase
    @State private var session = Session()
    
    var body: some Scene {
        WindowGroup {
            Game(session: $session)
                .modifier(Background())
        }
        .onChange(of: phase) {
            if $0 == .active {
                UIApplication.shared.auth()
            }
        }
    }
}
