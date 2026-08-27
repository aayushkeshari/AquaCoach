import Foundation

final class PersistenceManager {
    static let shared = PersistenceManager()

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private init() {}

    func save<T: Codable>(_ value: T, forKey key: String) {
        do {
            let data = try encoder.encode(value)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Failed to save \(key): \(error)")
        }
    }

    func load<T: Codable>(_ type: T.Type, forKey key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }

        do {
            return try decoder.decode(type, from: data)
        } catch {
            print("Failed to load \(key): \(error)")
            return nil
        }
    }

    func saveDouble(_ value: Double, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }

    func loadDouble(forKey key: String, defaultValue: Double) -> Double {
        let value = UserDefaults.standard.double(forKey: key)
        return value == 0 ? defaultValue : value
    }
}
