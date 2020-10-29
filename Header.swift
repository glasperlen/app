import SwiftUI

struct Header: View {
    var body: some View {
        HStack {
            Score(edge: .leading, name: nil, order: .first)
            Spacer()
            Score(edge: .trailing, name: "Dimi", order: .second)
        }
        .padding(.horizontal)
    }
}
