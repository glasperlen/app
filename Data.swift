import Foundation
import Magister

extension Data {
    var match: Match? {
        try? JSONDecoder().decode(Match.self, from: self)
    }
}

extension Match {
    var data: Data? {
        try? JSONEncoder().encode(self)
    }
}
