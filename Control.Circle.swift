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
                                .fill(Color.black)
                                .frame(width: 65, height: 65)
                        } else {
                            SwiftUI.Circle()
                                .fill(Color("Background"))
                                .modifier(Neumorphic())
                                .frame(width: 60, height: 60)
                        }
                        Image(systemName: image)
                            .font(.title2)
                            .foregroundColor(selected ? .secondary : .primary)
                    }
                    .contentShape(SwiftUI.Circle())
                })
        }
    }
}
