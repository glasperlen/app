import SwiftUI

struct Onboard: View {
    @State private var tab = 0
    
    var body: some View {
        TabView(selection: $tab) {
            First(tab: $tab)
                .tag(0)
            Second(tab: $tab)
                .tag(1)
            Third(tab: $tab)
                .tag(2)
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
}
