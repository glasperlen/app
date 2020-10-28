import SwiftUI

extension Control {
    struct Circle: View {
        let image: String
        let action: () -> Void
        
        var body: some View {
            Button(action: action) {

            }
            .buttonStyle(Style { selected in
                ZStack {
                    SwiftUI.Circle()
                        .frame(width: 70, height: 70)
                        .foregroundColor(.clear)
                    SwiftUI.Circle()
                        .frame(width: 40, height: 40)
                        .shadow(color: Color.accentColor.opacity(0.5), radius: 4, x: -3, y: -3)
                        .shadow(color: Color.accentColor.opacity(0.5), radius: 4, x: 3, y: 3)
                        .foregroundColor(selected ? .init(.systemBackground) : .accentColor)
                    Image(systemName: image)
                        .font(Font.headline.bold())
                        .foregroundColor(selected ? .accentColor : .black)
                }
                .contentShape(SwiftUI.Circle())
            })
        }
    }
}

private struct Style<Content>: ButtonStyle where Content : View {
    let current: (Bool) -> Content
    
    func makeBody(configuration: Configuration) -> some View {
        current(configuration.isPressed)
    }
}
