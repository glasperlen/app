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
            Text(verbatim: "\(session.beads.filter(\.selected).count)/5")
                .font(.headline)
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
        HStack {
            Text("You need 5 selected to play")
                .font(.footnote)
                .foregroundColor(.secondary)
            Spacer()
        }
        .padding(.leading)
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
