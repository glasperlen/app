import Foundation
import Combine
import Magister

struct Session {
    var match: Match?
    var gameplay: Gameplay?
    var beads = Defaults.beads {
        didSet {
            Defaults.beads = beads
        }
    }
    let new = PassthroughSubject<Void, Never>()
}
