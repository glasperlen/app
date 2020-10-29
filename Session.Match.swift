import Foundation
import Magister

extension Session {
    struct Match {
        private(set) var turn = Player.Order.first
        let player: Player.Order
    }
}
