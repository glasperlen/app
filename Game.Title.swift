import SwiftUI

extension Game {
    struct Title: View {
        @Binding var session: Session
        @AppStorage(Defaults.Key.onboard_start.rawValue) private var start = true
        
        var body: some View {
            VStack {
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
                .fullScreenCover(isPresented: $start, onDismiss: {
                    start = false
                }) {
                    Onboard(session: $session)
                        .background(Color("Background")
                                        .edgesIgnoringSafeArea(.all))
                        .preferredColorScheme(.dark)
                }
                Spacer()
                Controls(session: $session)
            }
        }
    }
}
