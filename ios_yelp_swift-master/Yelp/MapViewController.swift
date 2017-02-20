//
//  MapViewController.swift
//  Yelp
//
//  Created by YangSzu Kai on 2017/2/20.
//  Copyright © 2017年 Timothy Lee. All rights reserved.
//

import UIKit
import  MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var myMap: MKMapView!
    
    
    var locationManager: CLLocationManager!
    var longtitude: Double?
    var latitude: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // if latitude == nil{
         //   let centerLocation = CLLocation(latitude: 40.424, longitude: -86.9212)
           // goToLoaction(location: centerLocation)
        //}else{
            let restruantLocaiton = CLLocation(latitude: latitude, longitude: longtitude!)
            goToLoaction(location: restruantLocaiton)
       // }
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
        
        //let centerLocation = CLLocation(latitude: 37.7833, longitude: -122.4167)
        //goToLoaction(location: centerLocation)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func goToLoaction(location: CLLocation)  {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        myMap.setRegion(region, animated: false)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse{
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpanMake(0.1,0.1)
            let region = MKCoordinateRegionMake(location.coordinate, span)
            myMap.setRegion(region, animated: false)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
