//   let establishments = try? newJSONDecoder().decode(Establishments.self, from: jsonData)

import Foundation

// MARK: - Establishments
struct Establishments: Codable {
    let establishmentsDescription: String?
    let eatingEstablishments: EatingEstablishments?
    let leisureEstablishments: LeisureEstablishments?

    enum CodingKeys: String, CodingKey {
        case establishmentsDescription = "description"
        case eatingEstablishments = "Eating establishments"
        case leisureEstablishments = "Leisure establishments"
    }
}

// MARK: - EatingEstablishments
struct EatingEstablishments: Codable {
    let eatingEstablishmentsDescription: String?
    let foodMarkets: [FoodMarket]?
    let coffeeHouses: [CoffeeHouse]?

    enum CodingKeys: String, CodingKey {
        case eatingEstablishmentsDescription = "description"
        case foodMarkets = "Food Markets"
        case coffeeHouses = "Coffee Houses"
    }
}

// MARK: - CoffeeHouse
struct CoffeeHouse: Codable {
    let coffeeHouseDescription: String?
    let coffeeHouse1, coffeeHouse2, coffeeHouse3: [AboutEst]?

    enum CodingKeys: String, CodingKey {
        case coffeeHouseDescription = "description"
        case coffeeHouse1 = "Coffee house 1"
        case coffeeHouse2 = "Coffee house 2"
        case coffeeHouse3 = "Coffee house 3"
    }
}

// MARK: - CoffeeHouse1
struct AboutEst: Codable {
    let title, subtitle, coffeeHouse1_Description: String?
    let images: [Image]?
    let wayOfCommunication: [WayOfCommunication]?
    let address: String?
    let onlyAdults, foodCourt: Bool?
    let workingDays: [WorkingDay]?

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case subtitle = "Subtitle"
        case coffeeHouse1_Description = "Description"
        case images = "Images"
        case wayOfCommunication = "Way of communication"
        case address = "Address"
        case onlyAdults = "Only adults"
        case foodCourt = "Food court"
        case workingDays = "Working days"
    }
}

// MARK: - Image
struct Image: Codable {
    let logo: String?
    let image1, image2, image3, image4: String?
    let image5: String?

    enum CodingKeys: String, CodingKey {
        case logo = "Logo"
        case image1 = "Image-1"
        case image2 = "Image-2"
        case image3 = "Image-3"
        case image4 = "Image-4"
        case image5 = "Image-5"
    }
}

// MARK: - WayOfCommunication
struct WayOfCommunication: Codable {
    let workPhone: WorkPhone?
    let mobilePhone: MobilePhone?
    let telegram: Bool?
    let urLs: [URLElement]?

    enum CodingKeys: String, CodingKey {
        case workPhone = "Work phone"
        case mobilePhone = "Mobile phone"
        case telegram = "Telegram"
        case urLs = "URLs"
    }
}

enum MobilePhone: String, Codable {
    case the22222222222 = "+2-222-222-22-22"
}

// MARK: - URLElement
struct URLElement: Codable {
    let site: String?

    enum CodingKeys: String, CodingKey {
        case site = "Site"
    }
}

enum WorkPhone: String, Codable {
    case the11111111111 = "+1-111-111-11-11"
}

// MARK: - WorkingDay
struct WorkingDay: Codable {
    let monday, tuesday, wednesday, thursday: [Day]?
    let friday, saturday, sunday: [Day]?

    enum CodingKeys: String, CodingKey {
        case monday = "Monday"
        case tuesday = "Tuesday"
        case wednesday = "Wednesday"
        case thursday = "Thursday"
        case friday = "Friday"
        case saturday = "Saturday"
        case sunday = "Sunday"
    }
}

// MARK: - Day
struct Day: Codable {
    let dayOff: Bool?
    let openingTime: OpeningTime?
    let closingTime: ClosingTime?

    enum CodingKeys: String, CodingKey {
        case dayOff = "Day-off"
        case openingTime = "Opening time"
        case closingTime = "Closing time"
    }
}

enum ClosingTime: String, Codable {
    case empty = ""
    case the0000 = "00:00"
    case the0200 = "02:00"
    case the2100 = "21:00"
    case the2200 = "22:00"
}

enum OpeningTime: String, Codable {
    case empty = ""
    case the1000 = "10:00"
    case the800 = "8:00"
    case the900 = "9:00"
}

// MARK: - FoodMarket
struct FoodMarket: Codable {
    let foodMarketDescription: String?
    let foodMarket1, foodMarket2, foodMarket3: [AboutEst]?

    enum CodingKeys: String, CodingKey {
        case foodMarketDescription = "description"
        case foodMarket1 = "Food Market 1"
        case foodMarket2 = "Food Market 2"
        case foodMarket3 = "Food Market 3"
    }
}

// MARK: - LeisureEstablishments
struct LeisureEstablishments: Codable {
    let leisureEstablishmentsDescription: String?
    let hookahPlaces: [HookahPlace]?
    let nightClubs: [NightClub]?

    enum CodingKeys: String, CodingKey {
        case leisureEstablishmentsDescription = "description"
        case hookahPlaces = "Hookah Places"
        case nightClubs = "Night clubs"
    }
}

// MARK: - HookahPlace
struct HookahPlace: Codable {
    let hookahPlaceDescription: String?
    let hookahPlace1, hookahPlace2, hookahPlace3: [AboutEst]?

    enum CodingKeys: String, CodingKey {
        case hookahPlaceDescription = "description"
        case hookahPlace1 = "Hookah Place 1"
        case hookahPlace2 = "Hookah Place 2"
        case hookahPlace3 = "Hookah Place 3"
    }
}

// MARK: - NightClub
struct NightClub: Codable {
    let nightClubDescription: String?
    let nightClub1, nightClub2, nightClub3: [AboutEst]?

    enum CodingKeys: String, CodingKey {
        case nightClubDescription = "description"
        case nightClub1 = "Night club 1"
        case nightClub2 = "Night club 2"
        case nightClub3 = "Night club 3"
    }
}
