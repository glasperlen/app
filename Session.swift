import Foundation
import Combine
import CoreGraphics
import Magister

struct Session {
    var drop: Board.Point?
    var match = Match.off
    var cells = [Board.Point : CGRect]()
    var onboard = false
    
    var inventory = Defaults.inventory {
        didSet {
            Defaults.inventory = inventory
        }
    }
    
    let new = PassthroughSubject<Void, Never>()
}
