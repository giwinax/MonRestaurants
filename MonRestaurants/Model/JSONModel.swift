//
//  JSONModel.swift
//  MonRestaurants
//
//  Created by s b on 04.05.2022.
//

import Foundation


struct DetailedInfo {
    let status: Int
    let msg: JSONNull?
    let results: ResultsStruct
}


struct ResultsStruct {
    let data: [DataStruct]
    let paging: PagingStruct
}



struct DataStruct {
    let images: ImagesStruct
    let isBlessed: Bool
    let uploadedDate: String
    let caption: String
    let linkedReviews: [LinkedReviewStruct]?
    let locations: [LocationStruct]
    let id, helpfulVotes, publishedDate: String
    let user: UserStruct?

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

enum Caption: String, Codable {
    case empty = ""
    case getlstdPropertyPhoto = "getlstd_property_photo"
    case pagoBalcony = "Pago Balcony"
}


struct ImagesStruct {
    let small, thumbnail, original, large, medium: ImagesURLStruct
}


struct ImagesURLStruct: Codable {
    let width: String
    let url: String //
    let height: String
}


struct LinkedReviewStruct {
    let id: String
    let lang: Locale
    let locationID, publishedDate, publishedPlatform, rating: String
    let type, helpfulVotes: String
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


struct LocationStruct {
    let name: Name?
    let id: String?
}

enum Name: String, Codable {
    case bandungIndonesia = "Bandung, Indonesia"
    case jakartaIndonesia = "Jakarta, Indonesia"
    case pagoRestaurant = "Pago Restaurant"
}


struct UserStruct {
    let userID: String
    let type: TypeEnum
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


struct Avatar: Codable {
    let small, large: AvatarLarge
}


struct AvatarLarge: Codable {
    let url: String
}

enum TypeEnum: String, Codable {
    case user = "user"
}

struct PagingStruct {
    let next: String
    let previous: JSONNull?
    let results, totalResults, skipped: String

    enum CodingKeys: String, CodingKey {
        case next, previous, results
        case totalResults = "total_results"
        case skipped
    }
}
