import Foundation

extension UserDefaults {
    func auth(forKey defaultName: String) -> Student? {
        guard let data = data(forKey: defaultName) else { return nil }
        do {
            return try JSONDecoder().decode(Student.self, from: data)
        } catch { print(error); return nil }
    }

    func set(_ value: Student, forKey defaultName: String) {
        let data = try? JSONEncoder().encode(value)
        set(data, forKey: defaultName)
    }
}
