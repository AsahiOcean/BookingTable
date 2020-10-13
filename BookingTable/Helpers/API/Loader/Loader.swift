import Foundation

protocol JSON_Data_Delegate: class {
    func reception(data: Data)
}

final class Loader {
    
    static let shared = Loader()
    
    var delegate: JSON_Data_Delegate?
    weak var jsonDecoderEncoder: JSONDecoderEncoder!
    public var url: URL? = URL(string: "https://raw.githubusercontent.com/AsahiOcean/BookingTable/master/test_json.json")
    public fileprivate(set) var statusCode: Int?
    
    fileprivate let loadData_backgroundQueue = DispatchQueue(label: "com.loadData.background.queue", qos: .background)
                
    func load() {
        self.loadData_backgroundQueue.async {
            guard let url = self.url else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
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
                                            print("[✅] \(x.split(separator: ":").first?.uppercased() ?? "OK"): \(status) | DATA SIZE: \(data.count)")
                                            let loadData_backgroundQueue = DispatchQueue(label: "com.jsonDecoderEncoder.queue", qos: .background)
                                            loadData_backgroundQueue.async(execute: {
                                                self.jsonDecoderEncoder = JSONDecoderEncoder.shared
                                                self.delegate?.reception(data: data)
                                            })
                                        default: break
                                    }
                                }
                            default: break
                        }
                    default: break
                }
            }.resume()
        }
    }
        
    private init() {
        print("[✅] \(type(of: self)): INIT")
    }
}
