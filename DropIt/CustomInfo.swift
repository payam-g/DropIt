//
//  CustomInfo.swift
//  DropIt
//
//  Created by Apple on 9/26/15.
//  Copyright © 2015 DropItLikeItsHot. All rights reserved.
//

import Foundation
import MapKit

class CustomInfo: NSObject, MKAnnotation {
    let summary = String
    let coordinate = CLLocationCoordinate2D
    
    init(summary: String, coordinate: CLLocationCoordinate2D){
        self.summary = summary
        self.coordinate = coordinate
        
        super.init()
    }
}
