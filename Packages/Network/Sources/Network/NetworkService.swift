
import Foundation

public protocol NetworkService {
    var session: URLSession { get }
    var decoder: JSONDecoder { get }

    associatedtype T: Decodable
    
    func fetchAll() async throws -> [T]
    func decode<T: Decodable>(_ data: Data) throws -> T
}

extension NetworkService {
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        return try decoder.decode(T.self, from: data)
    }
}
