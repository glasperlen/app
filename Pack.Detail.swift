import SwiftUI

extension Pack {
    struct Detail: View {
        let beads: [Session.Bead]
        @Environment(\.presentationMode) private var visible
        
        var body: some View {
            HStack {
                Text("New beads")
                    .font(.headline)
                    .padding(.leading)
                Spacer()
                Button {
                    visible.wrappedValue.dismiss()
                } label: {
                    Text("Done")
                        .bold()
                        .foregroundColor(.accentColor)
                        .frame(height: 40)
                        .padding(.trailing)
                }
                .contentShape(Rectangle())
            }
            .padding(.top, 20)
            VStack {
                HStack {
                    Spacer()
                        .frame(height: 20)
                }
                ForEach(beads, id: \.item.id) {
                    Bead(bead: $0.item)
                        .padding(.vertical)
                }
                Spacer()
            }
            .modifier(Background())
        }
    }

}
