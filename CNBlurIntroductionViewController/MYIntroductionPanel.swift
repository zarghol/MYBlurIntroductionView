//
//  MYIntroductionPanel.swift
//  
//
//  Created by Clément NONN on 21/11/2014.
//
//

import UIKit
import Foundation


public class MYIntroductionPanel : UIView {
    var headerView: UIView
    var titleLabel: UILabel
    var descriptionLabel: UILabel
    var separatorLine: UIView
    var imageView: UIImageView
    
    var titleFont: UIFont {
        get {
            return self.titleLabel.font
        }
        
        set {
            self.titleLabel.font = newValue
        }
    }
    
    public var titleTextColor: UIColor {
        get {
            return self.titleLabel.textColor
        }
        
        set {
            self.titleLabel.textColor = newValue
        }
    }
    
    var descriptionFont: UIFont {
        get {
            return self.descriptionLabel.font
        }
        
        set {
            self.descriptionLabel.font = newValue
        }
    }
    
    public var descriptionTextColor: UIColor {
        get {
            return self.descriptionLabel.textColor
        }
        
        set {
            self.descriptionLabel.textColor = newValue
        }
    }
    
    public var separatorLineColor: UIColor {
        get {
            return self.separatorLine.backgroundColor ?? UIColor.clearColor()
        }
        
        set {
            self.separatorLine.backgroundColor = newValue
        }
    }
    
    var topPadding : CGFloat = 30.0 {
        didSet {
            self.updateConstraints()
        }
    }
    var leftRightMargins : CGFloat = 10.0 {
        didSet {
            self.updateConstraints()
        }
    }
    var bottomPadding : CGFloat = 48.0 {
        didSet {
            self.updateConstraints()
        }
    }
    var headerTitlePadding : CGFloat = 10.0 {
        didSet {
            self.updateConstraints()
        }
    }
    var titleSeparatorPadding : CGFloat = 2.0 {
        didSet {
            self.updateConstraints()
        }
    }
    var descriptionImagePadding : CGFloat = 10.0 {
        didSet {
            self.updateConstraints()
        }
    }

    
    override convenience public init(frame: CGRect) {
        var data = CNIntroData(title: "Title", description: "description", image: UIImage())

        self.init(frame: frame, data: data)
    }
    
    
    public init(frame: CGRect, data: CNIntroData) {
        
        self.headerView = data.header ?? UIView()
        
        self.imageView = UIImageView(image: data.image)
        
        self.titleLabel = UILabel()
        self.titleLabel.text = data.title
        self.titleLabel.numberOfLines = 0

        
        self.descriptionLabel = UILabel()
        self.descriptionLabel.text = data.description
        self.descriptionLabel.numberOfLines = 0
        
        self.separatorLine = UIView()
        
        super.init(frame: frame)
        
        self.titleFont = UIFont.boldSystemFontOfSize(21.0)
        self.titleTextColor = UIColor.blackColor()
        
        self.descriptionFont = UIFont.systemFontOfSize(14.0)
        self.descriptionTextColor = UIColor.blackColor()
        
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
  
    func buildPanel() {
        [self, self.headerView, self.titleLabel, self.separatorLine, self.descriptionLabel, self.imageView].map{
            $0.setTranslatesAutoresizingMaskIntoConstraints(false)
        }

        self.addSubview(self.headerView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.separatorLine)
        self.addSubview(self.descriptionLabel)
        self.addSubview(self.imageView)
    }
    
    func buildConstraints() {
        self.updateConstraints()
    }
    
    public override func updateConstraints() {
        var constraints = [NSLayoutConstraint]()

        var text = "V:|-topPadding-[headerView(sizeHeaderHeight)]-headerTitlePadding-[titleLabel]-separatorPadding-[separatorLine(1.0)]-separatorPadding-[descriptionLabel]-descriptionImagePadding-[imageView]->=0.0-|"
        

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
            "descriptionImagePadding" : self.descriptionImagePadding,
            "sizeLabel" : self.frame.size.width - self.leftRightMargins,
            "sizeHeaderWidth" : self.headerView.frame.width,
            "sizeHeaderHeight" : self.headerView.frame.height,
            "sizeHeaderMax" : self.frame.size.width]

        NSLayoutConstraint.constraintsWithVisualFormat(text, options: nil, metrics: metrics, views: views).map{
            constraints.append($0 as NSLayoutConstraint)
        }

        constraints.append(self.centerInSelf(self.headerView))
        constraints.append(self.centerInSelf(self.imageView))

        constraints.append(self.pinToLeadingSpace(self.titleLabel))
        constraints.append(self.titleLabel.fixWidth(metrics["sizeLabel"]!))

        
        constraints.append(self.pinToLeadingSpace(self.descriptionLabel))
        constraints.append(self.descriptionLabel.fixWidth(metrics["sizeLabel"]!))
        
        constraints.append(self.headerView.fixWidth(metrics["sizeHeaderWidth"]!))

        NSLayoutConstraint.constraintsWithVisualFormat("|-[separatorLine]-|", options: nil, metrics: metrics, views: views).map{
            constraints.append($0 as NSLayoutConstraint)
        }
        
        self.removeConstraints(constraints)
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