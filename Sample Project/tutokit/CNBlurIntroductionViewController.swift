//
//  CNBlurIntroductionViewController.swift
//  testTuto
//
//  Created by Clément NONN on 22/11/2014.
//  Copyright (c) 2014 Clément NONN. All rights reserved.
//

import UIKit

public enum CNLanguageDirection {
    case LeftToRight
    case RightToLeft
}

public class CNBlurIntroductionViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    private var currentIndex: Int = 0
    private var boutonSkip: UIButton!
    
    public var panelsData = [CNIntroData]()
    
    public var backgroundImage: UIImage?
    public var withBlur: Bool = true
    public var langageDirection: CNLanguageDirection = .LeftToRight
    public var skipButtonPadding: CGFloat = 10.0
    
    override public func loadView() {
        super.loadView()
                
        // if there is a backgroundImage
        if let backgroundImage = self.backgroundImage {
            // add the backgroundImage AND a blurView
            var imageView = UIImageView(frame: self.view.frame)
            imageView.image = self.backgroundImage
            self.view.insertSubview(imageView, atIndex: 0)
            
            if self.withBlur {
                var visualEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
                var visualEffectView = UIVisualEffectView(effect: visualEffect)
                visualEffectView.frame = self.view.frame
                self.view.insertSubview(visualEffectView, atIndex: 1)
            }
        }
        
        // add the skipButton
        self.boutonSkip = UIButton()
        self.boutonSkip.setTitle("Skip", forState: .Normal)
        self.boutonSkip.titleLabel?.font = UIFont.systemFontOfSize(25.0)
        self.boutonSkip.sizeToFit()
        var boutonFrame = self.boutonSkip.frame
        
        boutonFrame.origin.x = self.langageDirection == .LeftToRight ? self.view.frame.size.width - boutonFrame.size.width - self.skipButtonPadding : self.skipButtonPadding
        boutonFrame.origin.y = self.view.frame.size.height - boutonFrame.size.height - 40.0
        
        self.boutonSkip.frame = boutonFrame
        
        self.view.addSubview(self.boutonSkip)
        self.boutonSkip.addTarget(self, action: "skipPressed", forControlEvents: UIControlEvents.TouchUpInside)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        
        if self.panelsData.count == 0 {
            println("0 panels found. please set the panelsData property.")
        } else {
            let beginningIndex = self.langageDirection == .LeftToRight ? 0 : self.panelsData.count - 1
            
            self.setViewControllers([self.viewControllerAtIndex(beginningIndex)], direction:.Forward, animated: true, completion: nil)
        }
    }
    
    public func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        return self.viewControllerAtIndex(self.searchIndexForViewController(viewController as CNIntroductionViewController)-1)
    }
    public func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        return self.viewControllerAtIndex(self.searchIndexForViewController(viewController as CNIntroductionViewController)+1)
    }
    
    public func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.panelsData.count
    }
    
    public func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return self.currentIndex
    }

    func searchIndexForViewController(viewController: CNIntroductionViewController) -> Int! {
        return find(self.panelsData, viewController.data!)
    }
    
    func viewControllerAtIndex(index:Int) -> CNIntroductionViewController! {
        if index < 0 || index >= self.panelsData.count {
            return nil
        }
        
        var controller = CNIntroductionViewController()
        controller.data = self.panelsData[index]
        return controller
    }
    
    func skipPressed() {
        self.performSegueWithIdentifier("skipSegue", sender: self)
    }
}

