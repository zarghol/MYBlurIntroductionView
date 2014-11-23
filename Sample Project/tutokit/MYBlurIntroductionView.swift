//
//  MYBlurIntroductionView.swift
//  
//
//  Created by Clément NONN on 21/11/2014.
//
//

import Foundation
import UIKit

let pageControlWidth : CGFloat = 148.0
let leftRightSkipPadding: CGFloat = 10.0

enum MYFinishType : Int {
    case SwypeOut = 0
    case SkipButton = 1
}

enum MYLanguageDirection {
    case LeftToRight
    case RightToLeft
}

@objc protocol MYIntroductionDelegate {
    optional func introduction(introductionView: MYBlurIntroductionView, didFinishType finishType:Int)
    optional func introduction(introductionView: MYBlurIntroductionView, didChangeToPanel panel:MYIntroductionPanel, withIndex index: Int)
}

class MYBlurIntroductionView : UIView, UIScrollViewDelegate {
    var panels: [MYIntroductionPanel]
    var lastPanelIndex: Int
    
    var delegate: MYIntroductionDelegate?
    var blurView: UIView?
    var backgroundImageView: UIImageView?
    var masterScrollView: UIScrollView
    var pageControl: UIPageControl
    var skipButton: UIButton
    var currentPanelIndex: Int
    var languageDirection: MYLanguageDirection

    
    
    
    override convenience init(frame: CGRect) {
        self.init(frame:frame, backgroundImage: nil)
    }
    
