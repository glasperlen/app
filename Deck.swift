import SwiftUI
import Magister

struct Deck: View {
    @Binding var session: Session
    @Environment(\.presentationMode) private var visible
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
            }
            Button {
                visible.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.down.circle.fill")
                    .foregroundColor(.secondary)
                    .font(.title)
                    .frame(width: 50, height: 50)
            }
            .contentShape(Rectangle())
            .padding(.vertical)
        }
        .modifier(Background())
    }
}
