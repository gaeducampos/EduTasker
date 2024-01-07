import Foundation

extension URL {
    func appendPath(value: String, name: String) -> URL {
        guard var urlComponents = URLComponents(string: self.absoluteString) else { return absoluteURL }
        var queryItems: [URLQueryItem] = urlComponents.queryItems ?? []
        let queryItem = URLQueryItem(name: name, value: value)
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
}
