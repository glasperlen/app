import SwiftUI

extension Board {
    struct Cell: View {
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .foregroundColor(.init(.secondarySystemBackground))
                    Circle()
                        .padding()
                        .foregroundColor(.red)
                }
            }
        }
    }
}
