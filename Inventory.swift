import Foundation
import Magister

struct Inventory: Codable {
    var beads = Set<Magister.Bead>()
    private var deck = [Int : UUID]()
    
    subscript(_ index: Int) -> Magister.Bead {
        get {
            beads.first { $0.id == deck[index] }!
        }
        set {
            deck[index] = newValue.id
        }
    }
}
