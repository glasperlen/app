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
                Pack(beads: beads ? [] : .init(session.beads.suffix(5)))
                Spacer()
                Button {
                    tutorial = true
                } label: {
                    Text("Tutorial")
                        .foregroundColor(.primary)
                        .font(Font.footnote.bold())
                        .frame(minWidth: 100, minHeight: 50)
                }
                .sheet(isPresented: $tutorial) {
                    Tutorial()
                }
                if !beads {
                    Control.Capsule(text: "Start", background: .primary, foreground: .black) {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            start = false
                        }
                    }
                }
            }
            .onAppear {
                if beads {
                    beads = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        session.play(.Hero)
                        session.beads = Magister.Bead.make().map { .init(selected: true, item: $0) }
                    }
                }
            }
        }
    }
}
