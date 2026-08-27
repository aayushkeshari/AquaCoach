# Frequently Asked Questions

## How does AquaCoach calculate effective hydration?

The app multiplies the logged beverage volume by its hydration percentage. A 250 ml drink with a 90% ratio contributes 225 ml of effective hydration. Negative ratios reduce the effective total.

## How is the daily goal calculated?

The current build uses a goal entered manually in Settings. Personalized goal calculation is planned but is not implemented yet.

## Does AquaCoach support Apple Health or weather data?

Not in the current build. HealthKit and weather-aware goal adjustments remain roadmap features.

## Do reminder notifications work?

The current build stores and displays reminder preferences, but it does not yet schedule operating-system notifications.

## Does the app work offline?

Yes. The current implementation has no backend or external API dependency.

## Where is my data stored?

Goals, logs, beverages, and preferences are encoded locally and stored in UserDefaults. The prototype does not upload this information to a server.

## Can I add my own beverage?

Yes. The custom-beverage form accepts a name, icon, category, hydration percentage, and optional caffeine, calorie, and alcohol details.

## How do I reset the app?

Open Settings and use **Reset Data**. This clears logs and restores the default goal, beverage catalog, and reminder preferences.
