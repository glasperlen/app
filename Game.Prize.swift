import SwiftUI
import Magister

extension Game {
    struct Prize: View {
        @Binding var session: Session
        let wait: Match.Wait
        let beads: [Magister.Bead]
        @State private var selected: Magister.Bead?
        
        var body: some View {
            Text("Choose your prize")
                .padding(.horizontal)
                .padding(.bottom)
            ForEach(beads, id: \.self) { bead in
                Button {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        selected = bead
                    }
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(selected == bead ? .accentColor : Color(.secondarySystemBackground))
                            .frame(width: 72, height: 72)
                        Circle()
                            .fill(Color.black.opacity(0.2))
                            .frame(width: 62, height: 62)
                        Bead(bead: bead)
                    }
                }
                .contentShape(Rectangle())
                .padding(.horizontal)
            }
            Spacer()
            if selected != nil {
                Control.Capsule(text: "Done", background: .primary, foreground: .init("Background")) {
                    guard let bead = selected else { return }
                    session.match!.prize(bead)
                    UIApplication.shared.next(session.match!)
                }
                .padding(.bottom)
            }
        }
    }
}
