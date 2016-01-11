//
//  ViewController.swift
//  PinDrop
//
//  Created by Apple on 9/26/15.
//  Copyright © 2015 DropItLikeItsHot. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate, UINavigationControllerDelegate {
   
    @IBOutlet var map: MKMapView!
    
    var DB = [PhotoPoint]()

    override func viewDidLoad() {
        
        super.viewDidLoad()

        map.showsUserLocation = true
        map.delegate = self
        
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        map.centerCoordinate = (userLocation.location?.coordinate)!
        
        let userLocation = map.userLocation
        
        let region = MKCoordinateRegionMakeWithDistance((userLocation.location?.coordinate)!, 2000, 2000)
        
        map.setRegion(region, animated: true)
        
    }
    
    @IBAction func button(sender: UIButton) {
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = CLLocationCoordinate2DMake(self.map.userLocation.coordinate.latitude, self.map.userLocation.coordinate.longitude)
        
        let newPhotoPoint = PhotoPoint(pinLocation: annotation.coordinate, annotation: annotation)
        
        DB.append(newPhotoPoint)
        
        self.map.addAnnotation(annotation)
    
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
