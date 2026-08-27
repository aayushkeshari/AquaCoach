import Foundation
import SwiftUI

enum BeverageCategory: String, CaseIterable, Identifiable, Codable {
    case all = "All"
    case tea = "Tea"
    case coffee = "Coffee"
    case milk = "Milk"
    case sugar = "Sugar"
    case fruit = "Fruit"
    case active = "Active"
    case mocktail = "Mocktail"
    case alcohol = "Alcohol"
    case other = "Other"

    var id: String { rawValue }
}

struct Beverage: Identifiable, Hashable, Codable {
    var id = UUID()
    var name: String
    var icon: String
    var category: BeverageCategory
    var hydrationPercentage: Double
    var caffeinePer250ML: Double?
    var caloriesPer250ML: Double?
    var alcoholDescription: String?
    var isEnabled: Bool
    var order: Int
}

struct DrinkLog: Identifiable, Codable {
    var id = UUID()
    var beverage: Beverage
    var volumeML: Double
    var hydrationDelta: Double
    var caffeine: Double
    var calories: Double
    var timestamp: Date
}
