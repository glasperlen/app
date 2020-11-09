import Foundation
import CoreGraphics
import Magister

extension Session {
    struct Gameplay {
        var drop: Board.Point?
        var cells = [Board.Point : CGRect]()
    }
}
