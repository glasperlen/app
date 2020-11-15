import Foundation
import GameKit
import Combine

extension Delegate {
    final class Game: NSObject {
        let error = PassthroughSubject<String, Never>()
        
        func auth() {
            GKLocalPlayer.local.authenticateHandler = { _, error in
                guard let error = error?.localizedDescription else {
                    GKAccessPoint.shared.isActive = GKLocalPlayer.local.isAuthenticated
                    return
                }
                self.error.send(error)
            }
//            guard GKLocalPlayer.local.isAuthenticated else {
//                error.send()
//                return
//            }
//            let controller = GKGameCenterViewController()
//            controller.viewState = .leaderboards
//            controller.gameCenterDelegate = self
//            controller.leaderboardIdentifier = "glasperlen.victories"
        }
    }
}
