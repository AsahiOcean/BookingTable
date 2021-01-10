import UIKit

var topViewInitialHeight: CGFloat = 100

let topViewFinalHeight: CGFloat = 0 //navigation hieght

var topViewHeightConstraintRange = topViewFinalHeight..<topViewInitialHeight

class StickyHeaderViewController2: UIViewController {
    
    //MARK:- Change this value for number of tabs.
    
    let tabsCount = 5 //; #warning ("< 1 causes crash")
    
    //MARK:- Outlets
    
    @IBOutlet weak var stickyHeaderView: UIView!
    @IBOutlet weak var tabBarCollectionView: UICollectionView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var headerViewHeightConstraint: NSLayoutConstraint!
    
    @IBAction func closeBanner(_ sender: UIButton) {
        UIView.animate(withDuration: 0.5, animations: {
            self.topBarHeight(0)
            self.view.layoutIfNeeded()
        })
    }
    
    private func topBarHeight(_ value: CGFloat) {
        headerViewHeightConstraint.constant = value
        topViewInitialHeight = headerViewHeightConstraint.constant
    }
    
    //MARK:- Programatic UI Properties
    
    var pageViewController = UIPageViewController()
    var selectedTabView = UIView()
    
    //MARK:- View Model
    
    var pageCollection = PageCollection()
    
    //MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topBarHeight(view.frame.height/10)
        
        bottomView.layer.cornerRadius = 15
        bottomView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        headerViewHeightConstraint.constant = topViewInitialHeight
        
        setupCollectionView()
        setupPagingViewController()
        populateBottomView()
        addPanGestureToTopViewAndCollectionView()
    }
    
    //MARK: View Setup
    
    func setupCollectionView() {
        guard let layout = tabBarCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
        layout.estimatedItemSize = CGSize(width: 100, height: 50)
        
        tabBarCollectionView.register(TabBarCollectionViewCell.nib, forCellWithReuseIdentifier: TabBarCollectionViewCell.id)
        tabBarCollectionView.dataSource = self
        tabBarCollectionView.delegate = self
        
        setupSelectedTabView()
    }
    
    func setupSelectedTabView() {
        
        let label = UILabel(frame: CGRect.init(x: 0, y: 0, width: 10, height: 10))
        label.text = "TAB \(1)"
        label.sizeToFit()
        var width = label.intrinsicContentSize.width
        width = width + 40
        
        selectedTabView.frame = CGRect(x: 20, y: 55, width: width, height: 5)
        selectedTabView.backgroundColor = #colorLiteral(red: 0.8300367594, green: 0.711122334, blue: 0.5887681246, alpha: 1)
        tabBarCollectionView.addSubview(selectedTabView)
    }
    
    func setupPagingViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
    }
    
    func populateBottomView() {
        
        for subTabCount in 0..<tabsCount {
            
            let tabContentVC = ContentViewController1()
            tabContentVC.innerTableViewScrollDelegate = self
            tabContentVC.numberOfCells = 30 // (subTabCount + 1) * 10
            
            let displayName = "TAB \(subTabCount + 1)"
            let page = Page(with: displayName, _vc: tabContentVC)
            pageCollection.pages.append(page)
        }
        
        let initialPage = 0
        
        pageViewController.setViewControllers([pageCollection.pages[initialPage].vc],
                                              direction: .forward,
                                              animated: true,
                                              completion: nil)
        
        
        addChild(pageViewController)
        pageViewController.willMove(toParent: self)
        bottomView.addSubview(pageViewController.view)
        
        pinPagingViewControllerToBottomView()
    }
    
    func pinPagingViewControllerToBottomView() {
        
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        pageViewController.view.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
        pageViewController.view.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
        pageViewController.view.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        pageViewController.view.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
    }
    
    func addPanGestureToTopViewAndCollectionView() {
        
        let topViewPanGesture = UIPanGestureRecognizer(target: self, action: #selector(topViewMoved))
        
        stickyHeaderView.isUserInteractionEnabled = true
        stickyHeaderView.addGestureRecognizer(topViewPanGesture)
        
        /* Adding pan gesture to collection view is overriding the collection view scroll.
         
         let collViewPanGesture = UIPanGestureRecognizer(target: self, action: #selector(topViewMoved))
         
         tabBarCollectionView.isUserInteractionEnabled = true
         tabBarCollectionView.addGestureRecognizer(collViewPanGesture)
         
         */
    }
    
    //MARK:- Action Methods
    var dragInitialY: CGFloat = 0
    var dragPreviousY: CGFloat = 0
    var dragDirection: DragDirection = .Up
    
    @objc func topViewMoved(_ gesture: UIPanGestureRecognizer) {
        
        var dragYDiff : CGFloat
        
        switch gesture.state {
        
        case .began:
            
            dragInitialY = gesture.location(in: self.view).y
            dragPreviousY = dragInitialY
            
        case .changed:
            
            let dragCurrentY = gesture.location(in: self.view).y
            dragYDiff = dragPreviousY - dragCurrentY
            dragPreviousY = dragCurrentY
            dragDirection = dragYDiff < 0 ? .Down : .Up
            innerTableViewDidScroll(withDistance: dragYDiff)
            
        case .ended:
            
            innerTableViewScrollEnded(withScrollDirection: dragDirection)
            
        default: return
            
        }
    }
    
    //MARK:- UI Laying Out Methods
    
    func setBottomPagingView(toPageWithAtIndex index: Int, andNavigationDirection navigationDirection: UIPageViewController.NavigationDirection) {
        
        pageViewController.setViewControllers([pageCollection.pages[index].vc],
                                              direction: navigationDirection,
                                              animated: true,
                                              completion: nil)
    }
}

