import SwiftUI
import Magister

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
            ForEach(session.beads) { bead in
                if bead == session.beads.first {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 1)
                }
                HStack {
                    Spacer()
                    Bead(bead: bead.item)
                        .padding(.horizontal)
                    if bead.selected {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.user)
                            .font(.title2)
                            .padding()
                    }
                    Spacer()
                }
                if bead != session.beads.last {
                    Rectangle()
                        .fill(Color(.tertiarySystemBackground))
                        .frame(height: 1)
                        .padding(.horizontal)
                }
            }
        }
        .modifier(Background())
    }
}
