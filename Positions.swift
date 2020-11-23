import Foundation
import CoreGraphics
import Magister

struct Positions {
    var drop: Point?
    private(set) var cells = [Point : CGRect]()
    
    subscript(_ point: Point) -> CGRect? {
        get {
            cells[point]
        }
        set {
            cells[point] = newValue
        }
    }
}
