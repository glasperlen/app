import SwiftUI

struct Place: View {
    let state: State
    
    var body: some View {
        ZStack {
            switch state {
            case .empty:
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color("Background"))
                    .modifier(Neumorphic())
            case .hover:
                Highlight(color: .user)
            case let .taken(bead, color):
                Highlight(color: color)
                Bead(bead: bead)
            case let .flash(bead, color):
                Highlight(color: color)
                Bead(bead: bead)
                RoundedRectangle(cornerRadius: 10)
                    .fill(color)
                    .padding(4)
            }
        }
        .padding(5)
    }
}

private struct Highlight: View {
    let color: Color
    
    var body: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color("Background"))
            .shadow(color: color, radius: 7)
        RoundedRectangle(cornerRadius: 12)
            .stroke(color, style: .init(lineWidth: 1))
    }
}
