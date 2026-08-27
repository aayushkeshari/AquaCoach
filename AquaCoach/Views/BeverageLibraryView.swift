import SwiftUI

struct BeverageLibraryView: View {
    @EnvironmentObject var store: HydrationStore
    @Environment(\.dismiss) private var dismiss

    @State private var selectedCategory: BeverageCategory = .all
    @State private var showScience = false
    @State private var showAddCustom = false

    var filteredBeverages: [Beverage] {
        if selectedCategory == .all {
            return store.beverages.sorted { $0.order < $1.order }
        } else {
            return store.beverages
                .filter { $0.category == selectedCategory }
                .sorted { $0.order < $1.order }
        }
    }

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.white, Color.cyan.opacity(0.1)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {

                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 42, height: 42)
                            .overlay(
                                Image(systemName: "chevron.left")
                                    .foregroundColor(.black)
                            )
                    }

                    Spacer()

                    Text("Beverages")
                        .font(.system(size: 28, weight: .bold))

                    Spacer()

                    Button {
                        showAddCustom = true
                    } label: {
                        Text("+ Add")
                            .font(.subheadline.bold())
                            .foregroundColor(.teal)
                    }
                }
                .padding(.horizontal)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(BeverageCategory.allCases) { category in
                            Button {
                                selectedCategory = category
                            } label: {
                                Text(category.rawValue)
                                    .font(.subheadline.bold())
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .background(
                                        selectedCategory == category
                                        ? Color.black.opacity(0.85)
                                        : Color.white.opacity(0.9)
                                    )
                                    .foregroundColor(
                                        selectedCategory == category ? .white : .gray
                                    )
                                    .clipShape(Capsule())
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                ScrollView {
                    VStack(spacing: 14) {
                        ForEach(filteredBeverages) { beverage in
                            BeverageRow(beverage: beverage)
                        }

                        Button {
                            showScience = true
                        } label: {
                            Text("See how beverages impact your hydration")
                                .font(.headline)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.teal)
                                .padding(.vertical, 24)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 30)
                }
            }
            .padding(.top)
        }
        .sheet(isPresented: $showScience) {
            HydrationScienceView()
        }
        .sheet(isPresented: $showAddCustom) {
            AddCustomBeverageView()
                .environmentObject(store)
        }
    }
}

struct BeverageRow: View {
    @EnvironmentObject var store: HydrationStore
    let beverage: Beverage

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: beverage.icon)
                .font(.title2)
                .foregroundColor(.teal)
                .frame(width: 32)

            VStack(alignment: .leading, spacing: 4) {
                Text(beverage.name)
                    .font(.headline)

                if let alcohol = beverage.alcoholDescription {
                    Text(alcohol)
                        .font(.caption)
                        .foregroundColor(.gray)
                } else if let caffeine = beverage.caffeinePer250ML {
                    Text("\(Int(caffeine))mg caffeine")
                        .font(.caption)
                        .foregroundColor(.gray)
                } else if let calories = beverage.caloriesPer250ML {
                    Text("\(Int(calories)) cal / 250ml")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }

            Spacer()

            Text("\(Int(beverage.hydrationPercentage))%")
                .foregroundColor(beverage.hydrationPercentage < 0 ? .red : .gray)

            Toggle("", isOn: Binding(
                get: { beverage.isEnabled },
                set: { _ in
                    store.toggleBeverage(beverage)
                }
            ))
            .labelsHidden()
            .tint(.teal)
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}