    init(frame: CGRect, backgroundImage:UIImage?) {
        self.panels = [MYIntroductionPanel]()
        self.lastPanelIndex = 0
        
        
        if let image = backgroundImage {
            self.backgroundImageView = UIImageView(frame: frame)
            self.backgroundImageView!.image = image
        }
        
        self.masterScrollView = UIScrollView(frame: frame)
        
        // TODO: constraints
        let rect = CGRect(x: (frame.size.width - pageControlWidth)/2, y: frame.size.height - 48, width: pageControlWidth, height: 37)
        
        self.pageControl = UIPageControl(frame: rect)
        self.skipButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        self.currentPanelIndex = 0
        self.lastPanelIndex = 0
        self.languageDirection = .LeftToRight
        
        super.init(frame: frame)
        
        
        self.buildPanel()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func buildPanel() {
        if var backgroundImageView = self.backgroundImageView {
            backgroundImageView.contentMode = .ScaleAspectFill
            backgroundImageView.autoresizingMask = .FlexibleHeight
            self.addSubview(backgroundImageView)
        }
        
        // Master Scroll View
        self.masterScrollView.autoresizingMask = (UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth)
        self.masterScrollView.pagingEnabled = true
        self.masterScrollView.delegate = self
        self.masterScrollView.showsHorizontalScrollIndicator = false
        self.masterScrollView.showsVerticalScrollIndicator = false
        self.addSubview(self.masterScrollView)
        
        // Page Control
        self.pageControl.currentPage = 0
        self.pageControl.enabled = false
        self.addSubview(self.pageControl)
        
        // Skip button
        self.skipButton.setTitle("Skip", forState: UIControlState.Normal)
        //self.skipButton.titleLabel?.font = skipButtonFont
        self.skipButton.addTarget(self, action: "didPressSkipButton", forControlEvents: UIControlEvents.TouchUpInside)
//        self.leftSkipButton.frame = CGRect(x: 10, y: self.frame.size.height - 48, width: 46, height: 37)
        self.addSubview(self.skipButton)
        
    }
    
    /**
    *  Public method used to build panels
    *
    *  @param panels @b Array of MYIntroductionPanel objects
    */
    func buildIntroductionWithPanels(panels: [MYIntroductionPanel]) {
        if panels.count == 0 {
            println("0 panels..")
            return
        }
        
        self.panels = panels
        for panel in self.panels {
            panel.parentIntroductionView = self
        }
        self.pageControl.numberOfPages = panels.count
        self.skipButton.hidden = true
        self.buildScrollView()

    }
    
    func buildScrollView() {
        
        var panelXOffset = self.languageDirection == MYLanguageDirection.LeftToRight ? CGFloat(0.0) : self.frame.size.width * CGFloat(self.panels.count)
        
        var scrollViewWidth = panelXOffset > 0.0 ? panelXOffset + self.frame.size.width : 0.0
        
        for panel in self.panels {
            panel.frame = CGRect(x: panelXOffset, y: 0.0, width: self.frame.size.width, height: self.frame.size.height)
            
            self.masterScrollView.addSubview(panel)
            
            panelXOffset += (self.languageDirection == MYLanguageDirection.LeftToRight ? 1 : -1) * panel.frame.size.width
        }
        if self.languageDirection == MYLanguageDirection.LeftToRight {
            scrollViewWidth = panelXOffset
            self.panels[0].panelDidAppear()
        } else {
            self.masterScrollView.contentOffset = CGPoint(x: self.frame.size.width * CGFloat(self.panels.count), y: 0)
            self.pageControl.currentPage = self.panels.count
        }
        
        self.masterScrollView.contentSize = CGSize(width: scrollViewWidth, height: self.frame.size.height)
        
        self.appendCloseViewAtXIndex(&panelXOffset)
        self.animatePanelAtIndex(0)
    }
    
    
    
    // MARK:- UIScrollView Delegate
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // TODO: try to fusionner both sides
        if self.languageDirection == MYLanguageDirection.LeftToRight {
            self.currentPanelIndex = Int(scrollView.contentOffset.x / self.masterScrollView.frame.size.width)
            //Trigger the finish if you are at the end
            if self.currentPanelIndex == self.panels.count {
                //Trigger the panel didDisappear appear method in the
                self.panels[self.pageControl.currentPage].panelDidDisappear()
                self.delegate?.introduction?(self, didFinishType: MYFinishType.SwypeOut.rawValue)
                self.removeFromSuperview()
            } else {
                //Assign the last page to be the previous current page
                self.lastPanelIndex = self.pageControl.currentPage
                
                //Trigger the panel did appear method, but skip on a bounce
                if self.pageControl.currentPage != self.currentPanelIndex {
                    self.panels[self.lastPanelIndex].panelDidDisappear()
                }
                
                //Update Page Control
                self.pageControl.currentPage = self.currentPanelIndex
                
                //Call Back, if applicable
                if lastPanelIndex != self.currentPanelIndex {
                    //Keeps from making the callback when just bouncing and not actually changing pages
                    self.delegate?.introduction?(self, didChangeToPanel: self.panels[self.currentPanelIndex], withIndex: self.currentPanelIndex)
                    
                    //Trigger the panel did appear method in the
                    self.panels[self.currentPanelIndex].panelDidDisappear()
                    
                    //Animate content to pop in nicely! :-)
                    self.animatePanelAtIndex(self.currentPanelIndex)
                }
            }
        } else {
            self.currentPanelIndex = Int((scrollView.contentOffset.x - self.frame.size.width) / self.masterScrollView.frame.size.width)
            
            if self.currentPanelIndex == -1 {
                self.delegate?.introduction?(self, didFinishType: MYFinishType.SwypeOut.rawValue)
                self.removeFromSuperview()
            } else {
                // Update Page Control
                self.lastPanelIndex = self.pageControl.currentPage
                self.pageControl.currentPage = self.currentPanelIndex
                
                // Call back if applicable
                if (self.lastPanelIndex != self.currentPanelIndex) {
                    //Keeps from making the callback when just bouncing and not actually changing pages
                    let index = self.panels.count - 1 - self.currentPanelIndex
                    self.delegate?.introduction?(self, didChangeToPanel: self.panels[index], withIndex: index)
                    //Trigger the panel did appear method in the
                    self.panels[index].panelDidDisappear()
                    
                    //Animate content to pop in nicely! :-)
                    self.animatePanelAtIndex(index)
                }
            }
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.currentPanelIndex = Int(scrollView.contentOffset.x / self.masterScrollView.frame.size.width)
        if self.languageDirection == MYLanguageDirection.LeftToRight && self.currentPanelIndex == self.panels.count - 1 {
            self.alpha = ((self.masterScrollView.frame.size.width * CGFloat(self.panels.count)) - self.masterScrollView.contentOffset.x)/self.masterScrollView.frame.size.width
        } else if self.languageDirection == MYLanguageDirection.RightToLeft && self.currentPanelIndex == 0 {
            self.alpha = self.masterScrollView.contentOffset.x / self.masterScrollView.frame.size.width
        }
    }
    
    // MARK:- Helper Method
    
    func animatePanelAtIndex(index: Int) {
        //If it is a custom panel, skip stock animation
        
        //Hide all labels
        for panel in self.panels {
            panel.hideContent()
        }
        self.panels[index].showContent()
    }
    
    func appendCloseViewAtXIndex(inout xIndex: CGFloat) {
        var closeView = UIView(frame: CGRect(x: xIndex, y: 0, width: self.frame.size.width, height: 400))
        self.masterScrollView.addSubview(closeView)
        xIndex += self.masterScrollView.frame.size.width
    }
    
    // MARK:- Interaction Method
    
    /**
    *  Handles the event that the skip button was tapped.
    */
    @IBAction func didPressSkipButton() {
        self.hideWithFadeOutDuration(0.3)
    }
    
    func hideWithFadeOutDuration(duration: NSTimeInterval) {
        UIView.animateWithDuration(duration, animations: {
            self.alpha = 0
            }, completion: { finished in
                if finished {
                    self.delegate?.introduction?(self, didFinishType: MYFinishType.SkipButton.rawValue)
                }
                self.removeFromSuperview()
        })
    }
    
    /**
    *  Changes the panel to a desired index. The index is relative to the array of panels passed in to the @em buildIntroductionWithPanels
    *
    *  @param index @b NSInteger The desired panel number to be changed to
    */
    func changeToPanelAtIndex(index: Int) {
        var currentIndex = self.languageDirection == MYLanguageDirection.LeftToRight ? self.currentPanelIndex : self.panels.count - 1 - self.currentPanelIndex
        
        if index < self.panels.count && currentIndex != index {
            // For right-to-left, PageControl index is the inverse of the panel indicies.
            self.panels[currentIndex].panelDidDisappear()
            
            let panelRect = self.panels[index].frame
            
            self.masterScrollView.scrollRectToVisible(panelRect, animated: true)
            self.currentPanelIndex = index
            self.animatePanelAtIndex(index)
            
            self.pageControl.currentPage = self.languageDirection == MYLanguageDirection.LeftToRight ? index : self.panels.count - 1 - index
            
            self.panels[index].panelDidAppear()
            
            //Callback to VC delegate, if appropriate
            self.delegate?.introduction?(self, didChangeToPanel: self.panels[index], withIndex: index)
        } else {
            println("index \(index) out of range for panels : [0..<\(self.panels.count)")
        }
    }
    
    /**
    *  Enables or disables use of the introductionView. Use this if you want to hold someone on a panel until they have completed some task
    *
    *  @param enabled @b BOOL The desired enabled status of the introduction view
    */
    func setEnabled(enabled: Bool) {
        UIView.animateWithDuration(0.3) {
            self.skipButton.enabled = enabled
            self.masterScrollView.scrollEnabled = enabled
        }
    }
}