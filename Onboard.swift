import SwiftUI

struct Onboard: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.init(.tertiarySystemBackground))
            VStack {
                Spacer()
                    .frame(height: 20)
                HStack {
                    Text("Welcome to")
                        .font(.footnote)
                    Spacer()
                }
                HStack {
                    Text("The Glass Bead Game")
                        .font(.headline)
                    Spacer()
                }
                HStack {
                    Text("As a new player you will receive a starting deck with 5 beads.\n\nAs you win matches you will gain more beads and grow your deck.")
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding(.vertical)
                Spacer()
                Control.Capsule(text: "Start", color: .blue) {
                    
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .padding()
    }
}
