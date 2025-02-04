//
//  ImagePickerViewController.swift
//  SeventhWeek
//
//  Created by 조성민 on 2/4/25.
//

import UIKit
import SnapKit
import PhotosUI

final class ImagePickerViewController: UIViewController {
    
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
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        present(
            imagePicker,
            animated: true
        )
        
        /*
         UIDocumentViewController
         UIAcitivityViewController
         UIColorPickerViewController
         UIFontPickerViewController
         ... 등.. 가능
         */
    }
}

// UIImagePickerController가 UINavigationController를 상속받기도 하고,
// NavigationBar를 사용하여 UINavigationControllerDelegate를 많이 사용한다고 함
extension ImagePickerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        print(#function)
        let image = info[UIImagePickerController.InfoKey.editedImage]
        if let result = image as? UIImage {
            photoImageView.image = result
        }
        dismiss(animated: true)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        dismiss(animated: true)
        
    }
}
