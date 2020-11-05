import SwiftUI

struct Game: View {
    @Binding var session: Session
    @State private var loading = false
    
    var body: some View {
        if loading {
            Loading(session: $session, loading: $loading)
        } else {
            VStack {
                Match(session: $session)
                Spacer()
                Controls(session: $session)
            }
            .onReceive(session.new.delay(for: .seconds(0.3), scheduler: DispatchQueue.main)) {
                loading = true
            }
        }
    }
}
