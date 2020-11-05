import SwiftUI

struct Game: View {
    @Binding var session: Session
    @State private var loading = false
    
    var body: some View {
        ZStack {
            if loading {
                Loading(session: $session, loading: $loading)
            } else {
                Arena(session: $session)
            }
            Turn(session: $session)
        }
        .onReceive(session.new.delay(for: .seconds(0.3), scheduler: DispatchQueue.main)) {
            withAnimation(.easeInOut(duration: 1)) {
                loading = true
            }
        }
    }
}
