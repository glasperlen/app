import SwiftUI
import Magister

extension Game {
    struct Prize: View {
        @Binding var session: Session
        let beads: [Magister.Bead]
        @State private var selected: Magister.Bead?
        
        var body: some View {
            HStack {
                Text("Choose your prize")
                    .padding(.leading)
                Spacer()
            }
            ForEach(beads) { bead in
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
                    selected = nil
                    session.beads.append(.init(selected: false, item: bead))
                    session.match!.prize(bead)
                    UIApplication.shared.next(session.match!) {
                        UIApplication.shared.victory()
                        UIApplication.shared.remove()
                        session.match = nil
                        Defaults.game = nil
                    }
                }
                .padding(.bottom)
            }
        }
    }
}
