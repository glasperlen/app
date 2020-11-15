import Foundation

final class Defaults: UserDefaults {
    class var beads: [Session.Bead] {
        get { standard.data(forKey: Key.beads.rawValue).flatMap { try? JSONDecoder().decode([Session.Bead].self, from: $0) } ?? .init() }
        set { try? standard.setValue(JSONEncoder().encode(newValue), forKey: Key.beads.rawValue) }
    }
    
    class var victories: Int {
        get { standard.integer(forKey: Key.victories.rawValue) }
        set { standard.setValue(newValue, forKey: Key.victories.rawValue) }
    }
}
