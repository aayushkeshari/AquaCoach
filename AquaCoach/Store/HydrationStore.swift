import SwiftUI
import Combine

final class HydrationStore: ObservableObject {

    private var isRestoringState = false

    private enum Keys {
        static let dailyGoal = "dailyGoal"
        static let logs = "logs"
        static let beverages = "beverages"
        static let reminderSettings = "reminderSettings"
    }

    @Published var dailyGoal: Double = 3000 {
        didSet { persistChanges() }
    }

    @Published var logs: [DrinkLog] = [] {
        didSet { persistChanges() }
    }

    @Published var reminderSettings = ReminderSettings() {
        didSet { persistChanges() }
    }

    @Published var beverages: [Beverage] = [] {
        didSet { persistChanges() }
    }

    init() {
        isRestoringState = true
        loadAll()

        if beverages.isEmpty {
            beverages = Self.defaultBeverages
        }

        isRestoringState = false
        saveAll()
    }

    static let defaultBeverages: [Beverage] = [
        Beverage(name: "Water", icon: "drop.fill", category: .other, hydrationPercentage: 100, caffeinePer250ML: nil, caloriesPer250ML: 0, alcoholDescription: nil, isEnabled: true, order: 0),
        Beverage(name: "Coconut Water", icon: "leaf.fill", category: .fruit, hydrationPercentage: 90, caffeinePer250ML: nil, caloriesPer250ML: 45, alcoholDescription: nil, isEnabled: true, order: 1),
        Beverage(name: "Milk", icon: "cup.and.saucer.fill", category: .milk, hydrationPercentage: 130, caffeinePer250ML: nil, caloriesPer250ML: 150, alcoholDescription: nil, isEnabled: true, order: 2),
        Beverage(name: "Yogurt", icon: "takeoutbag.and.cup.and.straw.fill", category: .milk, hydrationPercentage: 70, caffeinePer250ML: nil, caloriesPer250ML: 140, alcoholDescription: nil, isEnabled: true, order: 3),
        Beverage(name: "Coffee", icon: "cup.and.saucer", category: .coffee, hydrationPercentage: 60, caffeinePer250ML: 100, caloriesPer250ML: 5, alcoholDescription: nil, isEnabled: true, order: 4),
        Beverage(name: "Latte", icon: "mug.fill", category: .coffee, hydrationPercentage: 60, caffeinePer250ML: 77, caloriesPer250ML: 120, alcoholDescription: nil, isEnabled: true, order: 5),
        Beverage(name: "Soup", icon: "bowl.fill", category: .other, hydrationPercentage: 60, caffeinePer250ML: nil, caloriesPer250ML: 90, alcoholDescription: nil, isEnabled: false, order: 6),
        Beverage(name: "Green Tea", icon: "leaf.circle.fill", category: .tea, hydrationPercentage: 90, caffeinePer250ML: 25, caloriesPer250ML: 0, alcoholDescription: nil, isEnabled: false, order: 7),
        Beverage(name: "Juice", icon: "takeoutbag.and.cup.and.straw", category: .fruit, hydrationPercentage: 95, caffeinePer250ML: nil, caloriesPer250ML: 110, alcoholDescription: nil, isEnabled: false, order: 8),
        Beverage(name: "Smoothie", icon: "carrot.fill", category: .fruit, hydrationPercentage: 70, caffeinePer250ML: nil, caloriesPer250ML: 180, alcoholDescription: nil, isEnabled: false, order: 9),
        Beverage(name: "Soda", icon: "sparkles", category: .sugar, hydrationPercentage: 80, caffeinePer250ML: 35, caloriesPer250ML: 100, alcoholDescription: nil, isEnabled: false, order: 10),
        Beverage(name: "Energy Drink", icon: "bolt.fill", category: .active, hydrationPercentage: 55, caffeinePer250ML: 80, caloriesPer250ML: 110, alcoholDescription: nil, isEnabled: false, order: 11),
        Beverage(name: "Sports Drink", icon: "figure.run", category: .active, hydrationPercentage: 96, caffeinePer250ML: nil, caloriesPer250ML: 80, alcoholDescription: nil, isEnabled: false, order: 12),
        Beverage(name: "Tea Latte", icon: "cup.and.saucer.fill", category: .tea, hydrationPercentage: 100, caffeinePer250ML: 35, caloriesPer250ML: 90, alcoholDescription: nil, isEnabled: false, order: 13),
        Beverage(name: "Black Tea", icon: "cup.and.saucer.fill", category: .tea, hydrationPercentage: 90, caffeinePer250ML: 47, caloriesPer250ML: 0, alcoholDescription: nil, isEnabled: false, order: 14),
        Beverage(name: "Oolong Tea", icon: "cup.and.saucer.fill", category: .tea, hydrationPercentage: 90, caffeinePer250ML: 46, caloriesPer250ML: 0, alcoholDescription: nil, isEnabled: false, order: 15),
        Beverage(name: "Matcha", icon: "leaf.fill", category: .tea, hydrationPercentage: 90, caffeinePer250ML: 70, caloriesPer250ML: 5, alcoholDescription: nil, isEnabled: false, order: 16),
        Beverage(name: "Protein Shake", icon: "dumbbell.fill", category: .active, hydrationPercentage: 80, caffeinePer250ML: nil, caloriesPer250ML: 180, alcoholDescription: nil, isEnabled: false, order: 17),
        Beverage(name: "Beer", icon: "takeoutbag.and.cup.and.straw", category: .alcohol, hydrationPercentage: -40, caffeinePer250ML: nil, caloriesPer250ML: 110, alcoholDescription: "Light alcohol", isEnabled: false, order: 18),
        Beverage(name: "Red Wine", icon: "wineglass.fill", category: .alcohol, hydrationPercentage: -95, caffeinePer250ML: nil, caloriesPer250ML: 120, alcoholDescription: "Medium alcohol", isEnabled: false, order: 19),
        Beverage(name: "White Wine", icon: "wineglass.fill", category: .alcohol, hydrationPercentage: -95, caffeinePer250ML: nil, caloriesPer250ML: 120, alcoholDescription: "Medium alcohol", isEnabled: false, order: 20),
        Beverage(name: "Shot", icon: "figure.barre", category: .alcohol, hydrationPercentage: -159, caffeinePer250ML: nil, caloriesPer250ML: 150, alcoholDescription: "Medium alcohol", isEnabled: false, order: 21),
        Beverage(name: "Whiskey", icon: "flame.fill", category: .alcohol, hydrationPercentage: -318, caffeinePer250ML: nil, caloriesPer250ML: 160, alcoholDescription: "Strong alcohol", isEnabled: false, order: 22),
        Beverage(name: "Vodka", icon: "drop.triangle.fill", category: .alcohol, hydrationPercentage: -318, caffeinePer250ML: nil, caloriesPer250ML: 160, alcoholDescription: "Strong alcohol", isEnabled: false, order: 23),
        Beverage(name: "Rum", icon: "water.waves", category: .alcohol, hydrationPercentage: -318, caffeinePer250ML: nil, caloriesPer250ML: 160, alcoholDescription: "Strong alcohol", isEnabled: false, order: 24),
        Beverage(name: "Tequila", icon: "sun.max.fill", category: .alcohol, hydrationPercentage: -318, caffeinePer250ML: nil, caloriesPer250ML: 160, alcoholDescription: "Strong alcohol", isEnabled: false, order: 25),
        Beverage(name: "Gin & Tonic", icon: "party.popper.fill", category: .mocktail, hydrationPercentage: -20, caffeinePer250ML: nil, caloriesPer250ML: 130, alcoholDescription: "Subtle alcohol", isEnabled: false, order: 26),
        Beverage(name: "Virgin Mojito", icon: "leaf.circle", category: .mocktail, hydrationPercentage: 90, caffeinePer250ML: nil, caloriesPer250ML: 80, alcoholDescription: nil, isEnabled: false, order: 27),
        Beverage(name: "Sparkling Water", icon: "bubbles.and.sparkles.fill", category: .other, hydrationPercentage: 100, caffeinePer250ML: nil, caloriesPer250ML: 0, alcoholDescription: nil, isEnabled: false, order: 28),
        Beverage(name: "Soy Milk", icon: "carton.fill", category: .milk, hydrationPercentage: 90, caffeinePer250ML: nil, caloriesPer250ML: 100, alcoholDescription: nil, isEnabled: false, order: 29),
        Beverage(name: "Oat Milk", icon: "carton.fill", category: .milk, hydrationPercentage: 89, caffeinePer250ML: nil, caloriesPer250ML: 110, alcoholDescription: nil, isEnabled: false, order: 30)
    ]

