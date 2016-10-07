//
//  NearByController.swift
//  Swift-Base
//
//  Created by Peerapun Sangpun on 5/15/2559 BE.
//  Copyright © 2559 Flatstack. All rights reserved.
//

import UIKit
import RealmSwift

class PropertyCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}



class ListController  :  UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchResultsUpdating {
    var imageCache = [String:UIImage]()
    var places:Results<Place>?
    var filtered:Results<Place>?
    var data: NSArray?
    var searchActive : Bool = false
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var content: UIView!
    var resultSearchController = UISearchController()
  
    //@IBOutlet weak var searchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.hideKeyboardWhenTappedAround()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let tempImageView = UIImageView(image: UIImage(named: "background"))
        tempImageView.frame = self.tableView.frame
        self.tableView.backgroundView = tempImageView;
        self.tableView.separatorColor = UIColor.clearColor()
        UITextField.appearanceWhenContainedInInstancesOfClasses([UISearchController.self]).textColor = UIColor.whiteColor()

        //tableView.estimatedRowHeight = 300
        //tableView.rowHeight = UITableViewAutomaticDimension
        //searchBar.delegate = self
        
        do {
            let realm = try Realm()
            
            
            places = realm.objects(Place)
        } catch _ as NSError {
            // handle error
        }

        if #available(iOS 9.0, *) {
            self.resultSearchController.loadViewIfNeeded()// iOS 9
        } else {
            // Fallback on earlier versions
            let _ = self.resultSearchController.view          // iOS 8
        }

        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.hidesNavigationBarDuringPresentation = true
            controller.dimsBackgroundDuringPresentation = false
            
            controller.searchBar.tintColor = UIColor.whiteColor()
            controller.searchBar.barTintColor = UIColor.whiteColor()
            controller.searchBar.searchBarStyle = .Minimal
            controller.searchBar.sizeToFit()
            controller.searchResultsUpdater = self
            self.tableView.tableHeaderView = controller.searchBar
            return controller
        })()
        
        self.tableView.reloadData()
        
    }
 
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        if searchController.searchBar.text?.characters.count > 0 {
            
            let predicate = NSPredicate(format: "attraction_th CONTAINS [c]%@", searchController.searchBar.text!);
            do {
                filtered = try Realm().objects(Place).filter(predicate).sorted("attraction_th", ascending: true)
            } catch {
                
            }
            
        }
        else {
              filtered = places
        }
       self.tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
 
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.resultSearchController.active {
            return filtered!.count
        }
        return (places?.count)!;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "MyTestCell")
        let cell = tableView.dequeueReusableCellWithIdentifier("TableCell", forIndexPath: indexPath) as! PropertyCell
         let place: Place
        if(self.resultSearchController.active){
            place = filtered![indexPath.row] as Place
        } else {
            place = places![indexPath.row] as Place
        }
        
        //let contact: Contact = self.data![indexPath.row] as! Contact
        cell.lblTitle?.text =  place.attraction_th
        cell.lblDescription?.text = "\(place.organization_th) เปิดทำการ :\(place.open_hour) เบอร์ติดต่อ:\(place.contact) ต.\(place.sub_district) อ.\(place.district) \(place.province)"
        //cell.imgLogo?.imageFromUrl(place!.image_url)
        cell.imgLogo?.image = UIImage(named: "mypic")
 
        
        let urlString :String = place.image_url
        _ = indexPath
        _ = NSURL(string: urlString)
        // If this image is already cached, don't re-download
        if let img = imageCache[urlString] {
            cell.imgLogo?.image = img
        }
        else {
            FetchAsync(url: urlString) { data in // code is at bottom, this just drys things up
                if(data != nil) {
                    let image = UIImage(data: data!)
                    if( image != nil) {
                        print("ur:\(urlString)")
                        self.imageCache[urlString] = image
                        dispatch_async(dispatch_get_main_queue(), {
                             cell.imgLogo?.image = image
                        })
                    }
                }
            }
        }

        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        let place: Place
        if(self.resultSearchController.active){
            place = filtered![indexPath.row] as Place
        } else {
            place = places![indexPath.row] as Place
        }
        
        if let phoneCallURL = NSURL(string: "tel:\(place.contact)") {
            let application = UIApplication.sharedApplication()
            if application.canOpenURL(phoneCallURL) {
                application.openURL(phoneCallURL)
            }
            else{
                alert("Cannot call phone!")
            }
        }
    }
    
 
}

