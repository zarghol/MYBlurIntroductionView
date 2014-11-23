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
    var introductionPanelNibName: String?
    
    private var panelView: MYIntroductionPanel!
    
    override func loadView() {
        super.loadView()
        self.panelView = self.data != nil ? MYIntroductionPanel(frame: self.view.frame, data: self.data!) : MYIntroductionPanel.loadWithNib(self.view.frame, nibNamed: introductionPanelNibName!)
        self.view.addSubview(self.panelView)
    }

}
