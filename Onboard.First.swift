import SwiftUI

extension Onboard {
    struct First: View {
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
                        Text("Welcome to")
                            .font(.footnote)
                        Spacer()
                    }
                    HStack {
                        Text("The Glass Bead Game")
                            .font(.headline)
                        Spacer()
                    }
                    Spacer()
                    Image(systemName: "person.fill")
                        .foregroundColor(.accentColor)
                        .font(.largeTitle)
                        .padding(.vertical)
                    HStack {
                        Text("As a new player you will receive a starting deck with 5 beads.\n\nAs you win matches you will gain more beads and grow your deck.")
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding(.vertical)
                    Spacer()
                    Control.Capsule(text: "Next", color: .init(.secondarySystemBackground)) {
                        withAnimation(.easeInOut(duration: 1)) {
                            tab = 1
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
            .padding(.bottom, 80)
            .padding()
        }
    }
}
