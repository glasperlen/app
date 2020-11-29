import UIKit
import Combine
import AVFoundation
import Magister
import GameKit

struct Session {
    var match = Defaults.match {
        didSet {
            Defaults.match = match
        }
    }
    
    var beads = Defaults.beads {
        didSet {
            Defaults.beads = beads
        }
    }
    
    var me: Match.State {
        multiplayer?.state ?? .second
    }
    
    var opponent: Match.State {
        switch me {
        case .first: return .second
        default: return .first
        }
    }
    
    var opponentName: String {
        guard let multiplayer = self.multiplayer else {
            return match?.robot?.name ?? ""
        }
        return multiplayer.participants.filter { $0.player != GKLocalPlayer.local }.first?.player?.displayName ?? ""
    }
    
    var multiplayer: GKTurnBasedMatch?
    private var subs = Set<AnyCancellable>()
    private var players = Set<AVAudioPlayer>()
    private let haptics = UIImpactFeedbackGenerator(style: .heavy)
    
    init() {
        haptics.prepare()
    }
    
    mutating func play(_ audio: Audio) {
        players.filter { !$0.isPlaying }.forEach {
            players.remove($0)
        }
        guard
            Defaults.settings_sound,
            let player = try? AVAudioPlayer(contentsOf: Bundle.main.url(forResource: audio.rawValue, withExtension: "aiff")!)
        else { return }
        players.insert(player)
        player.play()
    }
    
    func impact() {
        guard Defaults.settings_vibrate else { return }
        haptics.impactOccurred()
    }
}
