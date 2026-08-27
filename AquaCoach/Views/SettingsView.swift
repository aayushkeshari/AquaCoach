import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var store: HydrationStore
    @Environment(\.dismiss) private var dismiss

    @State private var showResetAlert = false
    @State private var dailyGoalText = ""

    let weekdayLabels = [
        (1, "S"),
        (2, "M"),
        (3, "T"),
        (4, "W"),
        (5, "T"),
        (6, "F"),
        (7, "S")
    ]

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.white, Color.cyan.opacity(0.12)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 20) {

                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 44, height: 44)
                                .overlay(
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(.black)
                                )
                        }

                        Spacer()

                        Text("Hydration Reminders")
                            .font(.system(size: 26, weight: .bold))

                        Spacer()

                        Circle()
                            .fill(Color.clear)
                            .frame(width: 44, height: 44)
                    }
                    .padding(.horizontal)

                    settingsCard {
                        VStack(alignment: .leading, spacing: 14) {
                            Text("Daily Goal")
                                .font(.headline)

                            HStack {
                                TextField("Goal in ml", text: $dailyGoalText)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(.roundedBorder)

                                Button("Save") {
                                    if let value = Double(dailyGoalText), value > 0 {
                                        store.dailyGoal = value
                                    }
                                }
                                .buttonStyle(.borderedProminent)
                                .tint(.teal)
                            }

                            Text("Current goal: \(Int(store.dailyGoal)) ml")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }

                    settingsCard {
                        Toggle("Hydration Reminders", isOn: $store.reminderSettings.remindersEnabled)
                            .tint(.teal)
                    }

                    settingsCard {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Reminder type")
                                .font(.headline)

                            HStack(spacing: 12) {
                                ForEach(ReminderMode.allCases) { mode in
                                    Button {
                                        store.reminderSettings.mode = mode
                                    } label: {
                                        Text(mode.rawValue)
                                            .font(.subheadline.bold())
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 10)
                                            .background(
                                                store.reminderSettings.mode == mode
                                                ? Color.black.opacity(0.85)
                                                : Color.gray.opacity(0.12)
                                            )
                                            .foregroundColor(
                                                store.reminderSettings.mode == mode ? .white : .black
                                            )
                                            .clipShape(Capsule())
                                    }
                                }
                            }

                            VStack(alignment: .leading, spacing: 12) {
                                Text("Notification Interval")
                                    .font(.subheadline.bold())

                                HStack {
                                    Text("\(Int(store.reminderSettings.intervalMinutes)) min")
                                    Slider(value: $store.reminderSettings.intervalMinutes, in: 15...180, step: 15)
                                        .tint(.teal)
                                }

                                Text("Extra Buffer")
                                    .font(.subheadline.bold())

                                HStack {
                                    Text("\(Int(store.reminderSettings.secondaryIntervalMinutes)) min")
                                    Slider(value: $store.reminderSettings.secondaryIntervalMinutes, in: 0...120, step: 5)
                                        .tint(.teal)
                                }
                            }

                            HStack {
                                VStack(alignment: .leading) {
                                    Text("From")
                                        .font(.subheadline.bold())
                                    Stepper("\(formattedHour(store.reminderSettings.fromHour))", value: $store.reminderSettings.fromHour, in: 0...23)
                                }

                                Spacer()

                                VStack(alignment: .leading) {
                                    Text("Until")
                                        .font(.subheadline.bold())
                                    Stepper("\(formattedHour(store.reminderSettings.untilHour))", value: $store.reminderSettings.untilHour, in: 0...23)
                                }
                            }

                            Text("Repeat on")
                                .font(.subheadline.bold())

                            HStack(spacing: 10) {
                                ForEach(weekdayLabels, id: \.0) { day, label in
                                    Button {
                                        store.toggleDay(day)
                                    } label: {
                                        Text(label)
                                            .font(.headline)
                                            .frame(width: 38, height: 38)
                                            .background(
                                                store.reminderSettings.activeDays.contains(day)
                                                ? Color.teal
                                                : Color.gray.opacity(0.15)
                                            )
                                            .foregroundColor(
                                                store.reminderSettings.activeDays.contains(day)
                                                ? .white
                                                : .black
                                            )
                                            .clipShape(Circle())
                                    }
                                }
                            }
                        }
                    }

                    settingsCard {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Behavior")
                                .font(.headline)

                            Stepper("Snooze: \(store.reminderSettings.snoozeMinutes) min", value: $store.reminderSettings.snoozeMinutes, in: 1...30)

                            Toggle("Stop when Goal is reached", isOn: $store.reminderSettings.stopWhenGoalReached)
                                .tint(.teal)

                            Toggle("Hydration Progress title", isOn: $store.reminderSettings.hydrationProgressTitle)
                                .tint(.teal)

                            Toggle("Motivational title", isOn: $store.reminderSettings.motivationalTitle)
                                .tint(.teal)

                            Toggle("Hydration Facts", isOn: $store.reminderSettings.hydrationFacts)
                                .tint(.teal)

                            VStack(alignment: .leading, spacing: 8) {
                                Text("Custom message")
                                    .font(.subheadline.bold())

                                TextField("Type your custom reminder", text: $store.reminderSettings.customMessage)
                                    .textFieldStyle(.roundedBorder)
                            }
                        }
                    }

                    settingsCard {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Quick adding")
                                .font(.headline)

                            ForEach(store.reminderSettings.quickAddSizes.indices, id: \.self) { index in
                                Stepper(
                                    "\(Int(store.reminderSettings.quickAddSizes[index])) ml",
                                    value: $store.reminderSettings.quickAddSizes[index],
                                    in: 50...1500,
                                    step: 10
                                )
                            }
                        }
                    }

                    settingsCard {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Danger Zone")
                                .font(.headline)
                                .foregroundColor(.red)

                            Text("Reset all drinks, beverages, settings, and custom data.")
                                .font(.caption)
                                .foregroundColor(.gray)

                            Button(role: .destructive) {
                                showResetAlert = true
                            } label: {
                                Text("Reset App Data")
                                    .frame(maxWidth: .infinity)
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            dailyGoalText = "\(Int(store.dailyGoal))"
        }
        .alert("Reset all app data?", isPresented: $showResetAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Reset", role: .destructive) {
                store.resetAllData()
                dailyGoalText = "\(Int(store.dailyGoal))"
            }
        } message: {
            Text("This will remove your drink history, custom beverages, and reminder settings.")
        }
    }

    @ViewBuilder
    func settingsCard<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            content()
        }
        .padding()
        .background(Color.white.opacity(0.92))
        .clipShape(RoundedRectangle(cornerRadius: 26))
    }

    func formattedHour(_ hour: Int) -> String {
        let suffix = hour >= 12 ? "PM" : "AM"
        let normalized = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour)
        return "\(normalized):00 \(suffix)"
    }
}
