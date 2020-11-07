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
                    ForEach(0 ..< 5) { index in
                        if session.match[.user][index].state == .waiting {
                            Button {
                                visible.wrappedValue.dismiss()
                                withAnimation(.easeInOut(duration: 1)) {
                                    session.carry = index
                                }
                            } label: {
                                Bead(bead: session.match[.user][index].bead)
                                    .frame(width: 70, height: 70)
                                    .padding()
                            }
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
