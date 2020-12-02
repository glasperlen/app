import SwiftUI

extension Tutorial {
    struct Card<Content>: View where Content : View {
        let content: Content
        
        
        @inlinable public init(@ViewBuilder content: () -> Content) {
            self.content = content()
        }
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color("Background"))
                    .modifier(Neumorphic())
                content
                    .padding(25)
            }
            .padding(.top, 20)
            .padding(.bottom, 50)
            .padding(20)
        }
    }
}
