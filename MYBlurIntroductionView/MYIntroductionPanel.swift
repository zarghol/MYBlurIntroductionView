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
//



@IBDesignable public class MYIntroductionPanel : UIView {
    weak var parentIntroductionView: MYBlurIntroductionView?
    
    var headerView: UIView
    public var titleLabel: UILabel
    var descriptionLabel: UILabel
    public var separatorLine: UIView
    var imageView: UIImageView
    
    @IBInspectable var titleFont: UIFont {
        get {
            return self.titleLabel.font
        }
        
        set {
            self.titleLabel.font = newValue
        }
    }
    
    @IBInspectable var titleTextColor: UIColor {
        get {
            return self.titleLabel.textColor
        }
        
        set {
            self.titleLabel.textColor = newValue
        }
    }
    
    @IBInspectable var descriptionFont: UIFont {
        get {
            return self.descriptionLabel.font
        }
        
        set {
            self.descriptionLabel.font = newValue
        }
    }
    
    @IBInspectable var descriptionTextColor: UIColor {
        get {
            return self.descriptionLabel.textColor
        }
        
        set {
            self.descriptionLabel.textColor = newValue
        }
    }
    
    @IBInspectable var separatorLineColor: UIColor {
        get {
            return self.separatorLine.backgroundColor ?? UIColor.clearColor()
        }
        
        set {
            self.separatorLine.backgroundColor = newValue
        }
    }
    
    @IBInspectable var topPadding : CGFloat = 30.0 {
        didSet {
            self.updateConstraints()
        }
    }
    @IBInspectable var leftRightMargins : CGFloat = 10.0 {
        didSet {
            self.updateConstraints()
        }
    }
    @IBInspectable var bottomPadding : CGFloat = 48.0 {
        didSet {
            self.updateConstraints()
        }
    }
    @IBInspectable var headerTitlePadding : CGFloat = 10.0 {
        didSet {
            self.updateConstraints()
        }
    }
    @IBInspectable var titleSeparatorPadding : CGFloat = 2.0 {
        didSet {
            self.updateConstraints()
        }
    }
    @IBInspectable var descriptionImagePadding : CGFloat = 10.0 {
        didSet {
            self.updateConstraints()
        }
    }


    
    override convenience public init(frame: CGRect) {
        
        var header = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0))
        header.backgroundColor = UIColor.yellowColor()
        self.init(frame: frame, title: "Title", description: "description", image: UIImage(), headerView: header)
    }
    
    
    public init(frame: CGRect, title: String, description: String, image: UIImage, headerView: UIView) {
        // initialize constant
        
        self.headerView = headerView
        
        self.imageView = UIImageView(image: image)
        
        self.titleLabel = UILabel()
        self.titleLabel.text = title
        
        self.descriptionLabel = UILabel()
        self.descriptionLabel.text = description
        
        self.separatorLine = UIView()
        
        super.init(frame: frame)
        
        self.titleFont = UIFont.boldSystemFontOfSize(21.0)
        self.titleTextColor = UIColor.whiteColor()
        
        self.descriptionFont = UIFont.systemFontOfSize(14.0)
        self.descriptionTextColor = UIColor.whiteColor()
        
        self.separatorLineColor = UIColor(white: 0, alpha: 0.1)
                
        self.buildPanel()
        self.buildConstraints()
    }

    required public init(coder aDecoder: NSCoder) {

        self.headerView = UIView()
        self.imageView = UIImageView()
        self.titleLabel = UILabel()
        self.descriptionLabel = UILabel()
        self.separatorLine = UIView()

        super.init(coder: aDecoder)
        
        self.titleFont = UIFont.boldSystemFontOfSize(21.0)
        self.titleTextColor = UIColor.whiteColor()
        
        self.descriptionFont = UIFont.systemFontOfSize(14.0)
        self.descriptionTextColor = UIColor.whiteColor()
        
        self.separatorLineColor = UIColor(white: 0, alpha: 0.1)
        
        
        self.buildPanel()
        self.buildConstraints()
    }

    
    class func loadWithNib(frame: CGRect, nibNamed nibName:String) -> MYIntroductionPanel! {
        
        var panel =  NSBundle.mainBundle().loadNibNamed(nibName, owner: nil, options: nil)[0] as MYIntroductionPanel
        panel.frame = frame
        
        return panel
    }
    
    func panelDidAppear() {
        
    }
    
    func panelDidDisappear() {
        
    }
    
    func hideContent() {
        self.titleLabel.alpha = 0.0
        self.descriptionLabel.alpha = 0.0
        self.separatorLine.alpha = 0.0
        self.headerView.alpha = 0.0
        self.imageView.alpha = 0.0
    }
