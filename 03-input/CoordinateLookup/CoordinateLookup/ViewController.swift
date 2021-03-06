//
//  ViewController.swift
//  CoordinateLookup
//
//  Created by Jon Manning on 2/02/2015.
//  Copyright (c) 2015 Secret Lab. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    var geocoder = CLGeocoder()
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!

    @IBOutlet weak var addressTextView: UITextView!

    @IBAction func performLookup(sender: AnyObject) {
        // Cancel any existing geocode
        geocoder.cancelGeocode()
        
        
        // BEGIN geocode
        let addressString = self.addressTextView.text ?? "" // get the address from somewhere
        
        geocoder.geocodeAddressString(addressString) { (placemarks, error) -> Void in
            
            if error != nil {
                self.latitudeLabel.text = "Error!"
                self.longitudeLabel.text = "Error!"
            } else {
                
                guard let placemark = placemarks?.last else {
                    print("No placemarks provided!")
                    return
                }
                
                guard let location = placemark.location else {
                    print("Placemark has no location data!")
                    return
                }
                
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
                
                self.latitudeLabel.text = String(format: "Latitude: %.4f", latitude)
                self.longitudeLabel.text = String(format: "Longitude: %.4f", longitude)
            }
        }
        // END geocode
        self.addressTextView.resignFirstResponder()

    }

}

    
