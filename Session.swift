import Foundation
import Magister

struct Session {
    var match: Magister.Match?
    var onboard = false
    var inventory = Defaults.inventory {
        didSet {
            Defaults.inventory = inventory
        }
    }
    
    mutating func newMatch() {
        match = .robot(inventory.deck)
    }
}
