import SwiftUI

extension Store {
    struct Item: View {
        let purchase: Purchases.Item
        let price: String
        let action: () -> Void
        
        var body: some View {
            HStack {
                VStack {
                    Image(purchase.image)
                        .padding()
                    Text(verbatim: price)
                        .font(.footnote)
                    Control.Capsule(text: "Purchase", background: .accentColor, foreground: .white, width: 100, action: action)
                }
                VStack {
                    HStack {
                        Text(verbatim: purchase.heading)
                            .font(Font.title.bold())
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.trailing)
                            .padding(.top)
                        Spacer()
                    }
                    HStack {
                        Text(verbatim: purchase.title)
                            .font(Font.title3.bold())
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.trailing)
                        Spacer()
                    }
                    HStack {
                        Text(verbatim: purchase.subtitle)
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(.secondary)
                            .padding(.trailing)
                        Spacer()
                    }
                    Spacer()
                }
                Spacer()
            }
        }
    }
}
