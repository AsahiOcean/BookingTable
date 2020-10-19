import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var header: HeaderView!
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [RecentPlaces] = []
    
    func createSlides() -> [RecentPlaces] {

        let slide1: RecentPlaces = RecentPlaces(frame: CGRect(x: 0, y: header.frame.maxY + header.frame.maxY / 10, width: view.frame.width * 0.95, height: view.frame.height * 0.30))
        
        let slide2:RecentPlaces = RecentPlaces(frame: CGRect(x: 0, y: header.frame.maxY + header.frame.maxY / 10, width: view.frame.width * 0.95, height: view.frame.height * 0.30))
        
        let slide3:RecentPlaces = RecentPlaces(frame: CGRect(x: 0, y: header.frame.maxY + header.frame.maxY / 10, width: view.frame.width * 0.95, height: view.frame.height * 0.30))
        
        let slide4:RecentPlaces = RecentPlaces(frame: CGRect(x: 0, y: header.frame.maxY + header.frame.maxY / 10, width: view.frame.width * 0.95, height: view.frame.height * 0.30))
        
        
        let slide5:RecentPlaces = RecentPlaces(frame: CGRect(x: 0, y: header.frame.maxY + header.frame.maxY / 10, width: view.frame.width * 0.95, height: view.frame.height * 0.30))
        
        return [slide1, slide2, slide3, slide4, slide5]
    }
    
    func setupSlideScrollView(slides : [RecentPlaces]) {
        scrollView.frame = CGRect(x: 0, y: header.frame.maxY + header.frame.maxY / 10, width: view.frame.width * 0.95, height: view.frame.height * 0.30)
        scrollView.center.x = UIScreen.main.bounds.midX
        
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(slides.count), height: scrollView.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: scrollView.frame.width * CGFloat(i), y: 0, width: scrollView.frame.width, height: scrollView.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Loader.shared.load()
        
        self.header = HeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height * 0.10))
        self.view.addSubview(header)
        
//        let recentPlaces = RecentPlaces(frame: CGRect(x: 0, y: header.frame.maxY + header.frame.maxY / 10, width: view.frame.width * 0.95, height: view.frame.height * 0.30))
//        self.view.addSubview(recentPlaces)
        
        slides = createSlides()
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
    }
}
