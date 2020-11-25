import SwiftUI

struct Multiplayer: View {
    @Binding var session: Session
    @AppStorage(Defaults.Key.id.rawValue) private var id: String?
    
    var body: some View {
        if id != nil {
            if session.multiplayer == nil {
                Loading(session: $session)
            } else {
                if session.multiplayer!.participants.last?.status == .matching {
                    Matching(session: $session)
                }
            }
        }
    }
}
