import SwiftUI

extension Game {
    struct Title: View {
        @Binding var session: Session
        
        var body: some View {
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
                Spacer()
            }
            .padding(40)
            .fullScreenCover(isPresented: $session.onboard) {
                Onboard(session: $session)
                    .modifier(Background())
                    .preferredColorScheme(.dark)
            }
        }
    }
}