//MARK:- Collection View Data Source

extension StickyHeaderViewController2: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pageCollection.pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabBarCollectionViewCell.id, for: indexPath) as! TabBarCollectionViewCell
        cell.tabNameLabel.text = pageCollection.pages[indexPath.row].name
        return cell
    }
}

//MARK:- Collection View Delegate

extension StickyHeaderViewController2: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == pageCollection.selectedPageIndex {
            
            return
        }
        
        var direction: UIPageViewController.NavigationDirection
        
        if indexPath.item > pageCollection.selectedPageIndex {
            direction = .forward
        } else {
            direction = .reverse
        }
        
        pageCollection.selectedPageIndex = indexPath.item
        tabBarCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        setBottomPagingView(toPageWithAtIndex: indexPath.item, andNavigationDirection: direction)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}

//MARK:- Delegate Method to give the next and previous View Controllers to the Page View Controller

extension StickyHeaderViewController2: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let currentViewControllerIndex = pageCollection.pages.firstIndex(where: { $0.vc == viewController }) {
            
            if (1..<pageCollection.pages.count).contains(currentViewControllerIndex) {
                
                // go to previous page in array
                
                return pageCollection.pages[currentViewControllerIndex - 1].vc
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let currentViewControllerIndex = pageCollection.pages.firstIndex(where: { $0.vc == viewController }) {
            
            if (0..<(pageCollection.pages.count - 1)).contains(currentViewControllerIndex) {
                
                // go to next page in array
                
                return pageCollection.pages[currentViewControllerIndex + 1].vc
            }
        }
        return nil
    }
}

//MARK:- Delegate Method to tell Inner View Controller movement inside Page View Controller
//Capture it and change the selection bar position in collection View

extension StickyHeaderViewController2: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard completed else { return }
        
        guard let currentVC = pageViewController.viewControllers?.first else { return }
        
        guard let currentVCIndex = pageCollection.pages.firstIndex(where: { $0.vc == currentVC }) else { return }
        
        let indexPathAtCollectionView = IndexPath(item: currentVCIndex, section: 0)
        
        tabBarCollectionView.scrollToItem(at: indexPathAtCollectionView,
                                          at: .centeredHorizontally,
                                          animated: true)
    }
}

//MARK:- Sticky Header Effect

extension StickyHeaderViewController2: InnerTableViewScrollDelegate {
    
    var currentHeaderHeight: CGFloat {
        
        return headerViewHeightConstraint.constant
    }
    
    func innerTableViewDidScroll(withDistance scrollDistance: CGFloat) {
        
        headerViewHeightConstraint.constant -= scrollDistance
        
        if headerViewHeightConstraint.constant > topViewInitialHeight {
            
            headerViewHeightConstraint.constant = topViewInitialHeight
        }
        
        if headerViewHeightConstraint.constant < topViewFinalHeight {
            
            headerViewHeightConstraint.constant = topViewFinalHeight
        }
    }
    
    func innerTableViewScrollEnded(withScrollDirection scrollDirection: DragDirection) {
        
        let topViewHeight = headerViewHeightConstraint.constant
        
        /*
         *  Scroll is not restricted.
         *  So this check might cause the view to get stuck in the header height is greater than initial height.
         
         if topViewHeight >= topViewInitialHeight || topViewHeight <= topViewFinalHeight { return }
         
         */
        
        if topViewHeight <= topViewFinalHeight + 20 {
            
            scrollToFinalView()
            
        } else if topViewHeight <= topViewInitialHeight - 20 {
            
            switch scrollDirection {
            
            case .Down: scrollToInitialView()
            case .Up: scrollToFinalView()
                
            }
            
        } else {
            
            scrollToInitialView()
        }
    }
    
    func scrollToInitialView() {
        
        let topViewCurrentHeight = stickyHeaderView.frame.height
        
        let distanceToBeMoved = abs(topViewCurrentHeight - topViewInitialHeight)
        
        var time = distanceToBeMoved / 500
        
        if time < 0.25 {
            
            time = 0.25
        }
        
        headerViewHeightConstraint.constant = topViewInitialHeight
        
        UIView.animate(withDuration: TimeInterval(time), animations: {
            
            self.view.layoutIfNeeded()
        })
    }
    
    func scrollToFinalView() {
        
        let topViewCurrentHeight = stickyHeaderView.frame.height
        
        let distanceToBeMoved = abs(topViewCurrentHeight - topViewFinalHeight)
        
        var time = distanceToBeMoved / 500
        
        if time < 0.25 {
            
            time = 0.25
        }
        
        headerViewHeightConstraint.constant = topViewFinalHeight
        
        UIView.animate(withDuration: TimeInterval(time), animations: {
            
            self.view.layoutIfNeeded()
        })
    }
}
