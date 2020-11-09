import SwiftUI
import Magister

struct Inventory: View {
    @Binding var session: Session
    @Environment(\.presentationMode) private var visible
    
    var body: some View {
        ScrollView {
            HStack {
                Text("Inventory")
                    .font(.headline)
                    .padding(.leading)
                Spacer()
            }
            .padding(.top, 40)
            ForEach(session.beads) { bead in
                HStack {
                    Bead(bead: bead.item)
                        .frame(width: 70, height: 70)
                        .padding(.leading, 40)
                    Spacer()
                }
            }
            Spacer()
            Dismiss {
                visible.wrappedValue.dismiss()
            }
        }
        .modifier(Background())
    }
}
