/*
* Copyright (c) 2015 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
class HomeController: RTPagingViewController {
      
    //@IBOutlet weak var myView: UIView!
    //var pageMenu : CAPSPageMenu?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWidget()
        
    }
   func setupWidget() {
            // Array to keep track of controllers in page menu
        var controllerArray : [UIViewController] = []
    
        self.title = "ThaiNation Park"
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc1:ListController = storyboard.instantiateViewControllerWithIdentifier("ListController") as! ListController
        let vc2:MapController = storyboard.instantiateViewControllerWithIdentifier("MapController") as! MapController
    
        vc1.title = "สถานที่ท่องเที่ยว"
        vc2.title = "แผนที่ตั้ง"
    
 
        controllerArray.append(vc1)
        controllerArray.append(vc2)
    
        let indicator = UIView(frame: CGRect(x: 0,y: 0,width: self.view.bounds.width/2,height: 4))
        var frame: CGRect = self.view.frame
        frame.size.height = 400
    
        indicator.backgroundColor = Theme.PageMenu.selectionIndicatorColor
        indicator.autoresizingMask = UIViewAutoresizing.FlexibleBottomMargin
        self.titleIndicatorView = indicator
        self.view.backgroundColor = Theme.PageMenu.backgroundColor
        self.controllers = [vc1,vc2]
        self.titleFont =  UIFont(name: "THSarabunNew", size: 15.0)!
        self.titleColor = UIColor.whiteColor()
        self.titleView.sizeToFit()
        self.selectedTitleColor =  UIColor(red: 124, green:255, blue:0, alpha: 1.0)
    
        self.currentControllerIndex = 0

     
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
