import UIKit

class ViewController: UIViewController {
    
    var textField: UITextField!
    
    var qweqwe: StickyHeaderViewController2!
    lazy var header: HeaderView = {
        let header = HeaderView(frame: CGRect(origin: .zero,
                                              size: CGSize(
                                                width: view.frame.width,
                                                height: view.frame.height * 0.10)))
        return header
    }()
    
    lazy var recentPlaces: RecentPlaces = {
        let recentPlaces = RecentPlaces(frame: CGRect(origin: .zero, size: CGSize(width: view.frame.width * 0.95, height: view.frame.height * 0.25)))
        recentPlaces.frame.origin.y = header.frame.maxY * 1.15
        recentPlaces.center.x = UIScreen.main.bounds.midX
        return recentPlaces
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Loader.shared.load()
        self.view.addSubview(header)
        self.view.addSubview(recentPlaces)
        
        
        let testView = UIView(frame: CGRect(x: recentPlaces.frame.minX, y: recentPlaces.frame.maxY * 1.05, width: recentPlaces.bounds.width, height: recentPlaces.frame.maxY * 1.5))
        testView.layer.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        self.view.addSubview(testView)
        
        let qweqwe = StickyHeaderViewController2()
        addChild(qweqwe)
        qweqwe.view.frame = testView.frame
        view.addSubview(qweqwe.view)
        qweqwe.didMove(toParent: self)
        
        //        self.qweqwe = StickyHeaderViewController2()
        //        testView.addSubview(qweqwe.view)
        
        //        addChild(childVC)
        //        //Or, you could add auto layout constraint instead of relying on AutoResizing contraints
        //        childVC.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        //        childVC.view.frame = containerView.bounds
        //
        //        containerView.addSubview(childVC.view)
        //        childVC.didMove(toParentViewController: self)
        //
        //        //Some property on ChildVC that needs to be set
        //        childVC.dataSource = self
    }
}



/*
 func createHorizontalScroll() {
 let scrollView = UIScrollView(frame: CGRect(x: 0, y: 80, width: view.frame.size.width, height: 80))
 
 var buttonX = 0
 for i in 0..<5 {
 let button = UIButton(frame: CGRect(x: CGFloat(buttonX), y: 0, width: 100, height: 60))
 button.setTitle("Button \(i)", for: .normal)
 scrollView.addSubview(button)
 buttonX = Int(CGFloat(buttonX) + button.frame.size.width)
 button.addTarget(
 self,
 action: #selector(changeView(_:)),
 for: .touchUpInside)
 }
 
 scrollView.contentSize = CGSize(width: CGFloat(buttonX), height: scrollView.frame.size.height)
 scrollView.backgroundColor = UIColor.green
 view.addSubview(scrollView)
 }
 
 @objc func changeView(_ sender: UIButton?) {
 print(String(format: "I Clicked a button %ld", Int(sender?.tag ?? 0)))
 }
 */
