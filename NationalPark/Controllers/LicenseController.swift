//
//  ViewController.swift
//  Msociety
//
//  Created by Peerapun Sangpun on 7/5/2559 BE.
//  Copyright © 2559 Peerapun Sangpun. All rights reserved.
//

import UIKit
import Crashlytics

class LicenseController: UIViewController {

    
    @IBOutlet weak var webView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
 
  
 
        do {
            let localfilePath = NSBundle.mainBundle().URLForResource("license", withExtension: "html");
            let myRequest = NSURLRequest(URL: localfilePath!);
            webView.loadRequest(myRequest);
        }
        catch _ {
             
        }
         
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func crashButtonTapped(sender: AnyObject) {
        Crashlytics.sharedInstance().crash()
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
