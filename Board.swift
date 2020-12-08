import SwiftUI
import Magister

struct Board<Content>: View where Content : View {
    let cell: (Point) -> Content
    
    var body: some View {
        GeometryReader { geo in
            Group {
                VStack {
                    ForEach(0 ..< 3) { y in
                        HStack {
                            ForEach(0 ..< 3) { x in
                                cell(.init(x, y))
                            }
                        }
                    }
                }
                .padding()
            }
            .frame(height: geo.size.width)
        }
        .frame(maxWidth: 300, maxHeight: 300)
    }
}
