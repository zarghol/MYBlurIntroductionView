CNBlurIntroductionView
======================


![Intro](https://raw.github.com/zarghol/MYBlurIntroductionView/master/Resources/Images/MYBlurIntroductionView.gif)

## A Controller Built With You In Mind

Inspired by MYBlurIntroductionView, this fork uses others technologies like UIPageViewController instead of a custom view, Auto-Layout instead of custom offset, swift languages instead of Objective-C

easier to use : 
Data in a new Class : CNIntroData just for title, description, image and custom header view
One Controller per Panel


## What to Include

### Manual Installation

CNBlurIntroductionViewController is dependent on the following files and frameworks
* <code>CNBlurIntroductionViewController.swift</code>
* <code>CNIntroductionViewController.swift</code>
* <code>CNIntroductionData.swift</code>
* <code>MYIntroductionPanel.swift</code>
* Requires ARC

## The Process

Creating an introduction view can basically be boiled down to these steps

1. Create datas
2. Create a CNBlurIntroductionViewController with storyboard is possible !
3. Add [CNIntroData] to CNBlurIntroductionViewController
4. present CNBlurIntroductionViewController
5. use the skipSegue to go after the end of the tutorial

## Creating Datas

One goal for CNBlurIntroductionViewController is to make the creation of stock (or "non-custom") panels just as easy as with MYIntroductionView. That's why the basic interface hasn't changed one bit. All content is optional and rearranges nicely for you.

To do that, you can use the new class <code>CNIntroData.swift</code>.
The header and the image are optionals

```swift
//Create data with header
let headerView = NSBundle.mainBundle().loadNibNamed("TestHeader", owner: nil, options: nil)[0] as UIView

// array of datas
var datas = [CNIntroData]()
// data 1 : with header and image
datas.append(CNIntroData(title: "Welcome to MYBlurIntroductionView", description: "MYBlurIntroductionView is a powerful platform for building app introductions and tutorials. Built on the MYIntroductionView core, this revamped version has been reengineered for beauty and greater developer control.", header: headerView, image: UIImage(named: "HeaderImage")!))
// data 2 : with image but without header
datas.append(CNIntroData(title: "Automated Stock Panels", description: "Need a quick-and-dirty solution for your app introduction? MYBlurIntroductionView comes with customizable stock panels that make writing an introduction a walk in the park. Stock panels come with optional blurring (iOS 7) and background image. A full panel is just one method away!", image: UIImage(named: "ForkImage.png")!))
// data 3 : without header and image
datas.append(CNIntroData(title: "Third Page", description: "description 3", image: UIImage()))

```

And here are the end results

![Panel1](https://raw.github.com/zarghol/MYBlurIntroductionView/master/Resources/Images/iOS%20Simulator%20Screen%20shot%20Oct%2017,%202013%203.09.52%20PM.png)
![Panel2](https://raw.github.com/zarghol/MYBlurIntroductionView/master/Resources/Images/iOS%20Simulator%20Screen%20shot%20Oct%2017,%202013%203.09.56%20PM.png)

