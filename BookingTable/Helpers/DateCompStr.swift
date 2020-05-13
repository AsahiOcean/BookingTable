import Foundation
import UIKit

func DateCompStr(DatePicker: UIDatePicker) -> String {
    var result = String()
    let componenets = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: DatePicker.date)
    if let day = componenets.day, let month = componenets.month,
       let year = componenets.year,
       let hour = componenets.hour,
       let min = componenets.minute {
       result = "\(hour):\(min)"
    }
    return result
}
