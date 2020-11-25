import Foundation
import Magister

final class Defaults: UserDefaults {
    class var beads: [Session.Bead] {
        get { standard.data(forKey: Key.beads.rawValue).flatMap { try? JSONDecoder().decode([Session.Bead].self, from: $0) } ?? .init() }
        set { try? standard.setValue(JSONEncoder().encode(newValue), forKey: Key.beads.rawValue) }
    }
    
    class var match: Match? {
        get { standard.data(forKey: Key.match.rawValue).flatMap { try? JSONDecoder().decode(Match.self, from: $0) } }
        set {
            guard let match = newValue else {
                standard.removeObject(forKey: Key.match.rawValue)
                return
            }
            try? standard.setValue(JSONEncoder().encode(match), forKey: Key.match.rawValue)
        }
    }
    
    class var id: String? {
        get { standard.string(forKey: Key.id.rawValue) }
        set {
            guard let id = newValue else {
                standard.removeObject(forKey: Key.id.rawValue)
                return
            }
            standard.setValue(id, forKey: Key.id.rawValue)
        }
    }
    
    class var victories: Int {
        get { standard.integer(forKey: Key.victories.rawValue) }
        set { standard.setValue(newValue, forKey: Key.victories.rawValue) }
    }
    
    class var settings_sound: Bool {
        get { standard.value(forKey: Key.settings_sound.rawValue) as? Bool ?? true }
        set { standard.setValue(newValue, forKey: Key.settings_sound.rawValue) }
    }
    
    class var settings_vibrate: Bool {
        get { standard.value(forKey: Key.settings_vibrate.rawValue) as? Bool ?? true }
        set { standard.setValue(newValue, forKey: Key.settings_vibrate.rawValue) }
    }
}
