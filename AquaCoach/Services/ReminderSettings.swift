import Foundation

enum ReminderMode: String, CaseIterable, Identifiable, Codable {
    case smart = "Smart reminders"
    case custom = "Custom reminders"

    var id: String { rawValue }
}

struct ReminderSettings: Codable {
    var remindersEnabled: Bool = true
    var mode: ReminderMode = .smart

    var intervalMinutes: Double = 60
    var secondaryIntervalMinutes: Double = 30

    var fromHour: Int = 9
    var untilHour: Int = 21

    var activeDays: Set<Int> = Set([1, 2, 3, 4, 5, 6, 7])

    var snoozeMinutes: Int = 5
    var stopWhenGoalReached: Bool = true
    var hydrationProgressTitle: Bool = true
    var motivationalTitle: Bool = true
    var hydrationFacts: Bool = true

    var customMessage: String = "Time to hydrate 💧"

    var quickAddSizes: [Double] = [120, 250, 330, 500, 1000]
}
