import Foundation
import Magister

extension Session {
    struct Bead: Codable, Equatable {
        var selected: Bool
        let item: Magister.Bead
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.item.id == rhs.item.id && lhs.selected == rhs.selected
        }
    }
}
