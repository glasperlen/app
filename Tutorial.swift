import SwiftUI
import Magister

struct Tutorial: View {
    @Environment(\.presentationMode) private var visible
    
    var body: some View {
        VStack {
            TabView {
                Card {
                    A()
                }
                Card {
                    B()
                }
                Card {
                    B()
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            Control.Capsule(text: "Done", background: .secondary, foreground: .black) {
                visible.wrappedValue.dismiss()
            }
            .padding(.bottom)
        }
    }
}

private struct A: View {
    var body: some View {
        VStack {
            Bead(bead: .init(color: .blue, top: 1, bottom: 0, left: 2, right: 4))
                .padding()
            HStack {
                Text("Colour")
                    .bold()
                Spacer()
                Text("blue")
            }
            .frame(width: 140)
            .foregroundColor(.secondary)
            .padding(.top)
            HStack {
                Text("Points")
                    .bold()
                Spacer()
            }
            .frame(width: 140)
            .foregroundColor(.secondary)
            .padding(.top)
            HStack {
                Text("Top")
                Spacer()
                Text(verbatim: "1")
            }
            .frame(width: 140)
            .foregroundColor(.secondary)
            HStack {
                Text("Bottom")
                Spacer()
                Text(verbatim: "0")
            }
            .frame(width: 140)
            .foregroundColor(.secondary)
            HStack {
                Text("Left")
                Spacer()
                Text(verbatim: "2")
            }
            .frame(width: 140)
            .foregroundColor(.secondary)
            HStack {
                Text("Right")
                Spacer()
                Text(verbatim: "4")
            }
            .frame(width: 140)
            .padding(.bottom)
            .foregroundColor(.secondary)
            Text("A bead")
                .padding(.top)
                .font(Font.title.bold())
            Text("The main element of the game.\nEach one is unique and with different properties.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
    }
}

private struct B: View {
    var body: some View {
        VStack {
            Text(verbatim: "5")
                .font(Font.largeTitle.bold())
                .padding(.vertical)
            Text("""
You will receive 5 beads at the beginning, this will be your inventory.

When playing you will get new beads when you win, but beads will be taken out of your inventory when you loose.

In your inventory you can select which beads you want to use when playing, it is important to have exactly 5 beads selected to be able to play.

You can also purchase new beads.
""")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
    }
}
