//
//  Networking.swift
//  MonRestaurants
//
//  Created by s b on 28.04.2022.
//

import Foundation

//   let task = URLSession.shared.worldwideRestaurantsTask(with: url) { worldwideRestaurants, response, error in
//     if let worldwideRestaurants = worldwideRestaurants {
//       let worldwideRestaurants = try? newJSONDecoder().decode(WorldwideRestaurants.self, from: jsonData)
//     }
//   }
//   task.resume()

// MARK: - WorldwideRestaurants
struct WorldwideRestaurants: Codable {
    let status: Int
    let msg: JSONNull?
    let results: Results
}

// MARK: - Results
struct Results: Codable {
    let data: [Datum]
    let paging: Paging
}

// MARK: - Datum
struct Datum: Codable {
    let images: Images
    let isBlessed: Bool
    let uploadedDate, caption: String
    let linkedReviews: [LinkedReview]?
    let locations: [Location]
    let id, helpfulVotes, publishedDate: String
    let user: User

    enum CodingKeys: String, CodingKey {
        case images
        case isBlessed = "is_blessed"
        case uploadedDate = "uploaded_date"
        case caption
        case linkedReviews = "linked_reviews"
        case locations, id
        case helpfulVotes = "helpful_votes"
        case publishedDate = "published_date"
        case user
    }
}

// MARK: - Images
struct Images: Codable {
    let small, thumbnail, original, large: MediumClass
    let medium: MediumClass
}

// MARK: - MediumClass
struct MediumClass: Codable {
    let width: String
    let url: String
    let height: String
}

// MARK: - LinkedReview
struct LinkedReview: Codable {
    let id: String
    let lang: Locale
    let locationID, publishedDate: String
    let publishedPlatform: PublishedPlatform
    let rating: String
    let type: LinkedReviewType
    let helpfulVotes: String
    let url: String
    let travelDate, text, user: JSONNull?
    let title: String
    let ownerResponse: JSONNull?
    let subratings: [JSONAny]
    let machineTranslated, machineTranslatable: Bool

    enum CodingKeys: String, CodingKey {
        case id, lang
        case locationID = "location_id"
        case publishedDate = "published_date"
        case publishedPlatform = "published_platform"
        case rating, type
        case helpfulVotes = "helpful_votes"
        case url
        case travelDate = "travel_date"
        case text, user, title
        case ownerResponse = "owner_response"
        case subratings
        case machineTranslated = "machine_translated"
        case machineTranslatable = "machine_translatable"
    }
}

enum Locale: String, Codable {
    case enUS = "en_US"
    case localeIn = "in"
}

enum PublishedPlatform: String, Codable {
    case desktop = "Desktop"
    case mobile = "Mobile"
}

enum LinkedReviewType: String, Codable {
    case review = "review"
}

// MARK: - Location
struct Location: Codable {
    let name: Name?
    let id: String?
}

enum Name: String, Codable {
    case bandungIndonesia = "Bandung, Indonesia"
    case jakartaIndonesia = "Jakarta, Indonesia"
    case pagoRestaurant = "Pago Restaurant"
}

// MARK: - User
struct User: Codable {
    let userID: String
    let type: UserType
    let firstName, lastInitial: String?
    let name, memberID, username: String
    let userLocation: Location
    let avatar: Avatar
    let link: String
    let points, createdTime: String
    let locale: Locale

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case type
        case firstName = "first_name"
        case lastInitial = "last_initial"
        case name
        case memberID = "member_id"
        case username
        case userLocation = "user_location"
        case avatar, link, points
        case createdTime = "created_time"
        case locale
    }
}

// MARK: - Avatar
struct Avatar: Codable {
    let small, large: AvatarLarge
}

// MARK: - AvatarLarge
struct AvatarLarge: Codable {
    let url: String
}

enum UserType: String, Codable {
    case user = "user"
}

// MARK: - Paging
struct Paging: Codable {
    let next: String
    let previous: JSONNull?
    let results, totalResults, skipped: String

    enum CodingKeys: String, CodingKey {
        case next, previous, results
        case totalResults = "total_results"
        case skipped
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
        return nil
    }

    required init?(stringValue: String) {
        key = stringValue
    }

    var intValue: Int? {
        return nil
    }

    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}
