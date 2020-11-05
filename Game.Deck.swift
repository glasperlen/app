import SwiftUI

extension Game {
    struct Deck: View {
        @Binding var session: Session
        @Environment(\.presentationMode) private var visible
        
        var body: some View {
            VStack {
                HStack {
                    Spacer()
                    Text("Play a bead")
                        .font(.headline)
                        .padding(.top, 20)
                        .padding()
                    Spacer()
                }
                VStack {
                    ForEach(0 ..< session.match[.user].deck.count) { index in
                        Button {
                            visible.wrappedValue.dismiss()
                            withAnimation(.easeInOut(duration: 1)) {
                                session.carry = index
                            }
                        } label: {
                            Bead(bead: session.match[.user].deck[index])
                                .frame(width: 70, height: 70)
                                .padding()
                        }
                    }
                }
                .padding()
                Spacer()
                Dismiss {
                    visible.wrappedValue.dismiss()
                }
            }
            .modifier(Background())
        }
    }
}
