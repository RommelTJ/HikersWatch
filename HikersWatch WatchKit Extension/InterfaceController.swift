//
//  InterfaceController.swift
//  HikersWatch WatchKit Extension
//
//  Created by Rommel Rico on 4/17/15.
//  Copyright (c) 2015 Rommel Rico. All rights reserved.
//

import WatchKit
import Foundation
import CoreLocation


class InterfaceController: WKInterfaceController, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    var userlocationInfo = [String]()
    
    @IBOutlet weak var table: WKInterfaceTable!
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let locationArray = locations as NSArray
        let location = locationArray.lastObject as! CLLocation
        
        userlocationInfo.removeAll(keepCapacity: true)
        //Get latitude
        userlocationInfo.append("Lat: \(location.coordinate.latitude)")
        //Get longitude
        userlocationInfo.append("Lon: \(location.coordinate.longitude)")
        //Get altitude
        userlocationInfo.append("Alt: \(location.altitude)")
        //Get speed
        userlocationInfo.append("Speed: \(location.speed)")
        //Get course
        userlocationInfo.append("Course: \(location.course)")
        
        println(userlocationInfo)
        
        table.setNumberOfRows(userlocationInfo.count, withRowType: "tableRowController")
        for (index, value) in enumerate(userlocationInfo) {
            let row = table.rowControllerAtIndex(index) as! tableRowController
            row.tableRowLabel.setText(value)
        }
    }

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
