import SwiftUI
import Magister

struct Deck: View {
    @Binding var session: Session
    @Environment(\.presentationMode) private var visible
    
    var body: some View {
        VStack {
            HStack {
                Text("Inventory")
                    .font(.title)
                    .padding(.leading)
                Spacer()
            }
            .padding(.top, 40)
            ForEach(session.beads) { bead in
                HStack {
                    Bead(bead: bead.item)
                        .frame(width: 70, height: 70)
                        .padding()
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
