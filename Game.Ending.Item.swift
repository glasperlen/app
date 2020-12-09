import SwiftUI
import Magister

extension Game.Ending {
    struct Item: View {
        @Binding var selected: Magister.Bead?
        let bead: Magister.Bead
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.user.opacity(0.15))
                    .frame(width: 76, height: 76)
                    .opacity(bead == selected ? 1 : 0)
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.user, style: .init(lineWidth: 3))
                    .frame(width: 76, height: 76)
                    .opacity(bead == selected ? 1 : 0)
                Bead(bead: bead)
            }
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.3)) {
                    selected = bead
                }
            }
        }
    }
}
