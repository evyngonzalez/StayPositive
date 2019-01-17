//
//  PageViewController1.swift
//  
//
//  Created by Evyn Gonzalez on 12/27/17.
//

import UIKit
import AVFoundation
class PageVC: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var Player: AVPlayer!
    var PlayerLayer: AVPlayerLayer!

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArr.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return VCArr.last
        }
        guard VCArr.count > previousIndex else {
            return nil
        }
        
        return VCArr[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = VCArr.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        
        guard nextIndex < VCArr.count else {
            return VCArr.first
        }
        guard VCArr.count > nextIndex else {
            return nil
        }
        
        return VCArr[nextIndex]
    }

    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return VCArr.count
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
            let firsViewControllerIndex = VCArr.index(of: firstViewController) else {
                return 0
        }
        return firsViewControllerIndex
    }
    
    lazy var VCArr: [UIViewController] = {
        return [self.VCInstance(name: "FirstVC"),
                self.VCInstance(name: "SecondVC"),
                self.VCInstance(name: "ThirdVC"),
                self.VCInstance(name: "FourthVC")]
    }()


    private func VCInstance(name: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self .delegate = self
        
        if let firstVC = VCArr.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
        let URL = Bundle.main.url(forResource: "backgvid" , withExtension: "mov")
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        Player = AVPlayer.init(url: URL!)
        PlayerLayer = AVPlayerLayer(player: Player)
        PlayerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        PlayerLayer.frame = view.layer.frame
        Player.volume = 0
        

        Player.actionAtItemEnd = AVPlayerActionAtItemEnd.none
        
        Player.play()
        
        view.layer.insertSublayer(PlayerLayer, at: 0)
        
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemReachEnd(notification:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: Player.currentItem)
        
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for view in self.view.subviews {
            if view is UIScrollView {
                view.frame = UIScreen.main.bounds
                
            } else if view is UIPageControl {
                view.backgroundColor = UIColor.clear
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func playerItemReachEnd(notification: NSNotification) {
        Player.seek(to:kCMTimeZero)
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
