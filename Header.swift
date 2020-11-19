import SwiftUI

struct Header: View {
    @Binding var session: Session
    @State private var abandon = false
    
    var body: some View {
        HStack {
            Button {
                abandon = true
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.oponent)
                    .font(.title)
                    .frame(width: 50, height: 45)
            }
            .contentShape(Rectangle())
            Spacer()
            Image(systemName: "person.fill")
            ZStack {
                Score(inverse: true, score: .init(session.match?.score ?? 0))
                    .fill(Color.oponent)
                    .animation(.easeInOut(duration: 0.5))
                    .frame(height: 6)
                    .opacity(session.match?.cells.isEmpty == false ? 1 : 0)
                Score(inverse: false, score: .init(session.match?.score ?? 0))
                    .fill(Color.user)
                    .animation(.easeInOut(duration: 0.5))
                    .frame(height: 6)
                    .opacity(session.match?.cells.isEmpty == false ? 1 : 0)
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 3, height: 6)
            }
            .frame(width: 80)
            Text(verbatim: session.match?.oponent.name ?? "")
                .font(Font.footnote.bold())
                .padding(.trailing)
        }
        .padding(.horizontal)
        .actionSheet(isPresented: $abandon) {
            ActionSheet(title: .init("Abandon game?"), message: .init("Your oponent will get 1 of your beads"), buttons: [
                            .cancel(.init("Cancel")),
                            .destructive(.init("Abandon")) {
                                session.play(.Bottle)
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    session.match = nil
                                }
                            }])
        }
    }
}
