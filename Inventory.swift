import SwiftUI

struct Inventory: View {
    @Binding var session: Session
    @Environment(\.presentationMode) private var visible
    
    var body: some View {
        ScrollView {
            HStack {
                Spacer()
                Button {
                    visible.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.secondary)
                        .font(.title3)
                        .frame(width: 60, height: 50)
                }
                .contentShape(Rectangle())
                .padding(.top)
            }
            Text(verbatim: "\(session.beads.filter(\.selected).count)")
                .font(Font.largeTitle.bold())
            HStack {
                ForEach(0 ..< 5) { index in
                    if index < session.beads.filter(\.selected).count {
                        Circle()
                            .fill(Color.user)
                            .frame(width: 12, height: 12)
                    } else {
                        Circle()
                            .stroke(Color.opponent, style: .init(lineWidth: 2))
                            .frame(width: 12, height: 12)
                    }
                }
            }
            .padding(.bottom, 30)
            ForEach(0 ..< .init(ceil(Float(session.beads.count) / 3)), id: \.self) { row in
                HStack {
                    Spacer()
                    ForEach(session.beads.dropFirst(row * 3).prefix(3), id: \.self) {
                        Item(session: $session, bead: $0)
                    }
                    Spacer()
                }
            }
            HStack {
                Spacer()
                VStack(alignment: .leading) {
                    Text("Get more beads")
                        .font(.headline)
                    Text("Purchase them on the store")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                Control.Circle(image: "cart") {
                    session.purchases.open.send()
                }
                .padding(.trailing)
            }
            .padding(.vertical, 40)
        }
        .background(Color.background.edgesIgnoringSafeArea(.all))
    }
}
