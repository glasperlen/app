import SwiftUI
import StoreKit

struct Store: View {
    @Binding var session: Session
    @ObservedObject private var purchases = Purchases()
    @Environment(\.presentationMode) private var visible
    @State private var formatter = NumberFormatter()
    @State private var pack = false
    @State private var done = false
    
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
            } else if purchases.error != nil {
                HStack {
                    Text(verbatim: purchases.error!)
                        .foregroundColor(.secondary)
                        .padding()
                    Spacer()
                }
            } else if purchases.loading || purchases.products.isEmpty {
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
                ForEach(purchases.products, id: \.self) { product in
                    Item(purchase: Purchases.Item(rawValue: product.productIdentifier)!, price: price(product)) {
                        withAnimation(.easeInOut(duration: 0.5)) {   
                            purchases.purchase(product)
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
        .onReceive(purchases.beads) {
            if !done {
                session.play(.Hero)
                session.beads.append(contentsOf: $0)
                done = true
                pack = true
            }
        }
        .onAppear {
            formatter.numberStyle = .currencyISOCode
            if !done && purchases.products.isEmpty {
                purchases.load()
            }
        }
    }
    
    private func price(_ product: SKProduct) -> String {
        formatter.locale = product.priceLocale
        return formatter.string(from: product.price)!
    }
}
