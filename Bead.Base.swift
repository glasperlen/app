import SwiftUI

extension Bead {
    struct Base: View {
        let color: Color
        
        var body: some View {
            Circle()
                .fill(color)
        }
    }
}
