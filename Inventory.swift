import Foundation
import Magister

struct Inventory: Codable {
    var beads = Set<Magister.Bead>()
    private var deck = [Int : UUID]()
    
    subscript(_ index: Int) -> Magister.Bead? {
        get {
            beads.first { $0.id == deck[index] }
        }
        set {
            guard let id = newValue?.id else {
                deck.removeValue(forKey: index)
                return
            }
            deck[index] = id
        }
    }
}
