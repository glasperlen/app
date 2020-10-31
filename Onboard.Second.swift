import SwiftUI
import Magister

extension Onboard {
    struct Second: View {
        @Binding var session: Session
        @Binding var tab: Int
        @State private var beads = [Magister.Bead]()
        
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
                        Bead(color: beads.isEmpty ? .init(.secondarySystemBackground) : beads[$0].color.color)
                            .frame(width: 18, height: 18)
                    }
                    Spacer()
                }
                .padding(.vertical)
                if !beads.isEmpty {
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
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.easeInOut(duration: 1)) {
                            beads = Factory.make(5).shuffled()
                        }
                    }
                }
            }
        }
    }
}
