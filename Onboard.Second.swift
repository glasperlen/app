import SwiftUI
import Magister

extension Onboard {
    struct Second: View {
        @Binding var session: Session
        @Binding var tab: Int
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.init(.tertiarySystemBackground))
                VStack {
                    Spacer()
                        .frame(height: 20)
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
                                .shadow(color: Color.secondary.opacity(0.1), radius: 2, x: -2, y: -2)
                                .shadow(color: Color.secondary.opacity(0.1), radius: 2, x: 2, y: 2)
                                .frame(width: 15, height: 15)
                                .foregroundColor($0 < session.inventory.beads.count ? .blue : .init(.secondarySystemBackground))
                        }
                        Spacer()
                    }
                    .padding(.vertical)
                    Spacer()
                    Control.Capsule(text: "Open bag", color: .init(.secondarySystemBackground)) {
                        
                    }
                    .padding(.horizontal)
                    Control.Capsule(text: "Continue", color: .init(.secondarySystemBackground)) {
                        withAnimation(.easeInOut(duration: 1)) {
                            tab = 2
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
            .padding(.bottom, 80)
            .padding()
            .onAppear {
                if session.inventory.beads.isEmpty {
                    session.inventory.beads = Factory.make(5)
                    session.inventory.deck = session.inventory.beads.map(\.id)
                }
            }
        }
    }
}
