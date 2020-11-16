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
                ForEach(purchases.products, id: \.self) { product in
                    Item(purchase: Purchases.Item(rawValue: product.productIdentifier)!, price: price(product)) {
                        withAnimation(.easeInOut(duration: 1)) {   
                            purchases.purchase(product)
                        }
                    }
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
