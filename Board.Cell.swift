import SwiftUI

extension Board {
    struct Cell: View {
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundColor(.init(.secondarySystemBackground))
                    Circle()
                        .padding()
                        .foregroundColor(.red)
                        .hidden()
                }
            }
        }
    }
}
