import SwiftUI

struct Board: View {
    var body: some View {
        GeometryReader { geo in
            Group {
                VStack {
                    ForEach(0 ..< 3) { x in
                        HStack {
                            ForEach(0 ..< 3) { y in
                                Cell {
                                    
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
