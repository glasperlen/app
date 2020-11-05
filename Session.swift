import Foundation
import Combine
import Magister

struct Session {
    var carry: Int?
    var match = Match.off
    var onboard = false
    
    var inventory = Defaults.inventory {
        didSet {
            Defaults.inventory = inventory
        }
    }
    
    let new = PassthroughSubject<Void, Never>()
}
