//
//  WeatherViewController.swift
//  SeSACSevenWeek
//
//  Created by Jack on 2/3/25.
//

import UIKit
import CoreLocation
import SnapKit
import MapKit

final class WeatherViewController: UIViewController {
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    
    private let weatherInfoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16)
        label.textColor = .black
        label.text = "날씨 정보를 불러오는 중..."
        return label
    }()
    
    private let currentLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "location.fill"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .systemBlue
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4
        return button
    }()
    
    private let refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .systemBlue
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        setupLocationManager()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        view.backgroundColor = .white
        
        [
            mapView,
            weatherInfoLabel,
            currentLocationButton,
            refreshButton
        ].forEach {
            view.addSubview($0)
        }
    }
    
    private func setupConstraints() {
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.snp.height).multipliedBy(0.5)
        }
        
        weatherInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(mapView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        currentLocationButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.width.height.equalTo(50)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.width.height.equalTo(50)
        }
    }
    
    private func setupActions() {
        currentLocationButton.addTarget(
            self,
            action: #selector(
                currentLocationButtonTapped
            ),
            for: .touchUpInside
        )
        refreshButton.addTarget(
            self,
            action: #selector(refreshButtonTapped),
            for: .touchUpInside
        )
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
    }

    // MARK: - Actions
    @objc private func currentLocationButtonTapped() {
        checkDeviceLocation()
    }
    
    @objc private func refreshButtonTapped() {
        // 날씨 새로고침 구현
    }
    
    // Alert: 위치 서비스 -> 허용 Alert
    private func checkDeviceLocation() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async {
                    self.checkCurrentLocation()
                }
            } else {
                print("위치 서비스가 꺼져 있어서 위치 권한 요청을 할 수 없습니다.")
            }
        }
    }
    
    private func checkCurrentLocation() {
        let status = locationManager.authorizationStatus
        switch status {
        case .notDetermined:
            print("이 권한에서만 권한 문구 띄울 수 있음")
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            print("설정으로 이동하는 Alert 띄우기")
        case .authorizedWhenInUse:
            print("정상 로직 실행")
            locationManager.startUpdatingLocation()
        default:
            print("오류 발생")
        }
    }
    
    private func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(
            center: center,
            latitudinalMeters: 500,
            longitudinalMeters: 500
        )
        mapView.setRegion(
            region,
            animated: true
        )
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        print(#function)
        guard let center = locations.last?.coordinate else {
            return
        }
        setRegionAndAnnotation(center: center)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: any Error
    ) {
        print(#function)
        dump(error)
    }
    
    // locationManager 인스턴스 생성시 1회 호출
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeviceLocation()
    }
}
