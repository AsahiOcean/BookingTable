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
    
    var testEst: [Establishments] = [] {
        didSet {
            print(testEst.count)
        }
    }
    
    func reception(data: Data) {
        do {
            //let json = try self.decoder.decode(Establishments.self, from: data)
            let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:AnyObject]
                switch jsonData {
                    case let json as NSDictionary:
                        for (key,value) in json {
                            switch (key,value) {
                                case (let key as String, let valueDict as Dictionary<String, AnyObject>):
                                    print("\(key): \(valueDict.keys)")
                                case (let key as String, let valueStr as String):
                                    print("\(key): \(valueStr)")
                                case (let key as String, let value as AnyObject):
                                    print("\(key): \(type(of: value))")
                            default:
                                print("[🔴] switch (key,value): Unknown format")
                            }
                        }
                    default:
                        print("switch jsonData: ERROR")
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
