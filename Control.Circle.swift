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
                            .frame(width: 90, height: 90)
                        if selected {
                            SwiftUI.Circle()
                                .stroke(Color.primary, style: .init(lineWidth: 2))
                                .frame(width: 60, height: 60)
                        } else {
                            SwiftUI.Circle()
                                .fill(Color.background)
                                .modifier(Neumorphic())
                                .frame(width: 60, height: 60)
                        }
                        Image(systemName: image)
                            .font(.title2)
                            .foregroundColor(.primary)
                    }
                    .contentShape(SwiftUI.Circle())
                })
        }
    }
}
