//
//  photoViewController.swift
//  DropIt
//
//  Created by Apple on 9/26/15.
//  Copyright © 2015 DropItLikeItsHot. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

class PhotoViewController: UIViewController, MKMapViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    
    // Our View Properties
    @IBOutlet var map: MKMapView!
    @IBOutlet var takePhoto: UIButton!
    @IBOutlet var summaryTextField: UITextField!
    @IBOutlet var customPinDrop: UIButton!
    var LastPhoto: UIImage?
    
    var PhotoPointArr: [PhotoPoint] = [PhotoPoint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.showsUserLocation = true
        map.delegate = self
        self.summaryTextField.delegate = self
    }
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        map.centerCoordinate = (userLocation.location?.coordinate)!
        
        let userLocation = map.userLocation
        
        let region = MKCoordinateRegionMakeWithDistance((userLocation.location?.coordinate)!, 2000, 2000)
        
        map.setRegion(region, animated: true)
        
    }

    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        for photoPoint in PhotoPointArr {
            if photoPoint.annotation.coordinate.latitude == annotation.coordinate.latitude && photoPoint.annotation.coordinate.longitude == annotation.coordinate.longitude {
                let reuseIdent = "photoPointReuseIdentifier"
                var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseIdent)
                if (annotationView == nil) {
                    annotationView = MKPinAnnotationView(annotation: photoPoint.annotation, reuseIdentifier: reuseIdent)
                }
                annotationView!.canShowCallout = true
                
                var myphoto: UIImageView = UIImageView(image: photoPoint.photo)
                var frame = myphoto.frame
                frame.size.height = 50
                frame.size.width = 50
                
                myphoto.frame = frame
                
                annotationView?.leftCalloutAccessoryView = myphoto
                return annotationView
            }
        }
        return nil
    }
    
    func textFieldShouldReturn(userText: UITextField) -> Bool {
        userText.resignFirstResponder()
        return true;
    }
    

    // Our View functions and actions
    @IBAction func takePhoto(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            imagePicker.sourceType = .Camera
        }else{
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
//        var photo = MKAnnotationView()
        let photo  = info[UIImagePickerControllerOriginalImage] as! UIImage
        LastPhoto = photo
        dismissViewControllerAnimated(true){ () -> Void in
        }
    }
    
    @IBAction func dropCustom(sender: AnyObject) {
        
        // if there's a photo && if there's a summary
        // else alert
        if(self.summaryTextField != ""){
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2DMake(self.map.userLocation.coordinate.latitude, self.map.userLocation.coordinate.longitude)
            annotation.title = summaryTextField.text
            let newPhotoPoint = PhotoPoint(pinLocation: annotation.coordinate, annotation: annotation)
            newPhotoPoint.photo = LastPhoto
            newPhotoPoint.annotation = annotation;
            PhotoPointArr += [newPhotoPoint]
            if let theSummary = summaryTextField.text where theSummary != "" {
                newPhotoPoint.summary = theSummary
            }
            self.map.addAnnotation(annotation)
        }
    }
}