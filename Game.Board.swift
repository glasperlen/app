import SwiftUI

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
                                    Cell(session: $session, point: .init(x, y)) {
                                        
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
