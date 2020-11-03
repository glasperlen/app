import SwiftUI

struct Match: View {
    @Binding var session: Session
    
    var body: some View {
        Header(session: $session)
        Board(session: $session)
    }
}
