import SwiftUI

extension Board {
    struct Cell: View {
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color(.secondarySystemBackground))
                    Circle()
                        .fill(Color.red)
                        .padding()
                        .hidden()
                }
            }
        }
    }
}
