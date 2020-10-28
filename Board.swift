import SwiftUI

struct Board: View {
    var body: some View {
        GeometryReader { geo in
            VStack {
                ForEach(0 ..< 3) { _ in
                    HStack {
                        ForEach(0 ..< 3) { _ in
                            Cell {
                                
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .frame(height: geo.size.width)
        }
    }
}
