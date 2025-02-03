//
//  MainViewController.swift
//  SeventhWeek
//
//  Created by 조성민 on 2/3/25.
//

import UIKit
import CoreLocation
import MapKit
import SnapKit

final class MainViewController: UIViewController {
    
    // 1. 위치 매니저 생성: 위치에 관련된 대부분을 담당
    private let locationManager = CLLocationManager()
    private let mapView = MKMapView()
    private let locationButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        // 3. 위치 delegate 프로토콜 연결
        locationManager.delegate = self
        
        checkDeviceLocation()
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(300)
        }
        
        view.backgroundColor = .white
        locationButton.backgroundColor = .red
        view.addSubview(locationButton)
        locationButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
        locationButton.addTarget(self, action: #selector(locationButtonClicked), for: .touchUpInside)
    }
    
    @objc private func locationButtonClicked() {
        print(#function)
        checkDeviceLocation()
    }
    // Alert: 위치 서비스 -> 허용 Alert
    private func checkDeviceLocation() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                // info.plist와 일치해야 함
                self.locationManager.requestWhenInUseAuthorization()
                
                // 현재 사용자 위치 권한 상태
                // if 허용된 상태 -> 권한 띄울 필요 X
                // if 거부한 상태 -> 아이폰 설정으로 이동
                // if notDetermined -> 권한 띄워주기
                print(self.locationManager.authorizationStatus)
                
                // 만약 UI 관련 작업이 필요하면 다시 DispatchQueue.main으로 설정
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

// 2. 위치 delegate 프로토콜 선언
extension MainViewController: CLLocationManagerDelegate {

    // 사용자의 위치를 성공적으로 가져온 경우
    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        print(#function)
        print(locations.last?.coordinate)
        dump(locations)
        guard let center = locations.last?.coordinate else {
            return
        }
        setRegionAndAnnotation(center: center)
        
        // start를 했다면 더이상 위치를 받아오지 않아도 되는 시점에 stop 해주기
//        locationManager.stopUpdatingLocation()
    }
    
    // 사용자의 위치를 가지고 오지 못 함
    // ex. 사용자가 허용하지 않음, 자녀 보호 기능 등...
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(#function)
        
    }
    
    // 사용자의 권한 상태가 변경됨 or locationManager 인스턴스가 생성될 때 호출
    // ex. 허용했었는데 시스템에서 허용 안 함으로 변경한 경우
    // iOS14+
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkCurrentLocation()
    }
    
    // 사용자의 권한 상태가 변경됨
    // ex. 허용했었는데 시스템에서 허용 안 함으로 변경한 경우
    // iOS14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print(#function)
        
    }
}
