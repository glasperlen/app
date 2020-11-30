import SwiftUI
import Magister

extension Game.Win {
    struct Item: View {
        @Binding var selected: Magister.Bead?
        let bead: Magister.Bead
        
        var body: some View {
            Button {
                withAnimation(.easeInOut(duration: 0.5)) {
                    selected = bead
                }
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(selected == bead ? .accentColor : Color(.secondarySystemBackground))
                        .frame(width: 72, height: 72)
                    Circle()
                        .fill(Color.black.opacity(0.2))
                        .frame(width: 62, height: 62)
                    Bead(bead: bead)
                }
            }
            .contentShape(Rectangle())
            .padding(.horizontal)
        }
    }
}
