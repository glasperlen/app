import Foundation
import CoreGraphics
import Magister

extension Game.Deck {
    struct Item {
        var item: Player.Item
        let index: Int
        let offset = CGSize.zero
    }
}
