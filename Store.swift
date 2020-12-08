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
        ScrollView {
            HStack {
                Image(systemName: "cart.fill")
                    .frame(width: 60)
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
                    Spacer()
                    Text(verbatim: error!)
                        .foregroundColor(.secondary)
                        .padding(.top)
                        .padding()
                    Spacer()
                }
            } else if loading {
                HStack {
                    Spacer()
                    Text("Loading")
                        .font(Font.body.bold())
                        .foregroundColor(.secondary)
                        .padding(.top)
                        .padding()
                    Spacer()
                }
            } else {
                HStack {
                    Text("These packs are unique and always contain different beads defined by the quality of the pack.\n\nPurchases are consumable, you can purchase them many times but can't be restored.")
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                ForEach(products, id: \.0.productIdentifier) { product in
                    Item(purchase: Purchases.Item(rawValue: product.0.productIdentifier)!, price: product.1) {
                        withAnimation(.easeInOut(duration: 0.5)) {   
                            session.purchases.purchase(product.0)
                        }
                    }
                }
            }
        }
        .background(Color.background.edgesIgnoringSafeArea(.all))
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
        .onReceive(session.purchases.done) {
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
