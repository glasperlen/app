import Foundation
import Magister

struct Inventory: Codable {
    var beads = Set<Magister.Bead>()
    var deck: [Magister.Bead] { _deck.map(\.value).map { id in beads.first { $0.id == id }! } }
    private var _deck = [Int : UUID]()
    
    subscript(_ index: Int) -> Magister.Bead? {
        get {
            beads.first { $0.id == _deck[index] }
        }
        set {
            guard let id = newValue?.id else {
                _deck.removeValue(forKey: index)
                return
            }
            _deck[index] = id
        }
    }
}
