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
    
    private var subs = Set<AnyCancellable>()
    private var audios = Set<AVAudioPlayer>()
    private let haptics = UIImpactFeedbackGenerator(style: .heavy)
    
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
