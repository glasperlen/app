import SwiftUI

@main struct App: SwiftUI.App {
    @State private var session = Session()
    
    var body: some Scene {
        WindowGroup {
            Game()
        }
    }
}
