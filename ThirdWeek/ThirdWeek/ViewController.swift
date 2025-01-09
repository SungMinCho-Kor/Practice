//
//  ViewController.swift
//  ThirdWeek
//
//  Created by 조성민 on 1/8/25.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet var userTextField: UITextField!
    @IBOutlet var secondTextField: UITextField!
    @IBOutlet var mapView: MKMapView!
    
    let pickerView = UIPickerView()
    
    var list = ["가", "나", "다"]
    var array = ["1", "2", "3", "4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        userTextField.delegate = self
        
        mapView.delegate = self
        
        secondTextField.tintColor = .clear
        secondTextField.inputView = pickerView
        
        configureMapView()
    }
    
    private func configureMapView() {
        let center = CLLocationCoordinate2D(
            latitude: 37.65370,
            longitude: 127.04740
        )
        mapView.region = MKCoordinateRegion(
            center: center,
            latitudinalMeters: 100,
            longitudinalMeters: 100
        )
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "Hello"
        mapView.addAnnotation(annotation)
    }
}

//MARK: 피커뷰 설정
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(
        _ pickerView: UIPickerView,
        numberOfRowsInComponent component: Int
    ) -> Int {
        return component == 0 ? list.count : array.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        titleForRow row: Int,
        forComponent component: Int
    ) -> String? {
        return component == 0 ? list[row] : array[row]
    }
    
    func pickerView(
        _ pickerView: UIPickerView,
        didSelectRow row: Int,
        inComponent component: Int
    ) {
        if component == 0 {
            userTextField.text = list[row]
        } else {
            secondTextField.text = array[row]
        }
    }
}

//MARK: 텍스트 필드 설정
extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(#function, textField.text)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function, textField.text)
//        view.endEditing(true)
        secondTextField.becomeFirstResponder()
        return true
    }
}
