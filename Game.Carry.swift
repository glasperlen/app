import SwiftUI

extension Game {
    struct Carry: View {
        @Binding var session: Session
        
        var body: some View {
            VStack {
                HStack {
                    Spacer()
                    Text("Select where to play")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding()
                    if session.carry != nil {
                        Bead(bead: session.match[.user].deck[session.carry!])
                            .frame(width: 40, height: 40)
                            .padding()
                    }
                    Spacer()
                }
                Button {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        session.carry = nil
                    }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .foregroundColor(.oponent)
                        .frame(width: 50, height: 50)
                }
                .contentShape(Rectangle())
                .padding()
            }
        }
    }
}
