import SwiftUI

extension Control {
    struct Circle: View {
        let image: String
        let action: () -> Void
        
        var body: some View {
            Button(action: action) { }
                .buttonStyle(Style { selected in
                    ZStack {
                        SwiftUI.Circle()
                            .frame(width: 70, height: 70)
                            .foregroundColor(.clear)
                        SwiftUI.Circle()
                            .frame(width: 40, height: 40)
                            .shadow(color: Color.secondary.opacity(0.3), radius: 4, x: -3, y: -3)
                            .shadow(color: Color.secondary.opacity(0.3), radius: 4, x: 3, y: 3)
                            .foregroundColor(selected ? Color.secondary.opacity(0.5) : .init(.systemBackground))
                        Image(systemName: image)
                            .foregroundColor(selected ? .init(.systemBackground) : .secondary)
                    }
                    .contentShape(SwiftUI.Circle())
                })
        }
    }
}
