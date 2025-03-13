
import Foundation

public protocol NetworkService {
    associatedtype T: Decodable
    
    func fetchAll() async throws -> [T]
}
