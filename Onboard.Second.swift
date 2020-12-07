import SwiftUI
import Magister

extension Onboard {
    struct Second: View {
        @Binding var session: Session
        @Binding var tab: Int
        @State private var tutorial = false
        @AppStorage(Defaults.Key.onboard_beads.rawValue) private var beads = true
        @AppStorage(Defaults.Key.onboard_start.rawValue) private var start = true
        
        var body: some View {
            Card {
                Spacer()
                if !beads && session.beads.count >= 5 {
                    Pack(beads: .init(session.beads.suffix(5)))
                }
                Spacer()
                Text("As a new player\nyou receive 5 new beads.")
                    .foregroundColor(.secondary)
                    .font(.footnote)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                Button {
                    withAnimation(.easeInOut(duration: 1)) {
                        tab = 2
                    }
                } label: {
                    Text("Continue")
                        .foregroundColor(.primary)
                        .font(Font.footnote.bold())
                        .frame(minWidth: 100, minHeight: 50)
                }
                .contentShape(Rectangle())
            }
            .onAppear {
                if beads {
                    beads = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        session.play(.Hero)
                        withAnimation(.easeInOut(duration: 0.3)) {
                            session.beads = Magister.Bead.make().map { .init(selected: true, item: $0) }
                        }
                    }
                }
            }
        }
    }
}
