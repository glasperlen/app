import SwiftUI

extension Onboard {
    struct Card<Content>: View where Content : View {
        let content: Content
        
        @inlinable public init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.background)
                    .modifier(Neumorphic())
                VStack {
                    content
                }
                .padding(30)
            }
            .frame(width: 280, height: 280)
        }
    }
}
