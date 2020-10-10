import Foundation

class Loader {
    
    var Est: [EstInformation] = [] {
        didSet {
            print(Est.map({$0.title}))
        }
    }
    
    private func decoder(data: Data) {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        
        let estCat = try? decoder.decode(EstCategories.self, from: data)
        guard let jsonData = try? encoder.encode(estCat) else { return }
        
        guard let json = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String:Any] else { return }
                
        for categories in json.keys {
            if let locations = json[categories] as? [[String: AnyObject]] {
                for location in locations {
                    if let stringArray = location as? [String:Any] {
                        print(stringArray)
                    
                    }
                    else {
                    
                    }
                }
            }
        }
        
        if let estCategories: EstCategories = try?
            decoder.decode(EstCategories.self, from: jsonData) {
            for categories in estCategories.eatingEstablishments {
                for subcategory in categories.coffeeHouses {
                    for item in subcategory.coffeeHouse1 {
//                        dump(item)
                    }
                }
            }
        } else {
            //
        }
    }
    
    func requestForUserDataWith(_ parameters: [String: String], completionHandler: (_ result: [String: Any], _ error: Error) -> Void){
         //.. Code process
    }
    
    fileprivate func loadJSON(url: URL, completion: @escaping (_ result: Data?, _ error: Error?) -> Void) {
        var data: Data? = nil
        var error: Error? = nil
        do {
            data = try Data(contentsOf: url, options: [])
        } catch let fail as NSError {
            (data, error) = (nil, fail)
            print(fail.localizedDescription)
        }
        completion(data, error)
    }
    
    private lazy var testJSONurl: URL = {
        let filename: String = "Publicplaces"
        let format: String = "json"
        guard let bundleURL = Bundle.main.url(forResource: filename, withExtension: format)
        else { fatalError("Can't find the file \(filename).\(format)") }
        return bundleURL
    }()
    
    init() {
        self.loadJSON(url: testJSONurl, completion: { data, error in
            guard let data = data, error == nil else { return }
            self.decoder(data: data)
        })
    }
}

