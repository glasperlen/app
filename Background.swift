import SwiftUI

struct Background: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.background
                            .edgesIgnoringSafeArea(.all))
    }
}