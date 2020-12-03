import UIKit
import Combine
import AVFoundation
import Magister

struct Session {
    var match = Defaults.match {
        didSet {
            guard Defaults.game == nil else {
                Defaults.match = nil
                return
            }
            Defaults.match = match
        }
    }
    
    var beads = Defaults.beads {
        didSet {
            Defaults.beads = beads
        }
    }
    
    var multiplayer: Bool {
        match.map {
            switch $0.state {
            case .new: return false
            case .matching, .cancel: return true
            default: return !$0[.first].id.isEmpty && !$0[.second].id.isEmpty
            }
        } ?? false
    }
    
    private var subs = Set<AnyCancellable>()
    private var audios = Set<AVAudioPlayer>()
    private let haptics = UIImpactFeedbackGenerator(style: .heavy)
    let purchases = Purchases()
    
    init() {
        haptics.prepare()
    }
    
    mutating func play(_ audio: Audio) {
        audios.filter { !$0.isPlaying }.forEach {
            audios.remove($0)
        }
        guard
            Defaults.settings_sound,
            let audio = try? AVAudioPlayer(contentsOf: Bundle.main.url(forResource: audio.rawValue, withExtension: "aiff")!)
        else { return }
        audios.insert(audio)
        audio.play()
    }
    
    func impact() {
        guard Defaults.settings_vibrate else { return }
        haptics.impactOccurred()
    }
    
    subscript (_ turn: Match.Turn) -> Bool {
        match?[turn].id == Defaults.id 
    }
}
