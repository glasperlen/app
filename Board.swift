import SwiftUI

struct Board: View {
    var body: some View {
        VStack {
            ForEach(0 ..< 3) { _ in
                HStack {
                    ForEach(0 ..< 3) { _ in
                        Cell {
                            
                        }
                    }
                }.padding(.horizontal)
            }
            Spacer()
                .frame(height: 80)
        }
    }
}
