import Foundation
import Magister

public struct Inventory: Codable {
    var beads = Set<Bead>()
    var deck = [UUID]()
}
