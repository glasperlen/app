import SwiftUI

extension Control {
    struct Capsule: View {
        let text: LocalizedStringKey
        let background: Color
        let foreground: Color
        var width = CGFloat(180)
        let action: () -> Void
        
        var body: some View {
            Button(action: action) { }
                .buttonStyle(Style { selected in
                    ZStack {
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 50)
                        RoundedRectangle(cornerRadius: 17)
                            .fill(selected ? foreground : background)
                            .frame(height: 34)
                        Text(text)
                            .foregroundColor(selected ? background : foreground)
                            .font(Font.footnote.bold())
                    }
                    .frame(width: width)
                    .contentShape(Rectangle())
                })
        }
    }
}
