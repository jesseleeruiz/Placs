//
//  ViewController.swift
//  Placs
//
//  Created by Jesse Ruiz on 8/31/20.
//  Copyright © 2020 Jesse Ruiz. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet var mapView: MKMapView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK: - Methods
    func focus(on city: City) {
        mapView.centerCoordinate = city.coordinates
    }
}

