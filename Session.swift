import Foundation
import Combine
import Magister

struct Session {
    var match = Magister.Match.off
    var onboard = false
    var inventory = Defaults.inventory {
        didSet {
            Defaults.inventory = inventory
        }
    }
    let new = PassthroughSubject<Void, Never>()
    let turn = PassthroughSubject<Player.Mode, Never>()
}
