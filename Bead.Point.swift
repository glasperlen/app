import SwiftUI

extension Bead {
    struct Point: View {
        let point: Int
        
        var body: some View {
            ZStack {
                Circle()
                    .fill(Color.clear)
                Text(verbatim: "\(point)")
                    .foregroundColor(.white)
                    .font(.caption2)
            }
            .frame(width: 30, height: 30)
        }
    }
}
