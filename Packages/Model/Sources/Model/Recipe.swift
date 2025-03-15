
import Foundation

public struct RecipeContainer: Decodable {
    public let recipes: [Recipe]
}

public struct Recipe: Identifiable, Sendable {
    public let cuisine: String
    public let name: String
    public let photoUrlLarge: String
    public let photoUrlSmall: String
    public let id: String
    public let sourceUrl: String?
    public let youTubeUrl: String?

    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case id = "uuid"
        case sourceUrl = "source_url"
        case youTubeUrl = "youtube_url"
    }
}

extension Recipe: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cuisine = try container.decode(String.self, forKey: .cuisine)
        name = try container.decode(String.self, forKey: .name)
        photoUrlLarge = try container.decode(String.self, forKey: .photoUrlLarge)
        photoUrlSmall = try container.decode(String.self, forKey: .photoUrlSmall)
        id = try container.decode(String.self, forKey: .id)
        sourceUrl = try container.decodeIfPresent(String.self, forKey: .sourceUrl)
        youTubeUrl = try container.decodeIfPresent(String.self, forKey: .youTubeUrl)
    }
}

extension Recipe: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(cuisine, forKey: .cuisine)
        try container.encode(name, forKey: .name)
        try container.encode(photoUrlLarge, forKey: .photoUrlLarge)
        try container.encode(photoUrlSmall, forKey: .photoUrlSmall)
        try container.encode(id, forKey: .id)
        if let sourceUrl {
            try container.encode(sourceUrl, forKey: .sourceUrl)
        }
        if let youTubeUrl {
            try container.encode(youTubeUrl, forKey: .youTubeUrl)
        }
    }
}

extension Recipe {
    public static let preview: [Recipe] = {
        Array(repeating: Recipe(
            cuisine: "American",
            name: "Steak",
            photoUrlLarge: "",
            photoUrlSmall: "",
            id: UUID().uuidString,
            sourceUrl: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
            youTubeUrl: "https://www.youtube.com/watch?v=6R8ffRRJcrg"
        ), count: 20)
    }()
}
