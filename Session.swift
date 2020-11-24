import UIKit
import Combine
import AVFoundation
import Magister

struct Session {
    var match: Match?
    var beads = Defaults.beads {
        didSet {
            Defaults.beads = beads
        }
    }
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
