import SwiftUI
import Magister

extension Onboard {
    struct Second: View {
        @Binding var session: Session
        @Binding var tab: Int
        @AppStorage(Defaults.Key.onboard_beads.rawValue) private var beads = true
        
        var body: some View {
            Card {
                Image(systemName: "bag.fill")
                    .font(.largeTitle)
                    .padding(.vertical)
                Pack(beads: beads ? [] : .init(session.beads.suffix(5)))
                Spacer()
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
            }
            .onAppear {
                if beads {
                    beads = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        session.play(.Hero)
                        withAnimation(.easeInOut(duration: 1)) {
                            session.beads = Magister.Bead.make().map { .init(selected: true, item: $0) }
                        }
                    }
                }
            }
        }
    }
}
