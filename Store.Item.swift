import SwiftUI

extension Store {
    struct Item: View {
        let purchase: Purchases.Item
        let price: String
        let action: () -> Void
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.background)
                    .modifier(Neumorphic())
                VStack {
                    Image(purchase.image)
                        .padding()
                    Text(verbatim: purchase.title)
                        .font(Font.title.bold())
                    Text(verbatim: purchase.subtitle)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                        .padding()
                    Spacer()
                    Text(verbatim: price)
                        .bold()
                    Control.Capsule(text: "Purchase", background: .accentColor, foreground: .white, action: action)
                        .padding(.bottom)
                }
                .padding()
            }
            .frame(width: 300, height: 470)
            .padding(.vertical)
        }
    }
}
