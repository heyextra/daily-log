import Foundation

enum Endpoint {
    static var rootURL: URL {
        #if DEBUG
        return URL(string: "http://localhost:3000")!
        #else
        return URL(string: "http://localhost:3000")!
        #endif
    }

    static var pathConfigurationURL: URL {
        rootURL.appending(path: "configurations/ios.json")
    }
}
