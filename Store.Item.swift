import SwiftUI

extension Store {
    struct Item: View {
        let purchase: Purchases.Item
        let price: String
        let action: () -> Void
        
        var body: some View {
            VStack {
                HStack {
                    Image(systemName: purchase.image)
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.init(.systemIndigo))
                    Spacer()
                        .frame(width: 10)
                    Text(verbatim: purchase.title)
                        .font(Font.title.bold())
                        .foregroundColor(.init(.systemIndigo))
                }
                Text(verbatim: purchase.subtitle)
                    .foregroundColor(.secondary)
                    .padding()
                Text(verbatim: price)
                    .font(.subheadline)
                    .foregroundColor(.primary)
//                if session.user.value.purchases.contains(purchase) {
//                    Image(systemName: "checkmark.circle.fill")
//                        .font(.largeTitle)
//                        .foregroundColor(.init(.systemIndigo))
//                        .padding()
//                } else {
//                    Cta(title: "Purchase", background: .pink, width: 120, action: action)
//                }
            }
        }
    }
}
