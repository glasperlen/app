import SwiftUI

extension Pack {
    struct Detail: View {
        let beads: [Session.Bead]
        @Environment(\.presentationMode) private var visible
        
        var body: some View {
            HStack {
                Text("New beads")
                    .font(Font.title.bold())
                    .padding(.leading)
                Spacer()
                Button {
                    visible.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                        .font(.title2)
                        .frame(width: 60, height: 35)
                }
                .contentShape(Rectangle())
            }
            .padding(.top, 20)
            .padding(.bottom, 10)
            VStack {
                HStack {
                    Spacer()
                        .frame(height: 20)
                }
                ForEach(beads, id: \.item.id) {
                    Bead(bead: $0.item)
                        .padding(.top)
                }
                Spacer()
            }
            .background(Color("Background")
                            .edgesIgnoringSafeArea(.all))
        }
    }

}
