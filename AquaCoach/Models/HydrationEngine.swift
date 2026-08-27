import Foundation

struct HydrationEngine {

    static func hydrationDelta(volumeML: Double, percentage: Double) -> Double {
        return volumeML * (percentage / 100.0)
    }

    static func caffeine(volumeML: Double, per250: Double?) -> Double {
        guard let per250 else { return 0 }
        return (volumeML / 250.0) * per250
    }

    static func calories(volumeML: Double, per250: Double?) -> Double {
        guard let per250 else { return 0 }
        return (volumeML / 250.0) * per250
    }
}
