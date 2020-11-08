import SwiftUI
import Magister

extension Game {
    struct Board: View {
        @Binding var session: Session
        
        var body: some View {
            GeometryReader { geo in
                Group {
                    VStack {
                        ForEach(0 ..< 3) { y in
                            HStack {
                                ForEach(0 ..< 3) { x in
                                    GeometryReader {
                                        Cell(session: $session, point: .init(x, y), frame: $0.frame(in: .global))
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .frame(height: geo.size.width)
            }
        }
    }
}
