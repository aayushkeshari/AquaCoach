# AquaCoach

**A native iOS hydration tracker that measures the effective hydration contribution of different beverages.**

AquaCoach is a SwiftUI capstone project designed to make daily hydration tracking more realistic than a water-only counter. Users can log beverages, apply beverage-specific hydration ratios, monitor daily progress, and review seven-day trends from a single offline-first iOS app.

> AquaCoach is an educational prototype, not medical software. Hydration ratios and nutritional estimates are informational and should not replace professional health guidance.

## Current Features

- Log intake using configurable serving sizes
- Choose from 31 built-in beverages across water, tea, coffee, milk, fruit, sports, and alcohol categories
- Calculate effective hydration using a beverage-specific positive or negative ratio
- Track daily raw fluid, effective hydration, caffeine, and calorie estimates
- Add custom beverages with user-defined hydration and nutrition values
- Enable or disable beverages shown on the main dashboard
- Set a manual daily hydration goal
- Review recent activity, seven-day hydration totals, and goal-completion streaks
- Persist goals, logs, beverage settings, and reminder preferences locally
- Configure the prototype reminder experience and quick-add sizes

## Hydration Engine

Each intake entry is converted into an effective hydration value:

```text
effective hydration = beverage volume x (hydration percentage / 100)
```

Positive ratios add to daily progress. Negative ratios model a hydration penalty and reduce the effective total. The engine also scales caffeine and calorie estimates from their values per 250 ml.

## Architecture

| Component | Responsibility |
| --- | --- |
| SwiftUI views | Dashboard, beverage library, custom beverage form, settings, science information, and streak history |
| `HydrationStore` | Shared observable state, intake workflows, daily aggregates, streak calculation, and persistence coordination |
| `HydrationEngine` | Effective hydration, caffeine, and calorie calculations |
| Codable models | Beverage definitions, intake records, categories, and reminder preferences |
| `PersistenceManager` | JSON encoding and local storage through `UserDefaults` |

## Tech Stack

- Swift 5
- SwiftUI
- Combine and `ObservableObject`
- Foundation and Codable
- UserDefaults local persistence
- Xcode 26.3 project format
- iOS 26.2 deployment target

## Repository Structure

```text
AquaCoach/
├── AquaCoach.xcodeproj/
├── AquaCoach/
│   ├── Models/
│   ├── Theme/
│   ├── Assets.xcassets/
│   ├── HydrationStore.swift
│   ├── PersistenceManager.swift
│   └── SwiftUI views
├── docs/
│   ├── design/
│   ├── planning/
│   ├── poster/
│   └── presentation/
└── README.md
```

## Run the Project

### Requirements

- macOS
- Xcode 26.3 or a compatible newer version
- iOS 26.2 simulator or device

### Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/aayushkeshari/AquaCoach.git
   cd AquaCoach
   ```

2. Open `AquaCoach.xcodeproj`.
3. Select the AquaCoach scheme and an iOS simulator.
4. Build and run with `Command-R`.

The current implementation has no external dependencies, backend, or API credentials.

## Documentation

- [User Guide](docs/User-Guide.md)
- [Frequently Asked Questions](docs/FAQ.md)
- [Design diagrams](docs/design/)
- [Project planning artifacts](docs/planning/)
- [Capstone poster](docs/poster/AquaCoach-Poster.pdf)
- [Project presentation](docs/presentation/AquaCoach-Presentation.pptx)

The planning documents preserve the original capstone scope and may describe proposed functionality that is not part of the current build.

## Roadmap

- Schedule real local notifications through `UserNotifications`
- Calculate personalized goals from profile and activity inputs
- Integrate Apple Health through HealthKit
- Add weather-aware goal adjustments
- Migrate larger datasets from UserDefaults to SwiftData
- Add automated unit and UI test targets
- Add polished simulator screenshots and an app demo GIF

## Privacy

The current prototype stores app data locally through UserDefaults and does not send it to a server. Do not use real sensitive health information while evaluating a development build.

## Author

**Aayush Keshari** — Computer Science, University of Cincinnati

[LinkedIn](https://www.linkedin.com/in/aayushkeshari) | [GitHub](https://github.com/aayushkeshari)
