# AquaCoach User Guide

AquaCoach is a native iOS hydration-tracking prototype. It records beverage intake and estimates how much each drink contributes to daily hydration.

## Install from Source

### Requirements

- macOS
- Xcode 26.3 or a compatible newer version
- iOS 26.2 simulator or device

### Run

1. Clone or download the repository.
2. Open `AquaCoach.xcodeproj` in Xcode.
3. Select the AquaCoach scheme and an iOS simulator or connected device.
4. Press `Command-R`.

The prototype is not distributed through the App Store.

## Set a Daily Goal

1. Open **Settings** from the dashboard.
2. Enter a positive goal in milliliters.
3. Save the new value.

The dashboard progress bar compares today's effective hydration with this goal.

## Log a Beverage

1. Select a serving size from the quick-size controls.
2. Choose an enabled beverage.
3. Tap its **+** button.

The dashboard updates the effective hydration, raw fluid, caffeine, and calorie totals for today.

## Manage the Beverage Library

Open the beverage library to:

- Browse the built-in catalog
- Filter beverages by category
- Enable or disable dashboard beverages
- Review each beverage's hydration percentage
- Add a custom beverage and optional nutrition values

## Review Progress

Open the streak view to see:

- Current goal-completion streak
- Hydration totals for the last seven days
- Logged beverage history

## Reminder Preferences

The Settings screen stores reminder mode, schedule, active-day, snooze, message, and quick-add preferences. The current prototype does not yet schedule operating-system notifications.

## Local Data

AquaCoach stores goals, logs, beverage settings, and preferences locally using Codable data in UserDefaults. Use **Reset Data** in Settings to return the app to its defaults.

## Troubleshooting

- Confirm the selected simulator supports the project's iOS deployment target.
- In Xcode, use **Product > Clean Build Folder** if a stale build fails.
- Reopen the project if previews stop updating.
- Reset app data if saved prototype data becomes inconsistent after a model change.
