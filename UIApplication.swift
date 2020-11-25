import Foundation
import GameKit
import Magister

extension UIApplication: GKTurnBasedMatchmakerViewControllerDelegate, GKLocalPlayerListener {
    public func player(_: GKPlayer, receivedTurnEventFor event: GKTurnBasedMatch, didBecomeActive: Bool) {
        print("turn received \(didBecomeActive)")
        if event.participants.last?.status == .matching && didBecomeActive {
            var match = Match()
            match.multiplayer()
            match.data.map {
                event.endTurn(withNextParticipants: [event.participants.last!], turnTimeout: 100000, match: $0) { _ in
                    Defaults.id = event.matchID
                }
            }
        }
        windows.first?.rootViewController?.dismiss(animated: true)
    }
    
    public func player(_ player: GKPlayer, wantsToQuitMatch: GKTurnBasedMatch) {
        if player == GKLocalPlayer.local {
            wantsToQuitMatch.participantQuitInTurn(with: .quit, nextParticipants: wantsToQuitMatch.participants, turnTimeout: 0, match: wantsToQuitMatch.matchData ?? .init()) { _ in
                Defaults.id = nil
            }
        }
        
//        match.endMatchInTurn(withMatch: .init()) { e in
//            print("ended error \(e)")
//        }
    }
    
    public func turnBasedMatchmakerViewController(_ controller: GKTurnBasedMatchmakerViewController, didFailWithError: Error) {
        controller.dismiss(animated: true)
    }
    
    public func turnBasedMatchmakerViewControllerWasCancelled(_ controller: GKTurnBasedMatchmakerViewController) {
        controller.dismiss(animated: true)
    }
    
    func auth() {
        guard !GKLocalPlayer.local.isAuthenticated else { return }
        GKLocalPlayer.local.authenticateHandler = { controller, error in
            guard let controller = controller else {
                if error == nil {
                    GKLocalPlayer.local.register(self)
                } else {
                    self.signIn()
                }
                return
            }
            self.present(controller)
        }
    }
    
    func leaderboards() {
        guard GKLocalPlayer.local.isAuthenticated else {
            signIn()
            return
        }
        GKAccessPoint.shared.trigger(state: .leaderboards) { }
    }
    
    func victory() {
        Defaults.victories += 1
        guard GKLocalPlayer.local.isAuthenticated else { return }
        GKLeaderboard.submitScore(Defaults.victories, context: 0, player: GKLocalPlayer.local, leaderboardIDs: ["glasperlen.victories"]) { _ in }
    }
    
    func requestMatch() {
        guard GKLocalPlayer.local.isAuthenticated else {
            signIn()
            return
        }
        let request = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 2
        
        let controller = GKTurnBasedMatchmakerViewController(matchRequest: request)
        controller.turnBasedMatchmakerDelegate = self
        controller.showExistingMatches = false
        present(controller)
    }
    
    private func signIn() {
        let alert = UIAlertController(title: "Game Center account not found", message: "You can sign in on Settings", preferredStyle: .actionSheet)
        alert.addAction(.init(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
        alert.addAction(.init(title: NSLocalizedString("Settings", comment: ""), style: .default) { _ in
            self.open(URL(string: UIApplication.openSettingsURLString)!)
        })
        self.present(alert)
    }
    
    private func present(_ controller: UIViewController) {
        guard var root = windows.first?.rootViewController else { return }
        while let presented = root.presentedViewController {
            root = presented
        }
        root.present(controller, animated: true)
    }
}
