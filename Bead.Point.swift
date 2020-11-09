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
                    .font(Font.caption2.bold())
            }
            .frame(width: 26, height: 26)
        }
    }
}
