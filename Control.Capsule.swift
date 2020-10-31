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
                            .fill(Color.clear)
                            .frame(height: 50)
                        RoundedRectangle(cornerRadius: 17)
                            .fill(selected ? .init(.systemBackground) : color)
                            .frame(height: 34)
                        Text(text)
                            .foregroundColor(selected ? color : .white)
                            .font(.footnote)
                    }
                    .contentShape(Rectangle())
                })
        }
    }
}
