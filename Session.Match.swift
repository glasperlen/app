import Foundation
import Magister

extension Session {
    struct Match {
        private(set) var turn = Player.Order.first
        let local: Player.Order
        
        mutating func next() {
            switch turn {
            case .first: turn = .second
            case .second: turn = .first
            }
        }
    }
}
