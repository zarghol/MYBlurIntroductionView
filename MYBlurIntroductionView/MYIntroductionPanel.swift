//
//  MYIntroductionPanel.swift
//  
//
//  Created by Clément NONN on 21/11/2014.
//
//

import UIKit
import Foundation


// File Panel
// TODO: add to panel for Interface Builder
let topPadding : CGFloat = 30.0
let leftRightMargins : CGFloat = 10.0
let bottomPadding : CGFloat = 48.0
let headerTitlePadding : CGFloat = 10.0
let titleDescriptionPadding : CGFloat = 10.0
let descriptionImagePadding : CGFloat = 10.0

var titleFont: UIFont = UIFont.boldSystemFontOfSize(21.0)
var titleTextColor: UIColor = UIColor.whiteColor()
var descriptionFont: UIFont = UIFont.systemFontOfSize(14.0)
var descriptionTextColor: UIColor = UIColor.whiteColor()
var separatorLineColor: UIColor = UIColor(white: 0, alpha: 0.1)



class MYIntroductionPanel : UIView {
    //weak var parentIntroductionView: MYBlurIntroductionView?
    private var panelHeaderView: UIView?
    private(set)var panelTitle: String
    private(set)var panelDescription: String
    private var panelTitleLabel: UILabel
    private var panelDescriptionLabel: UILabel
    var panelSeparatorLine: UIView
    private var panelImageView: UIImageView?
    
