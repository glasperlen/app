import Foundation
import Magister

extension Session {
    struct Bead: Codable, Identifiable {
        var id: UUID { item.id }
        var selected: Bool
        let item: Magister.Bead
    }
}
