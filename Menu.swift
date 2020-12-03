import SwiftUI
import GameKit

struct Menu: View {
    @Binding var session: Session
    @State private var formatter = NumberFormatter()
    @State private var user = ""
    @State private var store = false
    @State private var tutorial = false
    @AppStorage(Defaults.Key.settings_sound.rawValue) private var sound = true
    @AppStorage(Defaults.Key.settings_vibrate.rawValue) private var vibrate = true
    @Environment(\.presentationMode) private var visible
    
    var body: some View {
        HStack {
            Text("Menu")
                .font(Font.title.bold())
                .padding(.leading)
            Spacer()
            Button {
                visible.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.secondary)
                    .font(.title2)
                    .frame(width: 60, height: 35)
            }
            .contentShape(Rectangle())
        }
        .padding(.top, 20)
        ScrollView {
            HStack {
                Image(systemName: "person.circle.fill")
                    .font(Font.largeTitle.bold())
                    .padding(.leading)
                    .padding(.vertical)
                Text(verbatim: user)
                    .font(Font.title.bold())
                    .padding(.trailing)
                Spacer()
                VStack {
                    Text(NSNumber(value: Defaults.beads.count), formatter: formatter)
                        .font(Font.title.bold().monospacedDigit())
                    Text(Defaults.beads.count == 1 ? "Bead" : "Beads")
                        .font(.caption)
                }
                VStack {
                    Text(NSNumber(value: Defaults.victories), formatter: formatter)
                        .font(Font.title.bold().monospacedDigit())
                    Text(Defaults.victories == 1 ? "Victory" : "Victories")
                        .font(.caption)
                }
                .padding(.horizontal)
            }
            .padding(.horizontal)
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
                tutorial = true
            }
            .sheet(isPresented: $tutorial) {
                Tutorial()
            }
            Switch(text: "Sounds", value: $sound)
                .padding(.top)
            Switch(text: "Vibrate", value: $vibrate)
        }
        .modifier(Background())
        .onAppear {
            formatter.numberStyle = .decimal
            if GKLocalPlayer.local.isAuthenticated {
                user = GKLocalPlayer.local.displayName
            }
        }
    }
}
