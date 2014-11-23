//
//  ViewController.swift
//  testTuto
//
//  Created by Clément NONN on 23/11/2014.
//  Copyright (c) 2014 Clément NONN. All rights reserved.
//

import UIKit
import tutokit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        println(self.view.bounds)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let identifier = segue.identifier {
            if identifier == "BlurIntroductionSegue" {
                var viewController = segue.destinationViewController as CNBlurIntroductionViewController
                
                let headerView = NSBundle.mainBundle().loadNibNamed("TestHeader", owner: nil, options: nil)[0] as UIView
                
                
                var datas = [CNIntroData]()
                datas.append(CNIntroData(title: "Welcome to MYBlurIntroductionView", description: "MYBlurIntroductionView is a powerful platform for building app introductions and tutorials. Built on the MYIntroductionView core, this revamped version has been reengineered for beauty and greater developer control.", header: headerView, image: UIImage(named: "HeaderImage")!))
                datas.append(CNIntroData(title: "Automated Stock Panels", description: "Need a quick-and-dirty solution for your app introduction? MYBlurIntroductionView comes with customizable stock panels that make writing an introduction a walk in the park. Stock panels come with optional blurring (iOS 7) and background image. A full panel is just one method away!", image: UIImage(named: "ForkImage.png")!))
                datas.append(CNIntroData(title: "Troisieme Page", description: "description 3", image: UIImage()))
                
                
                viewController.panelsData = datas
                viewController.backgroundImage = UIImage(named: "toronto")
            }
        }
    }


}
