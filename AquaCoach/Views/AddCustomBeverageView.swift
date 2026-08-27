import SwiftUI

struct AddCustomBeverageView: View {
    @EnvironmentObject var store: HydrationStore
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var icon = "drop.fill"
    @State private var category: BeverageCategory = .other
    @State private var hydrationPercentage = "100"
    @State private var caffeine = ""
    @State private var calories = ""
    @State private var alcoholDescription = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Basic") {
                    TextField("Beverage name", text: $name)
                    TextField("SF Symbol icon", text: $icon)
                    Picker("Category", selection: $category) {
                        ForEach(BeverageCategory.allCases.filter { $0 != .all }) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                }

                Section("Hydration Logic") {
                    TextField("Hydration %", text: $hydrationPercentage)
                        .keyboardType(.numbersAndPunctuation)

                    Text("Examples: Water = 100, Tea = 90, Milk = 130, Wine = -95")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Section("Optional Metadata") {
                    TextField("Caffeine per 250ml", text: $caffeine)
                        .keyboardType(.numbersAndPunctuation)

                    TextField("Calories per 250ml", text: $calories)
                        .keyboardType(.numbersAndPunctuation)

                    TextField("Alcohol description", text: $alcoholDescription)
                }
            }
            .navigationTitle("Add Beverage")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        saveBeverage()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }

    private func saveBeverage() {
        let hydration = Double(hydrationPercentage) ?? 100
        let caffeineValue = Double(caffeine)
        let caloriesValue = Double(calories)
        let alcoholValue = alcoholDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? nil : alcoholDescription

        store.addCustomBeverage(
            name: name,
            icon: icon.isEmpty ? "drop.fill" : icon,
            category: category,
            hydrationPercentage: hydration,
            caffeinePer250ML: caffeineValue,
            caloriesPer250ML: caloriesValue,
            alcoholDescription: alcoholValue
        )

        dismiss()
    }
}
