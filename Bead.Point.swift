import SwiftUI

extension Bead {
    struct Point: View {
        let point: Int
        
        var body: some View {
            ZStack {
                Circle()
                    .fill(Color.clear)
                Text(verbatim: "\(point)")
                    .foregroundColor(.black)
                    .font(Font.caption2.bold().monospacedDigit())
            }
            .frame(width: 24, height: 24)
        }
    }
}
