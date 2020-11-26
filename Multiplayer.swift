import SwiftUI

struct Multiplayer: View {
    @Binding var session: Session
    @AppStorage(Defaults.Key.id.rawValue) private var id: String?
    
    var body: some View {
        if id != nil {
            ZStack {
                if session.multiplayer == nil {
                    Loading(session: $session)
                } else if session.match?.state == .matching {
                    Matching(session: $session)
                }
            }
            .onReceive(UIApplication.synch) {
                guard Defaults.match?.state != session.match?.state else { return }
                session.match = Defaults.match
            }
        }
    }
}
