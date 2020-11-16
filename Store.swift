import SwiftUI
import StoreKit

struct Store: View {
    @State private var formatter = NumberFormatter()
    @State private var load = true
    private let purchases = Purchases()
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
                    .frame(width: 60, height: 40)
            }
            .contentShape(Rectangle())
        }
        .padding(.top, 20)
        ScrollView {
            if load || purchases.products.value.isEmpty {
                HStack {
                    Text("Loading")
                        .font(Font.caption.bold())
                        .foregroundColor(.secondary)
                        .padding()
                    Spacer()
                }
            } else {
                ForEach(purchases.products.value, id: \.self) { product in
                    Item(purchase: Purchases.Item(rawValue: product.productIdentifier)!, price: price(product)) {
                        withAnimation(.easeInOut(duration: 1)) {
                            load = true
                        }
                        purchases.purchase(product)
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
