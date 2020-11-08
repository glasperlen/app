import Foundation
import CoreGraphics
import Magister

extension Game.Deck {
    struct Item {
        var offset = CGSize.zero
        let index: Int
        let bead: Magister.Bead
    }
}
