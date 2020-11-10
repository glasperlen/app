import SwiftUI

extension Inventory {
    struct Item: View {
        let bead: Session.Bead
        
        var body: some View {
            Bead(bead: bead.item)
                .padding(.horizontal)
            if bead.selected {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.user)
                    .font(.title2)
                    .padding()
            }
        }
    }
}
