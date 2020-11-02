import SwiftUI

extension Onboard {
    struct First: View {
        @Binding var session: Session
        @Binding var tab: Int
        
        var body: some View {
            Card {
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
                    .font(.largeTitle)
                    .padding(.vertical)
                HStack {
                    Text("As a new player you will receive a starting deck with 5 beads.\n\nWhen winning matches you will gain more beads and grow your deck.")
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding(.vertical)
                Spacer()
                Button {
                    withAnimation(.easeInOut(duration: 1)) {
                        tab = 1
                    }
                } label: {
                    Text("Next")
                        .foregroundColor(.primary)
                        .font(Font.footnote.bold())
                        .frame(minWidth: 100, minHeight: 50)
                }
                .contentShape(Rectangle())
            }
        }
    }
}
