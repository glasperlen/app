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
}
