//
//  MapViewController.swift
//  Places
//
//  Created by Dan Kwon on 6/29/16.
//  Copyright © 2016 Velocity360. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    var mapView: MKMapView!
    var currentLocation: CLLocation!
    var venueList: Array<Venue>!
    
    override func loadView() {
        let frame = UIScreen.mainScreen().bounds
        let view = UIView(frame: frame)
        view.backgroundColor = .greenColor()
        
        self.mapView = MKMapView(frame: frame)
        self.mapView.centerCoordinate = self.currentLocation.coordinate
        
        let dist = CLLocationDistance(1600)
        let region = MKCoordinateRegionMakeWithDistance(
            self.mapView.centerCoordinate,
            dist,
            dist
        )
        
        self.mapView.setRegion(region, animated: true)
        view.addSubview(self.mapView)
        self.view = view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.addAnnotations(self.venueList)
    }
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        
        let pinId = "pinId"
        if let pin = mapView.dequeueReusableAnnotationViewWithIdentifier(pinId) as? MKPinAnnotationView {
            pin.annotation = annotation
            return pin
        }
        
        let pin = MKPinAnnotationView(annotation: annotation, reuseIdentifier: pinId)
        pin.canShowCallout = true
        pin.animatesDrop = true
        
        return pin
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
