//
//  ViewController.swift
//  Weather
//
//  Created by 조성민 on 2/3/25.
//

import UIKit
import MapKit
import CoreLocation
import SnapKit

final class ViewController: UIViewController {
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private let currentLocationButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureViews()
        configureCoreLocation()
    }
    
    private func configureHierarchy() {
        [
            mapView,
            currentLocationButton
        ].forEach(view.addSubview)
    }
    
    private func configureLayout() {
        mapView.snp.makeConstraints { make in
        }
        
        currentLocationButton.snp.makeConstraints { make in
            
        }
    }
    
    private func configureViews() {
        view.backgroundColor = .white
    }
    
    private func configureCoreLocation() {
//        locationManager.delegate = self
    }
}
