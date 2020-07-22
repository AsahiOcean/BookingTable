import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var TimePicker: UIDatePicker!
    @IBOutlet weak var BookingButton: UIButton!
    @IBOutlet weak var Persons: UIPickerView!
    @IBOutlet weak var TimeCheck: UILabel!
    @IBOutlet weak var BookingStack: UIStackView!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var PersonsLabel: UILabel!
    @IBOutlet weak var PlacePreview: UIView!
    @IBAction func BookingTime(_ sender: UIDatePicker) {
        self.bookingTime = DateCompStr(DatePicker: self.TimePicker)
        self.TimeCheck.alpha = 1
    }
    @IBOutlet weak var SwitchСondition: UISwitch!
    @IBAction func ChooseTable(_ sender: Any) {
        if SwitchСondition.isOn {
            UIView.animate(withDuration: 0.5) {
//                self.PlacePreview.alpha = 0
//                self.BookingStack.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.PlacePreview.alpha = 1
                self.BookingStack.alpha = 0
            }
        }
    }

    let counters = ["1","2","3","4","5","6"]
    
    var bookingTime = String()
    var persons = "1"
    @IBOutlet weak var Message: UILabel!
    @IBAction func Booking(_ sender: UIButton) {
        self.Message.alpha = 1
        UIView.animate(withDuration: 0.25) {
            self.BookingStack.alpha = 0
            self.PlacePreview.alpha = 0
            self.Message.text = "Ждём вас к \(self.bookingTime)\nЖелаем приятного отдыха!"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.BookingButton.layer.cornerRadius = 10
        self.bookingTime = DateCompStr(DatePicker: self.TimePicker)
        self.PlacePreview.alpha = 0
        self.Message.alpha = 0
        self.TimeCheck.alpha = 0
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return counters.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return counters[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        persons = counters[row]
    }
}
