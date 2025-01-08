//
//  RestaurantMapViewController.swift
//  Travel
//
//  Created by 조성민 on 1/8/25.
//

import UIKit
import MapKit
import Kingfisher

final class RestaurantMapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var mapView: MKMapView!
    private let restaurantList = RestaurantList()
    private lazy var restaurantAnnotations = restaurantList.restaurantArray.map(
        {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(
                latitude: $0.latitude,
                longitude: $0.longitude
            )
            annotation.title = $0.name
            return annotation
        })
    private var filter: RestaurantFilter = .all {
        didSet {
            updateAnnotations(
                previousFilter: oldValue,
                newFilter: filter
            )
        }
    }
    private let actionSheetController = UIAlertController(
        title: nil,
        message: nil,
        preferredStyle: .actionSheet
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationDesign()
        configureMapView()
        configureActionSheet()
    }
    
    private func navigationDesign() {
        let rightBarButtonItem = UIBarButtonItem(
            title: "Filter",
            style: .plain,
            target: self,
            action: #selector(filterButtonTapped)
        )
        rightBarButtonItem.tintColor = .gray
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func configureMapView() {
        mapView.delegate = self
        mapView.showAnnotations(restaurantAnnotations, animated: false)
    }
    
    private func configureActionSheet() {
        actionSheetController.addAction(
            UIAlertAction(
                title: "취소",
                style: .cancel
            )
        )
        RestaurantFilter.allCases.forEach { filterCase in
            actionSheetController.addAction(
                UIAlertAction(
                    title: filterCase.rawValue,
                    style: .default
                ) { _ in
                self.filter = filterCase
            })
        }
    }
    
    private func updateAnnotations(
        previousFilter: RestaurantFilter,
        newFilter: RestaurantFilter
    ) {
        if previousFilter != newFilter {
            mapView.removeAnnotations(filteredRestaurantAnnotations(previousFilter))
            mapView.showAnnotations(
                filteredRestaurantAnnotations(newFilter),
                animated: true
            )
        }
    }
    
    private func filteredRestaurantAnnotations(_ filter: RestaurantFilter) -> [MKPointAnnotation] {
        if filter == .all {
            return restaurantAnnotations
        }
        var filteredAnnotations: [MKPointAnnotation] = []
        for idx in 0..<restaurantList.restaurantArray.count {
            if restaurantList.restaurantArray[idx].category == filter.rawValue {
                filteredAnnotations.append(restaurantAnnotations[idx])
            }
        }
        return filteredAnnotations
    }
    
    @objc private func filterButtonTapped(_ sender: UIBarButtonItem) {
        present(actionSheetController, animated: true)
    }
    
    func mapView(
        _ mapView: MKMapView,
        didSelect annotation: any MKAnnotation
    ) {
        mapView.showAnnotations([annotation], animated: true)
    }
    
    // 이미지 AnnotationView 구현을 시도했으나 이미지 사이즈 조절에 실패했습니다.
//    func mapView(
//        _ mapView: MKMapView,
//        viewFor annotation: any MKAnnotation
//    ) -> MKAnnotationView? {
//        let annotationView = MKAnnotationView()
//        annotationView.annotation = annotation
//        
//        guard let annotation = annotation as? MKPointAnnotation,
//              let idx = restaurantAnnotations.firstIndex(of: annotation) else {
//            print("mil")
//            return nil
//        }
//        let restaurant = restaurantList.restaurantArray[idx]
//        guard let url = URL(string: restaurant.image) else {
//            print("url")
//            return nil
//        }
//        KingfisherManager.shared.retrieveImage(with: url) { result in
//            switch result {
//            case .success(let retrieveImage):
//                Task { @MainActor in
//                    annotationView.image = retrieveImage.image
//                }
//            case .failure(let error):
//                dump(error)
//            }
//        }
//        return annotationView
//    }
}
