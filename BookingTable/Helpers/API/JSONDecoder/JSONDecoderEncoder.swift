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
    
    var testEst: Establishments? {
        didSet {
            print(testEst as Any)
        }
    }
    
    fileprivate func keyValueSwitch<T>(_ key: String, _ value: T) {
        switch (key,value) {
        case (let key, let value_Int as Int):
            print("\(key): \(value_Int)")
        case (let key, let value_Double as Double):
            print("\(key): \(value_Double)")
        case (let key, let value_String as String):
            print("\(key): \(value_String)")
        case (let key, let value_Bool as Bool):
            print("\(key): \(value_Bool)")
        case (let key, let value_Dict as Dictionary<String, AnyObject>):
            print("\(key): \(value_Dict.keys)")
        case (let key, let value as AnyObject):
            print("\(key): \(type(of: value))")
        default:
            print("[🔴] switch (key,value): Unknown format")
        }
    }
    
    func reception(data: Data) {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any> {
                for (key,value) in json {
                    self.keyValueSwitch(key, value)
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
