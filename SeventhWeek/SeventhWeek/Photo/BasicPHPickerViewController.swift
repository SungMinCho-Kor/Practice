//
//  BasicPHPickerViewController.swift
//  SeventhWeek
//
//  Created by 조성민 on 2/4/25.
//

import UIKit
import PhotosUI

final class BasicPHPickerViewController: UIViewController {
    
    private let pickerButton = UIButton()
    private let photoImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureViews()
    }
    
    private func configureHierarchy() {
        [
            pickerButton,
            photoImageView
        ].forEach(view.addSubview)
    }
    
    private func configureLayout() {
        pickerButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(40)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(200)
        }
    }
    
    private func configureViews() {
        view.backgroundColor = .white
        pickerButton.backgroundColor = .lightGray
        pickerButton.setTitle(
            "클릭",
            for: .normal
        )
        pickerButton.setTitleColor(
            .label,
            for: .normal
        )
        pickerButton.addTarget(
            self,
            action: #selector(pickerButtonTapped),
            for: .touchUpInside
        )
        photoImageView.backgroundColor = .systemGray
        
    }
    
    @objc private func pickerButtonTapped() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 4
        let phPicker = PHPickerViewController(configuration: configuration)
        phPicker.delegate = self
        present(phPicker, animated: true)
    }
}

extension BasicPHPickerViewController: PHPickerViewControllerDelegate {
    func picker(
        _ picker: PHPickerViewController,
        didFinishPicking results: [PHPickerResult]
    ) {
        print(#function)
        if let itemProvider = results.first?.itemProvider {
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                
                // loadObject는 시간이 좀 걸릴 수 있으니 global로 돌리는구나~ 로 이해하고 ui 업데이트는 Main Thread로 돌려주자
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                    DispatchQueue.main.async {
                        self?.photoImageView.image = image as? UIImage
                    }
                }
            }
        }
        dismiss(animated: true)
    }
    
}
