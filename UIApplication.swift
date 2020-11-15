import Foundation
import GameKit

extension UIApplication {
    func auth() {
        GKLocalPlayer.local.authenticateHandler = { controller, error in
            guard let controller = controller else {
                if let error = error?.localizedDescription {
                    let alert = UIAlertController(title: error, message: nil, preferredStyle: .actionSheet)
                    alert.addAction(.init(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: nil))
                    alert.addAction(.init(title: NSLocalizedString("Settings", comment: ""), style: .default) { _ in
                        self.open(URL(string: UIApplication.openSettingsURLString)!)
                    })
                    self.windows.first!.rootViewController!.present(alert, animated: true)
                }
                return
            }
            self.windows.first!.rootViewController!.present(controller, animated: true)
        }
    }
    
    func leaderboards() {
        GKAccessPoint.shared.trigger(state: .leaderboards) { }
    }
    
    func victories(_ score: Int) {
        guard GKLocalPlayer.local.isAuthenticated else { return }
        GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local, leaderboardIDs: ["glasperlen.victories"]) { _ in }
    }
}
