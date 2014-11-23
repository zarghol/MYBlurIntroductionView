//
//  CNIntroductionViewController.swift
//  testTuto
//
//  Created by Clément NONN on 22/11/2014.
//  Copyright (c) 2014 Clément NONN. All rights reserved.
//

import UIKit

let notificationSkipPushed = "notificationSkipPushed"

class CNIntroductionViewController: UIViewController {
    var data: CNIntroData?
    
    var panelView: MYIntroductionPanel!
    
    override func loadView() {
        super.loadView()
        self.panelView = MYIntroductionPanel(frame: self.view.frame, data: self.data!)
        self.view.addSubview(self.panelView)
    }
}
