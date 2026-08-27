import SwiftUI

struct StreaksView: View {
    @EnvironmentObject var store: HydrationStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.white, Color.cyan.opacity(0.15)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {

                    HStack {
                        Spacer()

                        Button {
                            dismiss()
                        } label: {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 44, height: 44)
                                .overlay(
                                    Image(systemName: "xmark")
                                        .foregroundColor(.black)
                                )
                        }
                    }
                    .padding(.horizontal)

                    VStack(spacing: 10) {
                        ZStack {
                            Circle()
                                .fill(Color.cyan)
                                .frame(width: 140, height: 140)

                            VStack {
                                Text("\(Int(store.progress * 100))%")
                                    .font(.system(size: 34, weight: .bold))
                                    .foregroundColor(.white)

                                Text("TODAY'S\nHYDRATION")
                                    .font(.caption.bold())
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                            }
                        }

                        Text("Current streak: \(store.streakCount) day\(store.streakCount == 1 ? "" : "s")")
                            .font(.headline)
                    }

                    VStack(alignment: .leading, spacing: 18) {
                        Text("Last 7 days")
                            .font(.title2.bold())

                        SevenDayChartView(data: store.last7DaysHydration())
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 28))

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Today's activity")
                            .font(.title2.bold())

                        if store.todayLogs.isEmpty {
                            Text("No drinks logged today yet.")
                                .foregroundColor(.gray)
                        } else {
                            ForEach(store.todayLogs) { log in
                                HStack {
                                    Image(systemName: log.beverage.icon)
                                        .foregroundColor(.teal)
                                        .frame(width: 28)

                                    VStack(alignment: .leading) {
                                        Text(log.beverage.name)
                                            .font(.headline)
                                        Text("\(Int(log.volumeML))ml · \(Int(log.hydrationDelta))ml hydration")
                                            .font(.caption)
                                            .foregroundColor(.gray)
                                    }

                                    Spacer()

                                    Text(timeString(from: log.timestamp))
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                                .padding(.vertical, 6)
                            }
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 28))
                }
                .padding()
            }
        }
    }

    func timeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

struct SevenDayChartView: View {
    let data: [(date: Date, amount: Double)]

    var body: some View {
        HStack(alignment: .bottom, spacing: 14) {
            ForEach(Array(data.enumerated()), id: \.offset) { _, item in
                VStack {
                    Spacer()

                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.cyan)
                        .frame(width: 28, height: max(barHeight(for: item.amount), 8))

                    Text(shortDay(item.date))
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, minHeight: 180)
            }
        }
        .frame(height: 200)
    }

    func barHeight(for amount: Double) -> CGFloat {
        let maxHeight: CGFloat = 140
        let normalized = min(max(amount / 3000.0, 0), 1.0)
        return maxHeight * normalized
    }

    func shortDay(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter.string(from: date)
    }
}
