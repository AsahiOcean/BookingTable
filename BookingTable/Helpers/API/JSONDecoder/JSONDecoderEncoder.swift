import Foundation

protocol EstablishmentsDelegate {
    func result(ests: Establishments)
}

final class JSONDecoderEncoder: JSON_Data_Delegate {
    
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
    
    var testEst: Establishments = Establishments() {
        didSet {
            print(testEst)
        }
    }
    
    func reception(data: Data) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any> {
                for (key,value) in json {
                    switch (key,value) {
                        case (let key, let valueDict as Dictionary<String, AnyObject>):
                            print("\(key): \(valueDict.keys)")
                        case (let key, let valueStr as String):
                            print("\(key): \(valueStr)")
                        case (let key, let value as AnyObject):
                            print("\(key): \(type(of: value))")
                    default:
                        print("[🔴] switch (key,value): Unknown format")
                    }
                }
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private init() {
        Loader.shared.delegate = self
        print("[✅] \(type(of: self)): INIT")
    }
}
