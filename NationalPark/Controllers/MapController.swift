//
//  MapController.swift
//
//
//  Created by Peerapun Sangpun on 3/15/2559 BE.
//  Copyright © 2559 Peerapun Sangpun. All rights reserved.
//

import UIKit
import RealmSwift


class MapController: UIViewController ,CLLocationManagerDelegate,GMSMapViewDelegate  {
    
    var locationManager = CLLocationManager()
    var places:Results<Place>?
    var didFindUserLocation = false
    @IBOutlet var mapView: GMSMapView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if (CLLocationManager.locationServicesEnabled())
        {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        let camera = GMSCameraPosition.cameraWithLatitude(13.885251, longitude: 99.126506, zoom: 5)
        let mapView = GMSMapView.mapWithFrame(CGRectZero, camera: camera)
        mapView.myLocationEnabled = true
        mapView.delegate = self
        //mapView.addObserver(self, forKeyPath: "myLocation", options: .New, context: nil)
        //                self.view = mapView
        self.view = mapView
        /*
        
        */
    
        do {
            places =  try Realm().objects(Place)
         
            
        } catch var _ as NSError {
            // handle error
        }
        
        for   place in places! {
            //addMarker(contact.name,latitude: contact.latitude,longitude: contact.longitude)
            //print("place:\(place.latitude,place.longitude)")
            if  place.latitude > 0.0 && place.longitude > 0.0 {
                
                let c2D: CLLocationCoordinate2D  = CLLocationCoordinate2DMake(place.latitude, place.longitude)
                let marker = GMSMarker()
                marker.position = c2D
                marker.title = place.attraction_th
                marker.snippet = place.type_th
                marker.icon = UIImage(named: "marker")
                marker.map = mapView
                marker.userData = place
            }
           
           
        }
        
        

        //loadMap(13.6744682,longitude:100.4678154)
    }
 
    
    func mapView(mapView: GMSMapView, didTapInfoWindowOfMarker marker: GMSMarker) {
      
        let place:Place = marker.userData as! Place
        let latitude:String = String(place.latitude)
        let longitude:String = String(place.longitude)
        if (UIApplication.sharedApplication().canOpenURL(NSURL(string:"comgooglemaps://")!)) {
            UIApplication.sharedApplication().openURL(NSURL(string:
                "comgooglemaps://?q=\(latitude),\(longitude)&zoom=14&views=traffic")!)
        } else {
            print("Can't use comgooglemaps://");
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
         SVProgressHUD.dismiss()
        // Dispose of any resources that can be recreated.
    }
    
    
    func mapViewDidStartTileRendering(mapView: GMSMapView) {
        //SVProgressHUD.showWithStatus("Loading data..")
    }
    
    func mapViewDidFinishTileRendering(mapView: GMSMapView) {
        //SVProgressHUD.dismiss()
    }
    
    
}