import SwiftUI
import Magister

extension Header {
    struct Score: View {
        let edge: Edge.Set
        let name: String?
        let order: Player.Order
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(order == .first ? .blue : .pink )
                    .frame(height: 30)
                HStack {
                    if edge == .trailing {
                        Spacer()
                    }
                    Text(verbatim: "312")
                        .padding(.horizontal)
                    if edge == .leading {
                        Spacer()
                    }
                }
            }
        }
    }
}