    private(set) var isCustomPanel: Bool
    private(set) var hasCustomAnimation: Bool
    
    
    init(frame: CGRect, title: String, description: String, image: UIImage? = nil, headerView: UIView? = nil) {
        // initialize constant
        
        self.panelHeaderView = headerView
        self.panelTitle = title
        self.panelDescription = description
        self.isCustomPanel = false
        self.hasCustomAnimation = false
        if let img = image {
            self.panelImageView = UIImageView(image: img)
        }
        self.panelTitleLabel = UILabel()
        self.panelDescriptionLabel = UILabel()
        self.panelSeparatorLine = UIView()
        super.init(frame: frame)
        self.buildPanelWithFrame(frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func loadWithNib(frame: CGRect, nibNamed nibName:String) -> MYIntroductionPanel! {
        
        var panel =  NSBundle.mainBundle().loadNibNamed(nibName, owner: nil, options: nil)[0] as MYIntroductionPanel
        panel.frame = frame
        panel.isCustomPanel = true
        panel.hasCustomAnimation = false
        
        return panel
    }
    
    
    func buildPanelWithFrame(frame: CGRect) {
        
        
        var runningYOffset = topPadding
        
        //Process panel header view, if it exists
        if var header = self.panelHeaderView {
            header.frame = CGRect(x: (frame.size.width - header.frame.size.width) / 2, y: runningYOffset, width: header.frame.size.width, height: header.frame.size.height)
            self.addSubview(header)
            runningYOffset += header.frame.size.height + headerTitlePadding
        }
        
        //Calculate title and description heights
        var panelTitleHeight: CGFloat = 0.0
        var panelDescriptionHeight: CGFloat = 0.0
        
        // title
        let titleAttributes = NSDictionary(object: titleFont, forKey: NSFontAttributeName)
        panelTitleHeight = NSString(string: self.panelTitle).boundingRectWithSize(CGSize(width: frame.size.width - 2 * leftRightMargins, height: CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: titleAttributes, context: nil).size.height
        
        panelTitleHeight = ceil(panelTitleHeight)
        
        // description
        let descriptionAttributes = NSDictionary(object: descriptionFont, forKey: NSFontAttributeName)
        panelDescriptionHeight = NSString(string: self.panelDescription).boundingRectWithSize(CGSize(width: frame.size.width - 2 * leftRightMargins, height: CGFloat.infinity), options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: descriptionAttributes, context: nil).size.height
        
        panelDescriptionHeight = ceil(panelDescriptionHeight)
        
        // Create titleLabel
        self.panelTitleLabel = UILabel(frame: CGRect(x: leftRightMargins, y: runningYOffset, width: frame.size.width - 2 * leftRightMargins, height: panelTitleHeight))
        self.panelTitleLabel.numberOfLines = 0
        self.panelTitleLabel.text = self.panelTitle
        self.panelTitleLabel.font = titleFont
        self.panelTitleLabel.textColor = titleTextColor
        self.panelTitleLabel.alpha = 0.0
        self.panelTitleLabel.backgroundColor = UIColor.clearColor()
        self.addSubview(self.panelTitleLabel)
        
        runningYOffset += panelTitleHeight + titleDescriptionPadding
        
        //Add small line in between title and description
        self.panelSeparatorLine = UIView(frame: CGRect(x: leftRightMargins, y: runningYOffset - 0.5 * titleDescriptionPadding, width: frame.size.width - 2 * leftRightMargins, height: 1))
        self.panelSeparatorLine.backgroundColor = separatorLineColor
        self.addSubview(self.panelSeparatorLine)
        
        //Create description label
        self.panelDescriptionLabel = UILabel(frame: CGRect(x: leftRightMargins, y: runningYOffset, width: frame.size.width - 2 * leftRightMargins, height: panelDescriptionHeight))
        self.panelDescriptionLabel.numberOfLines = 0
        self.panelDescriptionLabel.text = self.panelDescription
        self.panelDescriptionLabel.font = descriptionFont
        self.panelDescriptionLabel.textColor = descriptionTextColor
        self.panelDescriptionLabel.alpha = 0.0
        self.panelDescriptionLabel.backgroundColor = UIColor.clearColor()
        self.addSubview(self.panelDescriptionLabel)
        
        runningYOffset += panelDescriptionHeight + descriptionImagePadding
        
        //Add image, if there is room
        if var imageView = self.panelImageView {
            imageView.frame = CGRect(x: leftRightMargins, y: runningYOffset, width: self.frame.size.width - 2 * leftRightMargins, height: self.frame.size.height - runningYOffset - bottomPadding)
            imageView.contentMode = UIViewContentMode.Center
            imageView.clipsToBounds = true
            self.addSubview(imageView)
        }
        
        if self.isCustomPanel {
            self.hasCustomAnimation = true
        }
    }
    
    func panelDidAppear() {
        
    }
    
    func panelDidDisappear() {
        
    }
    
    func hideContent() {
        self.panelTitleLabel.alpha = 0.0
        self.panelDescriptionLabel.alpha = 0.0
        self.panelSeparatorLine.alpha = 0.0
        self.panelHeaderView?.alpha = 0.0
        self.panelImageView?.alpha = 0.0
    }
    
    func showContent() {
        if isCustomPanel && !hasCustomAnimation {
            return
        }
        
        //Get initial frames
        var initialHeaderFrame = self.panelHeaderView?.frame ?? CGRectZero
        var initialTitleFrame = self.panelTitleLabel.frame
        var initialDescriptionFrame = self.panelDescriptionLabel.frame
        var initialImageViewFrame = self.panelImageView?.frame ?? CGRectZero
        
        self.panelTitleLabel.frame = initialTitleFrame.rectByOffsetting(dx: 10, dy: 0)
        self.panelDescriptionLabel.frame = initialDescriptionFrame.rectByOffsetting(dx: 10, dy: 0)
        self.panelHeaderView?.frame = initialHeaderFrame.rectByOffsetting(dx: 0, dy: -10)
        self.panelImageView?.frame = initialImageViewFrame.rectByOffsetting(dx: 0, dy: 10)
        
        UIView.animateWithDuration(0.3, animations: {
            self.panelTitleLabel.alpha = 1.0
            self.panelTitleLabel.frame = initialTitleFrame
            self.panelSeparatorLine.alpha = 1.0
            
            self.panelHeaderView?.alpha = 1.0
            self.panelHeaderView?.frame = initialHeaderFrame
            }, completion: {finished in
                UIView.animateWithDuration(0.3) {
                    self.panelDescriptionLabel.alpha = 1.0
                    self.panelDescriptionLabel.frame = initialDescriptionFrame
                    self.panelImageView?.alpha = 1.0
                    self.panelImageView?.frame = initialImageViewFrame
                }
        })
    }
}