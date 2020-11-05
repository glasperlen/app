import SwiftUI

struct Match: View {
    @Binding var session: Session
    
    var body: some View {
        if session.match == .off {
            VStack {
                HStack {
                    Text("The")
                        .font(.body)
                    Spacer()
                }
                HStack {
                    Text("Glass")
                        .font(Font.largeTitle.bold())
                    Spacer()
                }
                HStack {
                    Text("Bead")
                        .font(Font.largeTitle.bold())
                    Spacer()
                }
                HStack {
                    Text("Game")
                        .font(Font.largeTitle.bold())
                    Spacer()
                }
            }
            .padding(40)
            .fullScreenCover(isPresented: $session.onboard) {
                Onboard(session: $session)
                    .modifier(Background())
                    .preferredColorScheme(.dark)
            }
        } else {
            Header(session: $session)
            Board(session: $session)
        }
    }
}
