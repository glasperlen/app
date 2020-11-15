import SwiftUI

@main struct App: SwiftUI.App {
    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
    @State private var session = Session()
    
    var body: some Scene {
        WindowGroup {
            Game(session: $session)
                .modifier(Background())
        }
    }
}
