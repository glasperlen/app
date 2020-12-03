import SwiftUI
import StoreKit

struct Store: View {
    @Binding var session: Session
    @State private var products = [(SKProduct, String)]()
    @State private var error: String?
    @State private var loading = true
    @State private var pack = false
    @State private var done = false
    @Environment(\.presentationMode) private var visible
    
    var body: some View {
        HStack {
            Text("Store")
                .font(.headline)
                .padding(.leading)
            Spacer()
            Button {
                visible.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.secondary)
                    .font(.title2)
                    .frame(width: 60, height: 50)
            }
            .contentShape(Rectangle())
        }
        .padding(.top, 20)
        ScrollView {
            if done {
                Image(systemName: "checkmark.circle.fill")
                    .font(.title)
                    .foregroundColor(.accentColor)
                    .padding(.top, 50)
                HStack {
                    Spacer()
                    Text("Purchase successful")
                        .font(.headline)
                        .padding()
                    Spacer()
                }
                Control.Capsule(text: "Done", background: .primary, foreground: .black) {
                    visible.wrappedValue.dismiss()
                }
                .padding(.vertical)
            } else if error != nil {
                HStack {
                    Text(verbatim: error!)
                        .foregroundColor(.secondary)
                        .padding()
                    Spacer()
                }
            } else if loading {
                HStack {
                    Text("Loading")
                        .font(Font.footnote.bold())
                        .foregroundColor(.secondary)
                        .padding()
                    Spacer()
                }
            } else {
                HStack {
                    Text("You can purchase packs with new beads, each pack is unique and every time you purchase them they will contain different beads.\n\nThe points of the beads in the packs will be influenced by the quality of the pack you choose.\n\nAll purchases are consumable, you can purchase them many times but you won't be able to restore them.")
                        .padding()
                        .foregroundColor(.secondary)
                    Spacer()
                }
                ForEach(products, id: \.0.productIdentifier) { product in
                    Item(purchase: Purchases.Item(rawValue: product.0.productIdentifier)!, price: product.1) {
                        withAnimation(.easeInOut(duration: 0.5)) {   
                            session.purchases.purchase(product.0)
                        }
                    }
                    .padding(.vertical)
                    Rectangle()
                        .fill(Color.white.opacity(0.2))
                        .frame(height: 1)
                        .padding(.horizontal)
                }
            }
        }
        .modifier(Background())
        .sheet(isPresented: $pack) {
            Pack.Detail(beads: session.beads.suffix(5))
        }
        .onReceive(session.purchases.loading) {
            loading = $0
        }
        .onReceive(session.purchases.error) {
            error = $0
        }
        .onReceive(session.purchases.products) {
            products = $0
        }
        .onReceive(session.purchases.beads) {
            if !done {
                session.play(.Hero)
                session.beads.append(contentsOf: $0)
                done = true
                pack = true
            }
        }
        .onAppear {
            session.purchases.load()
        }
    }
}
