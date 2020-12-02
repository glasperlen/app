import SwiftUI
import Magister

struct Tutorial: View {
    @Environment(\.presentationMode) private var visible
    
    var body: some View {
        VStack {
            TabView {
                Group {
                    Card {
                        A()
                    }
                    Card {
                        B()
                    }
                    Card {
                        C()
                    }
                    Card {
                        D()
                    }
                    Card {
                        E()
                    }
                    Card {
                        F()
                    }
                    Card {
                        G()
                    }
                }
                Group {
                    Card {
                        H()
                    }
                    Card {
                        I()
                    }
                    Card {
                        J()
                    }
                    Card {
                        K()
                    }
                    Card {
                        L()
                    }
                    Card {
                        M()
                    }
                    Card {
                        N()
                    }
                    Card {
                        O()
                    }
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

private struct C: View {
    var body: some View {
        VStack {
            Text("Playing Modes")
                .bold()
                .padding()
            HStack {
                VStack {
                    Image(systemName: "person.fill")
                        .font(.title)
                        .padding()
                    Text("Single")
                        .bold()
                    Text("Play against Artificial Intelligence")
                        .multilineTextAlignment(.center)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .frame(width: 130, height: 200)
                VStack {
                    Image(systemName: "person.2.fill")
                        .font(.title)
                        .padding()
                    Text("Multiplayer")
                        .bold()
                    Text("Play someone else with Game Center")
                        .multilineTextAlignment(.center)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .frame(width: 130, height: 200)
            }
        }
    }
}

private struct D: View {
    var body: some View {
        VStack {
            Text("""
Who plays first is decided at random at the beginning of the game.

Notice the different colours between you and your opponent.
""")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.vertical)
            
            HStack {
                HStack {
                    Text("Opponent")
                        .bold()
                    Spacer()
                }
                .frame(width: 120)
                VStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.init("Opponent"))
                        .font(.largeTitle)
                        .padding(.bottom)
                    Image(systemName: "arrowtriangle.up.fill")
                        .font(.title)
                        .foregroundColor(.init("Opponent"))
                }
            }
            .padding(.vertical)
            HStack {
                HStack {
                    Text("You")
                        .bold()
                    Spacer()
                }
                .frame(width: 120)
                VStack {
                    Image(systemName: "arrowtriangle.down.fill")
                        .font(.title)
                        .foregroundColor(.init("User"))
                        .padding(.bottom)
                    Image(systemName: "person.fill")
                        .foregroundColor(.init("User"))
                        .font(.largeTitle)
                }
            }
            .padding(.top)
        }
    }
}

private struct E: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Group {
                    VStack {
                        ForEach(0 ..< 3) { _ in
                            HStack {
                                ForEach(0 ..< 3) { _ in
                                    ZStack {
                                        Rectangle()
                                            .hidden()
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color("Background"))
                                            .modifier(Neumorphic())
                                            .padding(5)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .frame(height: geo.size.width)
            }
            .padding(.top)
            Text("Board")
                .padding(.top)
                .font(Font.title.bold())
            Text("This is where the game takes place.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.bottom)
        }
    }
}

private struct F: View {
    var body: some View {
        VStack {
            Text(verbatim: "9")
                .font(Font.largeTitle.bold())
                .padding(.vertical)
            Text("""
The board has 9 cells in it.

The objective of the game is to own as many cells as possible.

The game ends when all the cells are owned, the player with the most cells wins.
""")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
    }
}

private struct G: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Group {
                    VStack {
                        ForEach(0 ..< 3) { _ in
                            HStack {
                                ForEach(0 ..< 3) { _ in
                                    ZStack {
                                        Rectangle()
                                            .hidden()
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color("Background"))
                                            .modifier(Neumorphic())
                                            .padding(5)
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .frame(height: geo.size.width)
            }
            .padding(.top)
            Bead(bead: .init(color: .blue, top: 1, bottom: 0, left: 2, right: 4))
                .padding(.vertical)
            Text("Turns")
                .padding(.top)
                .font(Font.title.bold())
            Text("During your turn drag and drop 1 of your beads into an empty cell.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.bottom)
        }
    }
}

private struct H: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Group {
                    VStack {
                        ForEach(0 ..< 3) { x in
                            HStack {
                                ForEach(0 ..< 3) { y in
                                    ZStack {
                                        Rectangle()
                                            .hidden()
                                        if x == 1 && y == 1 {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color("User"), style: .init(lineWidth: 1))
                                                .padding(5)
                                            Bead(bead: .init(color: .blue, top: 1, bottom: 0, left: 2, right: 4))
                                                .frame(width: 60, height: 60)
                                        } else {
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color("Background"))
                                                .modifier(Neumorphic())
                                                .padding(5)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .frame(height: geo.size.width)
            }
            .padding(.top)
            Text("Own")
                .padding(.top)
                .font(Font.title.bold())
            Text("When you place a bead into an empty cell you own it and your turn ends.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.bottom)
        }
    }
}

private struct I: View {
    var body: some View {
        Text("""
All beads already on the board are said to be in Defensive mode.

When you place a bead into the board this is a considered an Attack.

When placing a bead on an empty cell, your attack is matched against the defense of all the adjacent beads.

Only beads that are directly adjacent to the cell are considered for an attack, also, only beads that are in a cell that shares a side with your cell are considered. Cells sharing a corner or in diagonal are not considered.

All defenses that get overpowered by your attack become yours.
""")
            .multilineTextAlignment(.center)
            .foregroundColor(.secondary)
    }
}

private struct J: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Group {
                    VStack {
                        ForEach(0 ..< 3) { y in
                            HStack {
                                ForEach(0 ..< 3) { x in
                                    ZStack {
                                        Rectangle()
                                            .hidden()
                                        if x == 0 && y == 0 {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color("Opponent"), style: .init(lineWidth: 1))
                                                .padding(5)
                                            Bead(bead: .init(color: .green, top: 0, bottom: 1, left: 1, right: 1))
                                                .frame(width: 60, height: 60)
                                        } else {
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color("Background"))
                                                .modifier(Neumorphic())
                                                .padding(5)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .frame(height: geo.size.width)
            }
            .padding(.top)
            Bead(bead: .init(color: .blue, top: 1, bottom: 0, left: 2, right: 4))
                .padding(.vertical)
            Text("The green bead already on the board is in defensive mode.")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.bottom)
        }
    }
}

private struct K: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Group {
                    VStack {
                        ForEach(0 ..< 3) { y in
                            HStack {
                                ForEach(0 ..< 3) { x in
                                    ZStack {
                                        Rectangle()
                                            .hidden()
                                        if x == 0 && y == 0 {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color("User"), style: .init(lineWidth: 1))
                                                .padding(5)
                                            Bead(bead: .init(color: .green, top: 0, bottom: 1, left: 1, right: 1))
                                                .frame(width: 60, height: 60)
                                        } else if x == 1 && y == 0 {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color("User"), style: .init(lineWidth: 1))
                                                .padding(5)
                                            Bead(bead: .init(color: .blue, top: 1, bottom: 0, left: 2, right: 4))
                                                .frame(width: 60, height: 60)
                                        } else {
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color("Background"))
                                                .modifier(Neumorphic())
                                                .padding(5)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .frame(height: geo.size.width)
            }
            .padding(.top)
            Text("""
The defense can't hold against your attack.
Your Left (2) points are matched against the defense's Right (1).

The defending cell becomes yours.
""")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.bottom)
        }
    }
}

private struct L: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Group {
                    VStack {
                        ForEach(0 ..< 3) { y in
                            HStack {
                                ForEach(0 ..< 3) { x in
                                    ZStack {
                                        Rectangle()
                                            .hidden()
                                        if x == 0 && y == 0 {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color("Opponent"), style: .init(lineWidth: 1))
                                                .padding(5)
                                            Bead(bead: .init(color: .green, top: 0, bottom: 1, left: 1, right: 1))
                                                .frame(width: 60, height: 60)
                                        } else if x == 0 && y == 1 {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color("User"), style: .init(lineWidth: 1))
                                                .padding(5)
                                            Bead(bead: .init(color: .blue, top: 1, bottom: 0, left: 2, right: 4))
                                                .frame(width: 60, height: 60)
                                        } else {
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color("Background"))
                                                .modifier(Neumorphic())
                                                .padding(5)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .frame(height: geo.size.width)
            }
            .padding(.top)
            Text("""
In this case the defense's Bottom (1) can hold against your attack Top (1).
""")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.bottom)
        }
    }
}

private struct M: View {
    var body: some View {
        VStack {
            GeometryReader { geo in
                Group {
                    VStack {
                        ForEach(0 ..< 3) { y in
                            HStack {
                                ForEach(0 ..< 3) { x in
                                    ZStack {
                                        Rectangle()
                                            .hidden()
                                        if x == 0 && y == 0 {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color("Opponent"), style: .init(lineWidth: 1))
                                                .padding(5)
                                            Bead(bead: .init(color: .green, top: 0, bottom: 1, left: 1, right: 1))
                                                .frame(width: 60, height: 60)
                                        } else if x == 1 && y == 1 {
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(Color("User"), style: .init(lineWidth: 1))
                                                .padding(5)
                                            Bead(bead: .init(color: .blue, top: 1, bottom: 0, left: 2, right: 4))
                                                .frame(width: 60, height: 60)
                                        } else {
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color("Background"))
                                                .modifier(Neumorphic())
                                                .padding(5)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding()
                }
                .frame(height: geo.size.width)
            }
            .padding(.top)
            Text("""
In this case the cells are not adjacents and there is no attack.
""")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
                .padding(.bottom)
        }
    }
}

private struct N: View {
    var body: some View {
        Text("""
Only the side of the beads that touch between them are considered for an attack: Top against Bottom, Left against Right.

If your attack is smaller than the defense nothing happens.

You can't attack your own cells.
""")
            .multilineTextAlignment(.center)
            .foregroundColor(.secondary)
    }
}

private struct O: View {
    var body: some View {
        VStack {
            Text(verbatim: "End Game")
                .font(Font.largeTitle.bold())
                .padding(.vertical)
            Text("""
The winner can choose 1 bead from the looser and add it to their inventory.

Only beads that are selected, that is, only beads that can be used in a game can be taken as a prize.
""")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
        }
    }
}
