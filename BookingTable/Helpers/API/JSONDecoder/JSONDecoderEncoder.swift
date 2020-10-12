import Foundation

protocol EstablishmentsDelegate {
    func result(ests: Establishments)
}

final class JSONDecoderEncoder: JSON_Data_Delegate {
    func result(data: Data) {
        print(data.count)
    }
    
    static let shared = JSONDecoderEncoder()
    
    lazy var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    lazy var encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()
    
    private init() {
        Loader.shared.delegate = self
        print("[✅] \(type(of: self)): INIT")
    }
}
