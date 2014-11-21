//
//  MYBlurIntroductionView.swift
//  
//
//  Created by Clément NONN on 21/11/2014.
//
//

import Foundation
import UIKit

let pageControlWidth = 148
let leftRightSkipPadding = 10

enum MYFinishType {
    case SwypeOut
    case SkipButton
}

enum MYLanguageDirection {
    case LeftToRight
    case RightToLeft
}

protocol MYIntroductionDelegate {
    func introduction(introductionView: MYBlurIntroductionView, didFinishType finishType:MYFinishType)
    func introduction(introductionView: MYBlurIntroductionView, didChangeToPanel panel:MYIntroductionPanel)
}

class MYBlurIntroductionView : UIView, UIScrollViewDelegate {
    var panels: [MYIntroductionPanel]
    var lastPanelIndex: Int
    
    weak var delegate: MYIntroductionDelegate?
    var blurView: UIView
    var backgroundColorView: UIView
    var backgroundImageView: UIImageView
    var masterScrollView: UIScrollView
    var pageControl: UIPageControl
    var rightSkipButton: UIButton
    var leftSkipButton: UIButton
    var currentPanelIndex: Int
    var languageDirection: MYLanguageDirection
    var userBackgroundColor: UIColor
    
    
    
    init(frame: CGRect) {
        self.masterScrollView.delegate = self
        self.frame = frame
        super.init(frame: frame)
        self.initializeViewComponents()
    }
    
    func initializeViewComponents() {
        // backgroundImageView
        self.backgroundImageView = UIImageView(frame: self.frame)
        self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill
        
    }
    
    
    /**
    *  Public method used to build panels
    *
    *  @param panels @b Array of MYIntroductionPanel objects
    */
    func buildIntroductionWithPanels(panels: [MYIntroductionPanel]) {
        
    }
    
    /**
    *  Handles the event that the skip button was tapped.
    */
    @IBAction func didPressSkipButton() {
        
    }
    
    /**
    *  Changes the panel to a desired index. The index is relative to the array of panels passed in to the @em buildIntroductionWithPanels
    *
    *  @param index @b NSInteger The desired panel number to be changed to
    */
    func changeToPanelAtIndex(index: Int) {
        
    }
    
    /**
    *  Enables or disables use of the introductionView. Use this if you want to hold someone on a panel until they have completed some task
    *
    *  @param enabled @b BOOL The desired enabled status of the introduction view
    */
    func setEnabled(enabled: bool);

}