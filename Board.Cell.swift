import SwiftUI

extension Board {
    struct Cell: View {
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.background)
                        .modifier(Neumorphic())
                        .frame(width: 90, height: 90)
                    Circle()
                        .fill(Color.red)
                        .padding()
                        .hidden()
                }
            }
        }
    }
}
