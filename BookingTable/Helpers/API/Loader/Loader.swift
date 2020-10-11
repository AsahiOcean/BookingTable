import Foundation

class Loader {
    
    var estab: Array<CategoriesEst> = [] {
        didSet {
            print(estab.count)
        }
    }
    
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
    
    private func getJSON(from jsonData: Data) {
        do {
            if let jsonResult = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String:Any] {

                print(jsonResult.count)

                for value in jsonResult {
                    
                }
            }
        } catch {
            print("[🔴] getJSON: \(error.localizedDescription)")
        }
                
        OperationQueue.main.addOperation({
            
        })
        
//        for categories in jsonResult.keys {
//            if let subcategories = jsonResult[categories] as? [[String:AnyObject]] {
//                dump(subcategories)
//                for location in subcategories {
//                    if let stringArray = location as? [String:AnyObject] {
////                        print(stringArray)
//                    }
//                }
//            }
//        }

        
//        for categories in jsonResult.keys {
//            if let subcategories = jsonResult[categories] as? [[String:AnyObject]] {
//                dump(subcategories)
//                for location in subcategories {
//                    if let stringArray = location as? [String:AnyObject] {
////                        print(stringArray)
//                    }
//                }
//            }
//        }
        
//        if let estCategories: EstCategories = try?
//            decoder.decode(EstCategories.self, from: jsonData) {
//            for categories in estCategories.eatingEstablishments {
//                for subcategory in categories.coffeeHouses {
//                    for item in subcategory.coffeeHouse1 {
////                        dump(item)
//                    }
//                }
//            }
//        }
    }
    
    fileprivate(set) var statusCode: Int?

    fileprivate func loadData(from urlString: String, completion: @escaping (Data) throws -> Void?) {
        DispatchQueue.global(qos: .background).async {
            URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
                self.statusCode = (response as? HTTPURLResponse)?.statusCode
                
                switch (data, response, error) {
                    case (_, _, let error?):
                        print(error.localizedDescription)
                    case (let data?, let response?, _):
                        switch response.url!.absoluteString {
                            case let x where (x.hasPrefix("http") == true):
                                if let status = self.statusCode {
                                    switch status {
                                        case (200...299):
                                            print("[✅] \(x.split(separator: ":").first?.uppercased() ?? "OK"): \(status)")
                                            try? completion(data)
                                        default: break
                                    }
                                }
                            case let x where (x.hasPrefix("file") == true):
                                print("[✅] FILE: SIZE \(data.count)")
                                try? completion(data)
                            default: break
                        }
                    default: break
                }
            }.resume()
        }
    }
    
    private lazy var testJSON: URL = {
        let filename: String = "Publicplaces"
        let format: String = "json"
        guard let bundleURL = Bundle.main.url(forResource: filename, withExtension: format)
        else { fatalError("Can't find the file \(filename).\(format)") }
        return bundleURL
    }()
        
    init() {
        self.loadData(from: testJSON.absoluteString, completion: { data in
            try self.getJSON(from: data)
        })
    }
}
