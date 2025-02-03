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
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        
        return mapView
    }()
    
    private var centerAnnotation: MKPointAnnotation?
    
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
    
    private let locationSettingAlert: UIAlertController = {
        let alert = UIAlertController(
            title: "권한 에러",
            message: "위치 권한이 없습니다.\n위치 권한 수정을 위해 설정으로 이동하시겠습니까?",
            preferredStyle: .alert
        )
        let ok = UIAlertAction(
            title: "이동",
            style: .default
        ) { action in
            guard let settingURL = URL(string: UIApplication.openSettingsURLString) else { return }
            
            if UIApplication.shared.canOpenURL(settingURL) {
                UIApplication.shared.open(settingURL)
            }
        }
        alert.addAction(ok)
        let cancel = UIAlertAction(
            title: "취소",
            style: .cancel
        )
        alert.addAction(cancel)
        
        return alert
    }()
    
    private let privacyLocationSettingAlert: UIAlertController = {
        let alert = UIAlertController(
            title: "권한 에러",
            message: "위치 권한이 없습니다.\n위치 권한 수정을 위해 [설정 > 개인정보 보호 및 보안 > 위치 서비스 > 위치 서비스]를 수정해주세요.",
            preferredStyle: .alert
        )
        let ok = UIAlertAction(
            title: "확인",
            style: .default
        )
        alert.addAction(ok)
        
        return alert
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
    
    private func checkDeviceLocation() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async {
                    self.checkCurrentLocation()
                }
            } else {
                DispatchQueue.main.async {
                    self.setRegionAndAnnotation(
                        center: CLLocationCoordinate2D(
                            latitude: 37.65440756152861,
                            longitude: 127.04974613082048
                        )
                    )
                    self.present(
                        self.privacyLocationSettingAlert,
                        animated: true
                    )
                }
            }
        }
    }
    
    private func checkCurrentLocation() {
        let status = locationManager.authorizationStatus
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied:
            setRegionAndAnnotation(
                center: CLLocationCoordinate2D(
                    latitude: 37.654508171933124,
                    longitude: 127.05149421331994
                )
            )
            present(
                locationSettingAlert,
                animated: true
            )
        case .authorizedWhenInUse:
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
        if let centerAnnotation {
            centerAnnotation.coordinate = center
        } else {
            centerAnnotation = MKPointAnnotation()
            centerAnnotation?.coordinate = center
            mapView.addAnnotation(centerAnnotation!)
        }
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
        checkDeviceLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeviceLocation()
    }
}
