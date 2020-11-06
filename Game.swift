import SwiftUI

struct Game: View {
    @Binding var session: Session
    @State private var loading = false
    
    var body: some View {
        ZStack {
            Arena(session: $session)
            if loading {
                Loading(session: $session, loading: $loading)
            }
            Turn(session: $session)
            Finish(session: $session)
        }
        .onReceive(session.new.delay(for: .seconds(0.3), scheduler: DispatchQueue.main)) {
            withAnimation(.easeInOut(duration: 1)) {
                loading = true
            }
        }
    }
}
