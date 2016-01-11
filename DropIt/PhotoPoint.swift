//
//  PhotoPoint.swift
//  DropIt
//
//  Created by Apple on 9/26/15.
//  Copyright © 2015 DropItLikeItsHot. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class PhotoPoint {
    
    let coorodinate: CLLocationCoordinate2D
    var photo: UIImage?
    var summary: String?
    var annotation: MKPointAnnotation
    
    init(pinLocation: CLLocationCoordinate2D, annotation: MKPointAnnotation) {
        self.coorodinate = pinLocation
        self.annotation = annotation
    }
    
    
}

