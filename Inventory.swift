import Foundation
import Magister

public struct Inventory: Codable {
    var beads = Set<Magister.Bead>()
    var deck = [UUID]()
}