//
    func showContent() {
//        if isCustomPanel && !hasCustomAnimation {
//            return
//        }
//        
        //Get initial frames
        var initialHeaderFrame = self.headerView.frame
        var initialTitleFrame = self.titleLabel.frame
        var initialDescriptionFrame = self.descriptionLabel.frame
        var initialImageViewFrame = self.imageView.frame
        
        self.titleLabel.frame = initialTitleFrame.rectByOffsetting(dx: 10, dy: 0)
        self.descriptionLabel.frame = initialDescriptionFrame.rectByOffsetting(dx: 10, dy: 0)
        self.headerView.frame = initialHeaderFrame.rectByOffsetting(dx: 0, dy: -10)
        self.imageView.frame = initialImageViewFrame.rectByOffsetting(dx: 0, dy: 10)
        
        UIView.animateWithDuration(0.3, animations: {
            self.titleLabel.alpha = 1.0
            self.titleLabel.frame = initialTitleFrame
            self.separatorLine.alpha = 1.0
            
            self.headerView.alpha = 1.0
            self.headerView.frame = initialHeaderFrame
            }, completion: {finished in
                UIView.animateWithDuration(0.3) {
                    self.descriptionLabel.alpha = 1.0
                    self.descriptionLabel.frame = initialDescriptionFrame
                    self.imageView.alpha = 1.0
                    self.imageView.frame = initialImageViewFrame
                }
        })
    }
  
    func buildPanel() {
        [self, self.headerView, self.titleLabel, self.separatorLine, self.descriptionLabel, self.imageView].map{
            $0.setTranslatesAutoresizingMaskIntoConstraints(false)
        }

        self.addSubview(self.headerView)
        
        self.titleLabel.numberOfLines = 0
        
        self.titleLabel.sizeToFit()
        
        self.addSubview(self.titleLabel)
        self.addSubview(self.separatorLine)
        
        self.descriptionLabel.numberOfLines = 0
        
        self.descriptionLabel.sizeToFit()
        
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.imageView)
        
    }
    
    func buildConstraints() {
        self.updateConstraints()
    }
    
    func centerInSelf(view: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1.0,
            constant: 0.0)
    }
    
    func pinToLeadingSpace(view: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.LeadingMargin,
            multiplier: 1.0,
            constant: 0.0)
    }
    
    public override func updateConstraints() {
        var constraints = [NSLayoutConstraint]()

        var text = "V:|-topPadding-[headerView]-headerTitlePadding-[titleLabel]-separatorPadding-[separatorLine(1.0)]-separatorPadding-[descriptionLabel]-descriptionImagePadding-[imageView]->=0.0-|"
        

        var views = ["headerView" : self.headerView,
            "titleLabel" : self.titleLabel,
            "separatorLine" : self.separatorLine,
            "descriptionLabel" : self.descriptionLabel,
            "imageView" : self.imageView]
        
        var metrics = ["topPadding" : self.topPadding,
            "leftRightMargins" : self.leftRightMargins,
            "bottomPadding" : self.bottomPadding,
            "headerTitlePadding" : self.headerTitlePadding,
            "separatorPadding" : self.titleSeparatorPadding,
            "descriptionImagePadding" : self.descriptionImagePadding]

        NSLayoutConstraint.constraintsWithVisualFormat(text, options: nil, metrics: metrics, views: views).map{
            constraints.append($0 as NSLayoutConstraint)
        }

        constraints.append(self.centerInSelf(self.headerView))
        constraints.append(self.centerInSelf(self.imageView))

        constraints.append(self.pinToLeadingSpace(self.titleLabel))
        constraints.append(self.pinToLeadingSpace(self.descriptionLabel))

        var textSeparatorLine = "|-[separatorLine]-|"

        NSLayoutConstraint.constraintsWithVisualFormat(textSeparatorLine, options: nil, metrics: nil, views: views).map{
            constraints.append($0 as NSLayoutConstraint)
        }
        
        self.addConstraints(constraints)

        super.updateConstraints()
    }
    
    public override func intrinsicContentSize() -> CGSize {
        return self.frame.size
    }
    
    override public class func requiresConstraintBasedLayout() -> Bool {
        return true
    }
}