import SwiftUI

extension Control {
    struct Capsule: View {
        let text: LocalizedStringKey
        let color: Color
        let action: () -> Void
        
        var body: some View {
            Button(action: action) { }
                .buttonStyle(Style { selected in
                    ZStack {
                        Rectangle()
                            .frame(height: 50)
                            .foregroundColor(.clear)
                        RoundedRectangle(cornerRadius: 17)
                            .frame(height: 34)
                            .foregroundColor(selected ? .init(.systemBackground) : color)
                        Text(text)
                            .foregroundColor(selected ? color : .white)
                    }
                    .contentShape(Rectangle())
                })
        }
    }
}
