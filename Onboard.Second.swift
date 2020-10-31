import SwiftUI
import Magister

extension Onboard {
    struct Second: View {
        @Binding var session: Session
        @Binding var tab: Int
        @State private var beads = [Bead]()
        
        var body: some View {
            Card {
                HStack {
                    Text("Your brand new deck")
                        .font(.footnote)
                    Spacer()
                }
                Spacer()
                Image(systemName: "bag.fill")
                    .foregroundColor(.accentColor)
                    .font(.largeTitle)
                    .padding(.vertical)
                HStack {
                    Spacer()
                    ForEach(0 ..< 5) {
                        Circle()
                            .shadow(color: beads.isEmpty ? Color.black.opacity(0.3) : beads[$0].color.color.opacity(0.6), radius: 6)
                            .frame(width: 16, height: 16)
                            .foregroundColor(beads.isEmpty ? .init(.secondarySystemBackground) : beads[$0].color.color)
                    }
                    Spacer()
                }
                .padding(.vertical)
                Button {
                    withAnimation(.easeInOut(duration: 1)) {
                        tab = 1
                    }
                } label: {
                    Text("View bag")
                        .foregroundColor(.secondary)
                        .font(Font.footnote.bold())
                        .frame(minWidth: 100, minHeight: 50)
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
            .onAppear {
                if beads.isEmpty {
                    beads = Factory.make(5).shuffled()
                }
            }
        }
    }
}
