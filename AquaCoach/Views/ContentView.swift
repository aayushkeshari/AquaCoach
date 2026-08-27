import SwiftUI

struct ContentView: View {

    @EnvironmentObject var store: HydrationStore
    @State private var selectedAmount: Double = 250
    @State private var showLibrary = false
    @State private var showStreaks = false
    @State private var showSettings = false

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.cyan.opacity(0.16), Color.teal.opacity(0.95)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 18) {

                    topBar

                    hydrationHeader

                    statsRow

                    mascotArea

                    quickAmounts

                    beverageRow

                    recentLogsCard
                }
                .padding()
            }
        }
        .sheet(isPresented: $showLibrary) {
            BeverageLibraryView()
                .environmentObject(store)
        }
        .sheet(isPresented: $showStreaks) {
            StreaksView()
                .environmentObject(store)
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
                .environmentObject(store)
        }
    }

    private var topBar: some View {
        HStack {
            Button {
                showStreaks = true
            } label: {
                Circle()
                    .fill(Color.white.opacity(0.75))
                    .frame(width: 46, height: 46)
                    .overlay(
                        Text("\(store.streakCount)")
                            .font(.headline.bold())
                            .foregroundColor(.teal)
                    )
            }

            Spacer()

            Button {
                showSettings = true
            } label: {
                Circle()
                    .fill(Color.white.opacity(0.75))
                    .frame(width: 46, height: 46)
                    .overlay(
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.teal)
                    )
            }
        }
    }

    private var hydrationHeader: some View {
        VStack(spacing: 8) {
            Text("\(Int(store.totalHydration))ml")
                .font(.system(size: 42, weight: .bold))
                .foregroundColor(.teal)

            Text("Hydration · \(Int(store.progress * 100))% of your goal")
                .foregroundColor(.gray)
                .font(.headline)

            ProgressView(value: min(store.progress, 1.0))
                .tint(.teal)
                .scaleEffect(x: 1, y: 1.8)
                .padding(.horizontal, 16)
        }
    }

    private var statsRow: some View {
        HStack(spacing: 12) {
            statCard(title: "Fluid", value: "\(Int(store.rawFluidToday))ml", icon: "drop")
            statCard(title: "Caffeine", value: "\(Int(store.todayCaffeine))mg", icon: "bolt")
            statCard(title: "Calories", value: "\(Int(store.todayCalories))", icon: "flame")
        }
    }

    private func statCard(title: String, value: String, icon: String) -> some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .foregroundColor(.teal)
            Text(value)
                .font(.headline.bold())
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(Color.white.opacity(0.86))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    private var mascotArea: some View {
        VStack(spacing: 8) {
            ZStack {
                RoundedRectangle(cornerRadius: 36)
                    .fill(Color.white.opacity(0.18))
                    .frame(height: 240)

                VStack(spacing: 10) {
                    Image(systemName: "drop.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 110, height: 140)
                        .foregroundColor(.white.opacity(0.55))

                    Text("Tap to explore beverages")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.9))
                }
                .onTapGesture {
                    showLibrary = true
                }
            }
        }
    }

    private var quickAmounts: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(store.reminderSettings.quickAddSizes, id: \.self) { amount in
                    Button {
                        selectedAmount = amount
                    } label: {
                        Text("\(Int(amount)) ml")
                            .font(.subheadline.bold())
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .background(selectedAmount == amount ? Color.black.opacity(0.82) : Color.white.opacity(0.82))
                            .foregroundColor(selectedAmount == amount ? .white : .black)
                            .clipShape(Capsule())
                    }
                }
            }
        }
    }

    private var beverageRow: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Beverages")
                    .font(.title3.bold())
                    .foregroundColor(.white)

                Spacer()

                Button("View all") {
                    showLibrary = true
                }
                .font(.subheadline.bold())
                .foregroundColor(.white)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 18) {
                    ForEach(store.enabledBeverages) { beverage in
                        VStack(spacing: 8) {
                            Image(systemName: beverage.icon)
                                .font(.largeTitle)
                                .frame(width: 64, height: 64)
                                .background(Color.white.opacity(0.78))
                                .clipShape(RoundedRectangle(cornerRadius: 16))

                            Button {
                                store.addDrink(beverage: beverage, amount: selectedAmount)
                            } label: {
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.teal)
                                    .clipShape(Circle())
                            }

                            Text(beverage.name)
                                .font(.caption)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .frame(width: 72)

                            Text("\(Int(beverage.hydrationPercentage))%")
                                .font(.caption2)
                                .foregroundColor(beverage.hydrationPercentage < 0 ? .red.opacity(0.9) : .white.opacity(0.9))
                        }
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }

    private var recentLogsCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Recent activity")
                .font(.title3.bold())

            if store.todayLogs.isEmpty {
                Text("No drinks logged today yet.")
                    .foregroundColor(.gray)
            } else {
                ForEach(store.todayLogs.prefix(5)) { log in
                    HStack(spacing: 12) {
                        Image(systemName: log.beverage.icon)
                            .foregroundColor(.teal)
                            .frame(width: 26)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(log.beverage.name)
                                .font(.headline)
                            Text("\(Int(log.volumeML))ml · \(Int(log.hydrationDelta))ml hydration")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        VStack(alignment: .trailing, spacing: 2) {
                            if log.caffeine > 0 {
                                Text("\(Int(log.caffeine))mg")
                                    .font(.caption2)
                                    .foregroundColor(.orange)
                            }
                            if log.calories > 0 {
                                Text("\(Int(log.calories)) cal")
                                    .font(.caption2)
                                    .foregroundColor(.pink)
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .padding()
        .background(Color.white.opacity(0.9))
        .clipShape(RoundedRectangle(cornerRadius: 26))
    }
}
