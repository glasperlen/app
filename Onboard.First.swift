import SwiftUI

extension Onboard {
    struct First: View {
        @Binding var session: Session
        @Binding var tab: Int
        
        var body: some View {
            Card {
                Image(systemName: "person.fill")
                    .font(.largeTitle)
                    .padding(.vertical)
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
                    Text("As a new player you will receive 5 beads.\n\nYou can get more beads by winning matches.")
                        .foregroundColor(.secondary)
                    Spacer()
                }
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
