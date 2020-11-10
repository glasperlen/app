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
            Spacer()
                .frame(height: 30)
            ForEach(0 ..< .init(ceil(Float(session.beads.count) / 3))) { row in
                HStack {
                    Spacer()
                    ForEach(session.beads.dropFirst(row * 3).prefix(3)) {
                        Item(session: $session, bead: $0)
                    }
                    Spacer()
                }
            }
        }
        .modifier(Background())
    }
}
