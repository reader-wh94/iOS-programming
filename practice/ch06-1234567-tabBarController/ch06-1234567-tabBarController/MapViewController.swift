//
//  MapViewController.swift
//  ch06-1234567-tabBarController
//
//  Created by Jae Moon Lee on 2021/01/31.
//  Copyright © 2021 Jae Moon Lee. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("MapViewController.viewDidLoad")
    }


    
}
extension MapViewController{
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex{
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
extension MapViewController{
    override func viewWillAppear(_ animated: Bool) {
        print("MapViewController.viewWillAppear")
        
        let tabBarController = parent as! UITabBarController
        let cityViewController = tabBarController.viewControllers![0] as! CityViewController
        let (city, longitute, latitute) = cityViewController.getCurrentLonLat()
        
        updateMap(title: city, longitute: longitute, lattitute: latitute)
    }
}

extension MapViewController{
    func updateMap(title: String, longitute: Double?, lattitute: Double?){
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        var center = mapView.centerCoordinate
        if let lon = longitute, let lat = lattitute{
            center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = title
        mapView.addAnnotation(annotation)
    }
}
