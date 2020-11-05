import SwiftUI
import Magister

struct Deck: View {
    @Binding var session: Session
    @Environment(\.presentationMode) private var visible
    
    var body: some View {
        VStack {
            VStack {
                ForEach(0 ..< 5) { index in
                    HStack {
                        Bead.Color(color: session.inventory[index]?.color.color ?? .black)
                            .frame(width: 50, height: 50)
                            .padding()
                        Spacer()
                    }
                }
            }
            .padding()
            Spacer()
            Dismiss {
                visible.wrappedValue.dismiss()
            }
        }
        .modifier(Background())
    }
}
