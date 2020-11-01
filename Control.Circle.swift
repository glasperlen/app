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
                            .fill(Color.clear)
                            .frame(width: 70, height: 70)
                        SwiftUI.Circle()
                            .fill(selected ? Color.secondary.opacity(0.4) : .background)
                            .modifier(Neumorphic())
                            .frame(width: 50, height: 50)
                        Image(systemName: image)
                            .foregroundColor(selected ? .background : .secondary)
                    }
                    .contentShape(SwiftUI.Circle())
                })
        }
    }
}
