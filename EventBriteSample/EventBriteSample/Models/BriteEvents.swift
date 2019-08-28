//
//  BriteEvents.swift
//  EventBriteSample
//
//  Created by Rajneesh Kumar on 28/08/19.
//  Copyright © 2019 Rajneesh Kumar. All rights reserved.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let briteEvents = try? newJSONDecoder().decode(BriteEvents.self, from: jsonData)
// MARK: - BriteEvents
struct BriteEvents: Codable {
    typealias GFCodable = BriteEvents
    let pagination: Pagination
    let events: [Event]?
    let location: Location
}

// MARK: - Event
struct Event: Codable {
    let name, eventDescription: Description
    let id: String
    let url: String
    let start, end: End
    let organizationID: String
    let created, changed, published: Date
    let capacity, capacityIsCustom: JSONNull?
    let status: Status
    let currency: Currency
    let listed, shareable, onlineEvent: Bool
    let txTimeLimit: Int
    let hideStartDate, hideEndDate: Bool
    let locale: Locale
    let isLocked: Bool
    let privacySetting: PrivacySetting
    let isSeries, isSeriesParent: Bool
    let inventoryType: InventoryType
    let isReservedSeating, showPickASeat, showSeatmapThumbnail, showColorsInSeatmapThumbnail: Bool
    let source: Source
    let isFree: Bool
    let version: Version
    let summary, logoID, organizerID, venueID: String
    let categoryID: String
    let subcategoryID, formatID: String?
    let resourceURI: String
    let isExternallyTicketed: Bool
    let venue: Venue
    let logo: Logo
    let vanityURL: String?
    let seriesID: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case eventDescription = "description"
        case id, url, start, end
        case organizationID = "organization_id"
        case created, changed, published, capacity
        case capacityIsCustom = "capacity_is_custom"
        case status, currency, listed, shareable
        case onlineEvent = "online_event"
        case txTimeLimit = "tx_time_limit"
        case hideStartDate = "hide_start_date"
        case hideEndDate = "hide_end_date"
        case locale
        case isLocked = "is_locked"
        case privacySetting = "privacy_setting"
        case isSeries = "is_series"
        case isSeriesParent = "is_series_parent"
        case inventoryType = "inventory_type"
        case isReservedSeating = "is_reserved_seating"
        case showPickASeat = "show_pick_a_seat"
        case showSeatmapThumbnail = "show_seatmap_thumbnail"
        case showColorsInSeatmapThumbnail = "show_colors_in_seatmap_thumbnail"
        case source
        case isFree = "is_free"
        case version, summary
        case logoID = "logo_id"
        case organizerID = "organizer_id"
        case venueID = "venue_id"
        case categoryID = "category_id"
        case subcategoryID = "subcategory_id"
        case formatID = "format_id"
        case resourceURI = "resource_uri"
        case isExternallyTicketed = "is_externally_ticketed"
        case venue, logo
        case vanityURL = "vanity_url"
        case seriesID = "series_id"
    }
}

enum Currency: String, Codable {
    case cad = "CAD"
    case usd = "USD"
}

// MARK: - End
struct End: Codable {
    let timezone: Timezone
    let local: String
    let utc: Date
}

enum Timezone: String, Codable {
    case americaChicago = "America/Chicago"
    case americaVancouver = "America/Vancouver"
}

// MARK: - Description
struct Description: Codable {
    let text, html: String
}

enum InventoryType: String, Codable {
    case limited = "limited"
}

enum Locale: String, Codable {
    case enCA = "en_CA"
    case enUS = "en_US"
}

// MARK: - Logo
struct Logo: Codable {
    let cropMask: CropMask?
    let original: Original
    let id: String
    let url: String
    let aspectRatio: String
    let edgeColor: String?
    let edgeColorSet: Bool
    
    enum CodingKeys: String, CodingKey {
        case cropMask = "crop_mask"
        case original, id, url
        case aspectRatio = "aspect_ratio"
        case edgeColor = "edge_color"
        case edgeColorSet = "edge_color_set"
    }
}

// MARK: - CropMask
struct CropMask: Codable {
    let topLeft: TopLeft
    let width, height: Int
    
    enum CodingKeys: String, CodingKey {
        case topLeft = "top_left"
        case width, height
    }
}

// MARK: - TopLeft
struct TopLeft: Codable {
    let x, y: Int
}

// MARK: - Original
struct Original: Codable {
    let url: String
    let width, height: Int
}

enum PrivacySetting: String, Codable {
    case unlocked = "unlocked"
}

enum Source: String, Codable {
    case coyote = "coyote"
    case create20 = "create_2.0"
}

enum Status: String, Codable {
    case live = "live"
}

// MARK: - Venue
struct Venue: Codable {
    let address: Address
    let resourceURI: String
    let id: String
    let ageRestriction: String?
    let capacity: Int?
    let name: String?
    let latitude, longitude: String
    
    enum CodingKeys: String, CodingKey {
        case address
        case resourceURI = "resource_uri"
        case id
        case ageRestriction = "age_restriction"
        case capacity, name, latitude, longitude
    }
}

// MARK: - Address
struct Address: Codable {
    let address1, address2: String?
    let city: City
    let region: Region?
    let postalCode: String?
    let country: Country
    let latitude, longitude, localizedAddressDisplay: String
    let localizedAreaDisplay: City
    let localizedMultiLineAddressDisplay: [String]
    
    enum CodingKeys: String, CodingKey {
        case address1 = "address_1"
        case address2 = "address_2"
        case city, region
        case postalCode = "postal_code"
        case country, latitude, longitude
        case localizedAddressDisplay = "localized_address_display"
        case localizedAreaDisplay = "localized_area_display"
        case localizedMultiLineAddressDisplay = "localized_multi_line_address_display"
    }
}

enum City: String, Codable {
    case vancouver = "Vancouver"
    case vancouverBC = "Vancouver, BC"
}

enum Country: String, Codable {
    case ca = "CA"
}

enum Region: String, Codable {
    case bc = "BC"
}

enum Version: String, Codable {
    case the300 = "3.0.0"
    case the370 = "3.7.0"
}

// MARK: - Location
struct Location: Codable {
    let latitude, within, longitude: String
}

// MARK: - Pagination
struct Pagination: Codable {
    let objectCount, pageNumber, pageSize, pageCount: Int
    let hasMoreItems: Bool
    
    enum CodingKeys: String, CodingKey {
        case objectCount = "object_count"
        case pageNumber = "page_number"
        case pageSize = "page_size"
        case pageCount = "page_count"
        case hasMoreItems = "has_more_items"
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
