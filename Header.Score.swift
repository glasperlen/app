import SwiftUI
import Magister

extension Header {
    struct Score: Shape {
        let inverse: Bool
        var score: CGFloat
        
        func path(in rect: CGRect) -> Path {
            .init {
                $0.addRoundedRect(in: inverse ? .init(x: rect.width * score, y: 0, width: rect.width * (1 - score), height: rect.height)
                                    : .init(x: 0, y: 0, width: rect.width * score, height: rect.height), cornerSize: .init(width: 1.5, height: 1.5))
            }
        }
        
        var animatableData: CGFloat {
            get { score }
            set { score = newValue }
        }
    }
}
