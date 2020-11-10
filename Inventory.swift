import SwiftUI

struct Inventory: View {
    @Binding var session: Session
    @Environment(\.presentationMode) private var visible
    
    var body: some View {
        HStack {
            Text("Inventory")
                .font(.headline)
                .padding(.leading)
            Spacer()
            Button {
                visible.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.secondary)
                    .font(.title2)
                    .frame(width: 60, height: 40)
            }
            .contentShape(Rectangle())
        }
        .padding(.top, 20)
        ScrollView {
            ForEach(0 ..< .init(ceil(Float(session.beads.count) / 3))) { row in
                HStack {
                    ForEach(3 * row ..< 3) { _ in
//                        Item(bead: session.beads[$0])
                    }
                }
            }
        }
        .modifier(Background())
    }
}
