import SwiftUI
import Magister

struct Deck: View {
    @Binding var session: Session
    @Environment(\.presentationMode) private var visible
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            VStack {
                ForEach(0 ..< 5) { index in
                    HStack {
                        Bead(color: session.inventory[index]?.color.color ?? .black)
                            .frame(width: 50, height: 50)
                            .padding()
                        Spacer()
                    }
                }
            }
            .padding()
            Spacer()
            Button {
                visible.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.down.circle.fill")
                    .foregroundColor(.secondary)
                    .font(.title)
                    .frame(width: 50, height: 50)
            }
            .contentShape(Rectangle())
            .padding(.bottom)
        }
        .modifier(Background())
    }
}
