import SwiftUI

extension Onboard {
    struct Third: View {
        @Binding var session: Session
        @Binding var tab: Int
        
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
                    Text("You can join matches now!")
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .padding(.vertical)
                Spacer()
                Control.Capsule(text: "Open bag", color: .init(.secondarySystemBackground)) {
                    
                }
                .padding(.horizontal)
                Control.Capsule(text: "Continue", color: .init(.secondarySystemBackground)) {
                    tab = 2
                }
                .padding(.horizontal)
            }
        }
    }
}
