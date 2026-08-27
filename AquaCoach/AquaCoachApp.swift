import SwiftUI

@main
struct AquaCoachApp: App {
    @StateObject private var store = HydrationStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}
