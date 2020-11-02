import Foundation
import Magister

struct Session {
    var match: Match?
    var board = Magister.Board()
    var inventory = Defaults.inventory
    var onboard = false
}
