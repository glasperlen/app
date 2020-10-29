import SwiftUI

struct Onboard: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.init(.tertiarySystemBackground))
            VStack {
                Spacer()
                    .frame(height: 20)
                HStack {
                    Text("Welcome to")
                        .font(.footnote)
                    Spacer()
                }
                HStack {
                    Text("The Glass Bead Game")
                        .font(.headline)
                    Spacer()
                }
                Spacer()
                Control.Capsule(text: "Start", color: .blue) {
                    
                }
                .padding(.horizontal)
            }
            .padding()
        }
        .padding()
    }
}
