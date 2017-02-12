//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by James Honeyball on 28/01/2017.
//  Copyright © 2017 James Honeyball. All rights reserved.
//

import MapKit
import UIKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("MapViewController loaded it's view.")
    }
    
    var mapView: MKMapView!
    let manager = CLLocationManager()

    func buttonAction(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        if btnsendtag.tag == 1 {
            mapView.setUserTrackingMode(.follow, animated: true)
        }
    }

    override func loadView() {
        mapView = MKMapView()
        manager.delegate = self
        
        view = mapView
        
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)



        let zoomButton: UIButton = UIButton(type: UIButtonType.contactAdd)
//        zoomButton.backgroundColor = UIColor.green
//        zoomButton.setTitle("Click Me", for: .normal)
        zoomButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        zoomButton.tag = 1
        zoomButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(zoomButton)

        

        
        

        let margins = view.layoutMarginsGuide
        
        let scTopConstraint = segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 8)
        let scLeadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let scTrailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        scTopConstraint.isActive = true
        scLeadingConstraint.isActive = true
        scTrailingConstraint.isActive = true


        
        let zbBottomConstraint = zoomButton.bottomAnchor.constraint(equalTo: bottomLayoutGuide.bottomAnchor, constant: -100.0)
        let zbTrailingConstraint = zoomButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor)

        zbBottomConstraint.isActive = true
        zbTrailingConstraint.isActive = true

//         self.view.addConstraint(NSLayoutConstraint(item: zoomButton,
//                                                    attribute: NSLayoutAttribute.leading,
//                                                   relatedBy: NSLayoutRelation.equal,
//                                                    toItem: self.view,
//                                                    attribute: NSLayoutAttribute.leading,
//                                                    multiplier: 1.0,
//                                                    constant: 0.0))
        
//        self.view.addConstraint(NSLayoutConstraint(item: zoomButton,
//                                                   attribute: NSLayoutAttribute.trailing,
//                                                   relatedBy: NSLayoutRelation.equal,
//                                                   toItem: self,
//                                                   attribute: NSLayoutAttribute.trailing,
//                                                   multiplier: 1.0,
//                                                   constant: 0.0))
//
//        self.view.addConstraint(NSLayoutConstraint(item: zoomButton,
 //                                                  attribute: NSLayoutAttribute.bottom,
//                                                   relatedBy: NSLayoutRelation.equal,
//                                                   toItem: self.view,
//                                                   attribute: NSLayoutAttribute.bottom,
//                                                   multiplier: 1.0,
//                                                   constant: 0.0))
        
        
        if CLLocationManager.authorizationStatus() == .notDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            print("Good")
            mapView.showsUserLocation = true
        }
    }
    
    func mapTypeChanged (_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex{
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
}
