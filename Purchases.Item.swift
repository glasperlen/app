import Foundation

extension Purchases {
    enum Item: String, CaseIterable, Codable {
        case
        low = "glasperlen.low",
        medium = "glasperlen.medium",
        high = "glasperlen.high"
        
        var image: String {
            switch self {
            case .low: return "low"
            case .medium: return "medium"
            case .high: return "high"
            }
        }
        
        var title: String {
            switch self {
            case .low: return NSLocalizedString("Low 5", comment: "")
            case .medium: return NSLocalizedString("Medium 5", comment: "")
            case .high: return NSLocalizedString("High 5", comment: "")
            }
        }
        
        var subtitle: String {
            switch self {
            case .low: return NSLocalizedString("Pack of 5 new and unique beads with a low chance of having many points", comment: "")
            case .medium: return NSLocalizedString("Pack of 5 new and unique beads with a medium chance of having many points", comment: "")
            case .high: return NSLocalizedString("Pack of 5 new and unique beads with a high chance of having many points", comment: "")
            }
        }
        
        var tier: Int {
            switch self {
            case .low: return 0
            case .medium: return 30
            case .high: return 60
            }
        }
    }
}
