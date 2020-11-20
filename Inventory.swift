import SwiftUI

struct Inventory: View {
    @Binding var session: Session
    @State private var store = false
    @Environment(\.presentationMode) private var visible
    
    var body: some View {
        HStack {
            Text("Inventory")
                .font(.headline)
                .padding(.leading)
            Spacer()
            Text(verbatim: "\(session.beads.filter(\.selected).count)/5")
                .foregroundColor(session.beads.filter(\.selected).count == 5 ? .accentColor : .red)
                .bold()
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
            HStack {
                VStack {
                    HStack {
                        Text("Get beads")
                            .font(.headline)
                        Spacer()
                    }
                    HStack {
                        Text("You can purchase beads on the Store")
                            .font(.footnote)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                }
                Spacer()
                Control.Circle(image: "cart") {
                    store = true
                }
                .sheet(isPresented: $store) {
                    Store(session: $session)
                }
            }
            .padding()
            ForEach(0 ..< .init(ceil(Float(session.beads.count) / 3)), id: \.self) { row in
                HStack {
                    Spacer()
                    ForEach(session.beads.dropFirst(row * 3).prefix(3), id: \.item.id) {
                        Item(session: $session, bead: $0)
                    }
                    Spacer()
                }
            }
            Spacer()
                .frame(height: 20)
        }
        .modifier(Background())
    }
}
