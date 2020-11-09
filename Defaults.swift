import Foundation

final class Defaults: UserDefaults {
    class var beads: [Session.Bead] {
        get { standard.data(forKey: Key.beads.rawValue).flatMap { try? JSONDecoder().decode([Session.Bead].self, from: $0) } ?? .init() }
        set { try? standard.setValue(JSONEncoder().encode(newValue), forKey: Key.beads.rawValue) }
    }
}
