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
                    .fill(Color("Background"))
                    .modifier(Neumorphic())
                VStack {
                    content
                }
                .padding(30)
            }
            .frame(maxWidth: 400)
            .frame(height: 380)
            .padding(.horizontal, 40)
        }
    }
}
