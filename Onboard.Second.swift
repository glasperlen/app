import SwiftUI
import Magister

extension Onboard {
    struct Second: View {
        @Binding var session: Session
        @Binding var tab: Int
        
        var body: some View {
            Card {
                Image(systemName: "bag.fill")
                    .font(.largeTitle)
                    .padding(.vertical)
                Pack(beads: session.beads)
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
                if session.beads.isEmpty {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        session.play(.Hero)
                        withAnimation(.easeInOut(duration: 1)) {
                            session.beads = Factory.beads().map { .init(selected: true, item: $0) }
                        }
                    }
                }
            }
        }
    }
}
