import Foundation
import CoreGraphics
import Magister

extension Session {
    struct Gameplay {
        var drop: Point?
        var cells = [Point : CGRect]()
    }
}
