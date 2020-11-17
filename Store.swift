import SwiftUI
import StoreKit

struct Store: View {
    @ObservedObject private var purchases = Purchases()
    @Environment(\.presentationMode) private var visible
    @State private var formatter = NumberFormatter()
    
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
                    .frame(width: 60, height: 40)
            }
            .contentShape(Rectangle())
        }
        .padding(.top, 20)
        ScrollView {
            if purchases.error != nil {
                HStack {
                    Text(verbatim: purchases.error!)
                        .foregroundColor(.secondary)
                        .padding()
                    Spacer()
                }
            } else if purchases.loading || purchases.products.isEmpty {
                HStack {
                    Text("Loading")
                        .font(Font.caption.bold())
                        .foregroundColor(.secondary)
                        .padding()
                    Spacer()
                }
            } else {
                HStack {
                    Text("You can purchase packs with beads, each one is unique and every time you purchase them they will contain different beads.\n\nThe quality of the beads they contain will be influenced by the quality of the pack you choose.")
                        .padding(.leading)
                    Spacer()
                }
                .padding(.top)
                HStack {
                    Text("All purchases are consumable, you can purchase them many times but you won't be able to restore them.")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding(.leading)
                    Spacer()
                }
                .padding(.vertical)
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
        .onAppear {
            formatter.numberStyle = .currencyISOCode
            purchases.load()
        }
    }
    
    private func price(_ product: SKProduct) -> String {
        formatter.locale = product.priceLocale
        return formatter.string(from: product.price)!
    }
}
