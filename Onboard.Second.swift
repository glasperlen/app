import SwiftUI
import Magister

extension Onboard {
    struct Second: View {
        @Binding var session: Session
        @Binding var tab: Int
        @State private var inventory = false
        
        var body: some View {
            Card {
                Image(systemName: "bag.fill")
                    .font(.largeTitle)
                    .padding(.vertical)
                HStack {
                    Spacer()
                    ForEach(0 ..< 5) {
                        Bead.Base(color: session.beads.count > 4 ? session.beads[$0].item.color.color : .black)
                            .frame(width: 18, height: 18)
                    }
                    Spacer()
                }
                .padding(.top)
                if !session.beads.isEmpty {
                    Button {
                        inventory = true
                    } label: {
                        Text("View")
                            .foregroundColor(.secondary)
                            .font(Font.footnote.bold())
                            .frame(minWidth: 100, minHeight: 50)
                    }
                }
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
            .sheet(isPresented: $inventory) {
                Inventory(session: $session)
            }
            .onAppear {
                if session.beads.isEmpty {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(.easeInOut(duration: 1)) {
                            session.beads = Factory.beads().map { .init(selected: true, item: $0) }
                        }
                    }
                }
            }
        }
    }
}
