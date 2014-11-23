//
//  extension.swift
//  testTuto
//
//  Created by Clément NONN on 23/11/2014.
//  Copyright (c) 2014 Clément NONN. All rights reserved.
//

import Foundation

extension UIView {
    func pinToLeadingSpace(view: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.Leading,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.LeadingMargin,
            multiplier: 1.0,
            constant: 0.0)
    }
    
    func pinToTrailingSpace(view: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.Trailing,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.TrailingMargin,
            multiplier: 1.0,
            constant: 0.0)
    }
    
    func pinToBottomSpace(view: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.BottomMargin,
            multiplier: 1.0,
            constant: 0.0)
    }
    
    func pinToTopSpace(view: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.Top,
            relatedBy: NSLayoutRelation.Equal,
            toItem: self,
            attribute: NSLayoutAttribute.TopMargin,
            multiplier: 1.0,
            constant: 0.0)
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
    
    
}