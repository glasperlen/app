import SwiftUI

extension Onboard {
    struct First: View {
        @Binding var session: Session
        @Binding var tab: Int
        
        var body: some View {
            Card {
                Spacer()
                Image(systemName: "person.circle.fill")
                    .font(.largeTitle)
                    .padding(.bottom)
                Text("Welcome to")
                Text("The Glass\nBead Game")
                    .multilineTextAlignment(.center)
                    .font(Font.title.bold())
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
