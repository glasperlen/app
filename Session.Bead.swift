import Foundation
import Magister

extension Session {
    struct Bead: Codable, Identifiable, Equatable {
        var id: UUID { item.id }
        var selected: Bool
        let item: Magister.Bead
        
        static func == (lhs: Self, rhs: Self) -> Bool {
            lhs.id == rhs.id && lhs.selected == rhs.selected
        }
    }
}
