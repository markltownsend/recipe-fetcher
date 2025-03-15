
import Foundation

public protocol NetworkService {
    associatedtype T: Decodable
    
    func fetchAll() async throws -> [T]
    func decode<T: Decodable>(_ data: Data) throws -> T
}

extension NetworkService {
    public func decode<T: Decodable>(_ data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
