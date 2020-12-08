import SwiftUI
import Magister

extension Place {
    enum State {
        case
        empty,
        hover,
        taken(Magister.Bead, Color),
        flash(Magister.Bead, Color)
    }
}
