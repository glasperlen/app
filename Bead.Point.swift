import SwiftUI

extension Bead {
    struct Point: View {
        let point: Int
        
        var body: some View {
            ZStack {
                Circle()
                    .fill(SwiftUI.Color.clear)
                Text(verbatim: "\(point)")
                    .foregroundColor(.primary)
                    .font(.caption2)
            }
            .frame(width: 30, height: 30)
        }
    }
}
