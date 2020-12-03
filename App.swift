import SwiftUI
import AVFoundation

@main struct App: SwiftUI.App {
    @Environment(\.scenePhase) private var phase
    @State private var session = Session()
    @State private var store = false
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color("Background")
                    .edgesIgnoringSafeArea(.all)
                    .sheet(isPresented: $store) {
                        Store(session: $session)
                    }
                Game(session: $session)
            }
            .onReceive(session.purchases.open) {
                withAnimation(.easeIn(duration: 1)) { 
                    store = true
                }
            }
        }
        .onChange(of: phase) {
            if $0 == .active {
                UIApplication.shared.auth()
                try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try? AVAudioSession.sharedInstance().setActive(true)
            }
        }
    }
}
