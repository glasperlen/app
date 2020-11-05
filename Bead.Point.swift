import SwiftUI

extension Bead {
    struct Point: View {
        let point: Int
        
        var body: some View {
            ZStack {
                Circle()
                    .fill(SwiftUI.Color.black.opacity(0.1))
                Text(verbatim: "\(point)")
                    .foregroundColor(.primary)
                    .font(.footnote)
            }
            .frame(width: 30, height: 30)
        }
    }
}