    var totalHydration: Double {
        todayLogs.reduce(0) { $0 + $1.hydrationDelta }
    }

    var progress: Double {
        guard dailyGoal > 0 else { return 0 }
        return max(0, totalHydration / dailyGoal)
    }

    var enabledBeverages: [Beverage] {
        beverages
            .filter { $0.isEnabled }
            .sorted { $0.order < $1.order }
    }

    var todayLogs: [DrinkLog] {
        let calendar = Calendar.current
        return logs.filter { calendar.isDateInToday($0.timestamp) }
    }

    var todayCalories: Double {
        todayLogs.reduce(0) { $0 + $1.calories }
    }

    var todayCaffeine: Double {
        todayLogs.reduce(0) { $0 + $1.caffeine }
    }

    var rawFluidToday: Double {
        todayLogs.reduce(0) { $0 + $1.volumeML }
    }

    func totalHydration(on date: Date) -> Double {
        let calendar = Calendar.current
        return logs
            .filter { calendar.isDate($0.timestamp, inSameDayAs: date) }
            .reduce(0) { $0 + $1.hydrationDelta }
    }

    func last7DaysHydration() -> [(date: Date, amount: Double)] {
        let calendar = Calendar.current
        let today = Date()

        return (0..<7).compactMap { offset in
            guard let date = calendar.date(byAdding: .day, value: -offset, to: today) else { return nil }
            return (date: date, amount: totalHydration(on: date))
        }.reversed()
    }

