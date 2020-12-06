import Foundation
import Magister

extension Session {
    struct Bead: Codable, Hashable {
        var selected: Bool
        let item: Magister.Bead
    }
}
