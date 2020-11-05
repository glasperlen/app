import SwiftUI
import Magister

extension Onboard {
    struct Second: View {
        @Binding var session: Session
        @Binding var tab: Int
        @State private var deck = false
        
        var body: some View {
            Card {
                HStack {
                    Text("Your brand new deck")
                        .font(.footnote)
                    Spacer()
                }
                Spacer()
                Image(systemName: "bag.fill")
                    .font(.largeTitle)
                    .padding(.vertical)
                HStack {
                    Spacer()
                    ForEach(0 ..< 5) {
                        Bead.Color(color: session.inventory[$0]?.color.color ?? .black)
                            .frame(width: 18, height: 18)
                    }
                    Spacer()
                }
                .padding(.top)
                if !session.inventory.beads.isEmpty {
                    Button {
                        deck = true
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
            .sheet(isPresented: $deck) {
                Deck(session: $session)
            }
            .onAppear {
                if session.inventory.beads.isEmpty {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        let beads = Factory.beads(5)
                        withAnimation(.easeInOut(duration: 1)) {
                            beads.enumerated().forEach {
                                session.inventory[$0.0] = $0.1
                            }
                            session.inventory.beads = beads
                        }
                    }
                }
            }
        }
    }
}