    var streakCount: Int {
        let calendar = Calendar.current
        var streak = 0

        for offset in 0..<365 {
            guard let date = calendar.date(byAdding: .day, value: -offset, to: Date()) else { break }
            if totalHydration(on: date) >= dailyGoal {
                streak += 1
            } else {
                break
            }
        }

        return streak
    }

    func addDrink(beverage: Beverage, amount: Double) {
        let delta = HydrationEngine.hydrationDelta(volumeML: amount, percentage: beverage.hydrationPercentage)
        let caffeine = HydrationEngine.caffeine(volumeML: amount, per250: beverage.caffeinePer250ML)
        let calories = HydrationEngine.calories(volumeML: amount, per250: beverage.caloriesPer250ML)

        let log = DrinkLog(
            beverage: beverage,
            volumeML: amount,
            hydrationDelta: delta,
            caffeine: caffeine,
            calories: calories,
            timestamp: Date()
        )

        logs.insert(log, at: 0)
    }

    func toggleBeverage(_ beverage: Beverage) {
        guard let index = beverages.firstIndex(where: { $0.id == beverage.id }) else { return }
        beverages[index].isEnabled.toggle()
    }

    func toggleDay(_ day: Int) {
        if reminderSettings.activeDays.contains(day) {
            reminderSettings.activeDays.remove(day)
        } else {
            reminderSettings.activeDays.insert(day)
        }
    }

    func addCustomBeverage(
        name: String,
        icon: String,
        category: BeverageCategory,
        hydrationPercentage: Double,
        caffeinePer250ML: Double?,
        caloriesPer250ML: Double?,
        alcoholDescription: String?
    ) {
        let nextOrder = (beverages.map { $0.order }.max() ?? 0) + 1

        let beverage = Beverage(
            name: name,
            icon: icon,
            category: category,
            hydrationPercentage: hydrationPercentage,
            caffeinePer250ML: caffeinePer250ML,
            caloriesPer250ML: caloriesPer250ML,
            alcoholDescription: alcoholDescription,
            isEnabled: true,
            order: nextOrder
        )

        beverages.append(beverage)
    }

    func resetAllData() {
        dailyGoal = 3000
        logs = []
        reminderSettings = ReminderSettings()
        beverages = Self.defaultBeverages
        saveAll()
    }

    private func saveAll() {
        PersistenceManager.shared.saveDouble(dailyGoal, forKey: Keys.dailyGoal)
        PersistenceManager.shared.save(logs, forKey: Keys.logs)
        PersistenceManager.shared.save(beverages, forKey: Keys.beverages)
        PersistenceManager.shared.save(reminderSettings, forKey: Keys.reminderSettings)
    }

    private func persistChanges() {
        guard !isRestoringState else { return }
        saveAll()
    }

    private func loadAll() {
        dailyGoal = PersistenceManager.shared.loadDouble(forKey: Keys.dailyGoal, defaultValue: 3000)

        if let savedLogs = PersistenceManager.shared.load([DrinkLog].self, forKey: Keys.logs) {
            logs = savedLogs
        }

        if let savedBeverages = PersistenceManager.shared.load([Beverage].self, forKey: Keys.beverages) {
            beverages = savedBeverages
        }

        if let savedSettings = PersistenceManager.shared.load(ReminderSettings.self, forKey: Keys.reminderSettings) {
            reminderSettings = savedSettings
        }
    }
}
