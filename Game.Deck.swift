import SwiftUI

extension Game {
    struct Deck: View {
        @Binding var session: Session
        
        var body: some View {
            HStack {
                Text("Play a bead")
                    .font(.headline)
                    .padding()
                Spacer()
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0 ..< 5) { index in
                        if session.match[.user][index].state == .waiting {
                            Button {
                                withAnimation(.easeInOut(duration: 1)) {
                                    session.carry = index
                                }
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(Color.background)
                                        .modifier(Neumorphic())
                                        .frame(width: 70, height: 70)
                                    if session.carry == index {
                                        Circle()
                                            .stroke(Color.user, style: .init(lineWidth: 3))
                                            .frame(width: 67, height: 67)
                                    }
                                    Bead(bead: session.match[.user][index].bead)
                                        .frame(width: 42, height: 42)
                                }
                                .contentShape(SwiftUI.Circle())
                                .padding()
                            }
                        }
                    }
                }
                .padding(.vertical)
            }
        }
    }
}
