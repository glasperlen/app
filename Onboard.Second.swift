import SwiftUI
import Magister

extension Onboard {
    struct Second: View {
        @Binding var tab: Int
        
        var body: some View {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.init(.tertiarySystemBackground))
                VStack {
                    Spacer()
                        .frame(height: 20)
                    HStack {
                        Text("Your brand new deck")
                            .font(.footnote)
                        Spacer()
                    }
                    Spacer()
                    Image(systemName: "bag.fill")
                        .foregroundColor(.accentColor)
                        .font(.largeTitle)
                        .padding(.vertical)
                    HStack {
                        Text("You can join matches now!")
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                    .padding(.vertical)
                    Spacer()
                    Control.Capsule(text: "Open bag", color: .init(.secondarySystemBackground)) {
                        
                    }
                    .padding(.horizontal)
                    Control.Capsule(text: "Continue", color: .init(.secondarySystemBackground)) {
                        withAnimation(.easeInOut(duration: 1)) {
                            tab = 2
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
            }
            .padding(.bottom, 80)
            .padding()
        }
    }
}
