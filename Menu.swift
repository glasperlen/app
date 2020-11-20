import SwiftUI

struct Menu: View {
    @Binding var session: Session
    @State private var formatter = NumberFormatter()
    @State private var store = false
    @AppStorage(Defaults.Key.settings_sound.rawValue) private var sound = true
    @AppStorage(Defaults.Key.settings_vibrate.rawValue) private var vibrate = true
    @Environment(\.presentationMode) private var visible
    
    var body: some View {
        HStack {
            Text("Menu")
                .font(.headline)
                .padding(.leading)
            Spacer()
            Button {
                visible.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.secondary)
                    .font(.title2)
                    .frame(width: 60, height: 40)
            }
            .contentShape(Rectangle())
        }
        .padding(.top, 20)
        ScrollView {
            HStack {
                Image(systemName: "person.fill")
                    .font(.largeTitle)
                    .padding()
                Text(NSNumber(value: Defaults.victories), formatter: formatter)
                    .font(Font.title.bold())
                Text(Defaults.victories == 1 ? "Victory" : "Victories")
                    .font(.footnote)
                Spacer()
            }
            .padding(.leading)
            .padding(.top)
            Item(text: "Purchases", image: "cart") {
                store = true
            }
            .sheet(isPresented: $store) {
                Store(session: $session)
            }
            Item(text: "Leaderboards", image: "star") {
                visible.wrappedValue.dismiss()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    UIApplication.shared.leaderboards()
                }
            }
            Item(text: "How to play?", image: "info.circle") {

            }
            Switch(text: "Sounds", value: $sound)
                .padding(.top)
            Switch(text: "Vibrate", value: $vibrate)
        }
        .modifier(Background())
        .onAppear {
            formatter.numberStyle = .decimal
        }
    }
}