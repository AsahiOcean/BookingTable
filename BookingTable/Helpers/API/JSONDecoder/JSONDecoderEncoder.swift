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

    func result(data: Data) {
        do {
//            let json = try self.decoder.decode(Establishments.self, from: data)
//            let object: Any = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments)
            
            let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
            switch jsonData {
                case let json as NSDictionary:
                    var keys: [String] = []
                    var values: [AnyObject] = []

                    let dict = Dictionary(zip(keys, values), uniquingKeysWith: { $1 }) as? Establishments

                    for (key,value) in json {
                        switch (key,value) {
                        case (let x as String, let y as EatingEst):
                            print(y)
                        default:
                            break
                        }
                    }
                default:
                    print("ERROR")
            }
            //let myData = try self.decoder.decode(Establishments.self, from: jsonData); print(myData)
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private init() {
        Loader.shared.delegate = self
        print("[✅] \(type(of: self)): INIT")
    }
}
