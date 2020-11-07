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
                            .frame(width: 75, height: 75)
                        if selected {
                            SwiftUI.Circle()
                                .stroke(Color.secondary, style: .init(lineWidth: 1))
                                .frame(width: 50, height: 50)
                        } else {
                            SwiftUI.Circle()
                                .fill(Color.background)
                                .modifier(Neumorphic())
                                .frame(width: 50, height: 50)
                        }
                        Image(systemName: image)
                            .foregroundColor(selected ? .secondary : .primary)
                    }
                    .contentShape(SwiftUI.Circle())
                })
        }
    }
}
