import Foundation

final class Defaults: UserDefaults {
    private static let _inventory = "incognit_inventory"
    
    class var inventory: Inventory {
        get { standard.data(forKey: _inventory).flatMap { try? JSONDecoder().decode(Inventory.self, from: $0) } ?? .init() }
        set { try? standard.setValue(JSONEncoder().encode(newValue), forKey: _inventory) }
    }
}
