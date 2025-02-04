//
//  PhotoViewController.swift
//  Weather
//
//  Created by 조성민 on 2/4/25.
//

import UIKit
import PhotosUI

protocol PhotoViewControllerDelegate: AnyObject {
    func imageSelected(image: UIImage)
}

final class PhotoViewController: UIViewController {
    private let addPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "photo.badge.plus"), for: .normal)
        button.backgroundColor = .white
        button.tintColor = .systemBlue
        button.layer.cornerRadius = 25
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.2
        button.layer.shadowRadius = 4
        
        return button
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCollectionViewLayout()
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            PhotoCollectionViewCell.self,
            forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier
        )
        return collectionView
    }()
    
    private var photos: [UIImage] = []
    
    weak var delegate: PhotoViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        collectionView.backgroundColor = .white
        
        [
            addPhotoButton,
            collectionView
        ].forEach(view.addSubview)
    }
    
    private func setupConstraints() {
        addPhotoButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.size.equalTo(50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(addPhotoButton.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setupActions() {
        addPhotoButton.addTarget(
            self,
            action: #selector(addPhotoButtonTapped),
            for: .touchUpInside
        )
    }
    
    private func createCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: 10,
            bottom: 0,
            right: 10
        )
        
        return layout
    }
    
    @objc private func addPhotoButtonTapped() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .any(of: [.images])
        configuration.selectionLimit = 30
        let phPickerViewController = PHPickerViewController(configuration: configuration)
        phPickerViewController.delegate = self
        
        present(
            phPickerViewController,
            animated: true
        )
    }
}

extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return photos.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCollectionViewCell.identifier,
            for: indexPath
        ) as? PhotoCollectionViewCell else {
            print(#function, "PhotoCollectionViewCell Wrong")
            return UICollectionViewCell()
        }
        cell.configure(image: photos[indexPath.row])
        
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        delegate?.imageSelected(image: photos[indexPath.row])
        dismiss(animated: true)
    }
}

extension PhotoViewController: PHPickerViewControllerDelegate {
    func picker(
        _ picker: PHPickerViewController,
        didFinishPicking results: [PHPickerResult]
    ) {
        let imageItems = results.compactMap {
            $0.itemProvider.canLoadObject(ofClass: UIImage.self) ? $0.itemProvider : nil
        }
        
        let dispatchGroup = DispatchGroup()
        for imageItem in imageItems {
            dispatchGroup.enter()
            
            imageItem.loadObject(ofClass: UIImage.self) { [weak self] image, _ in
                if let image = image as? UIImage {
                    self?.photos.append(image)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.collectionView.reloadData()
        }
        dismiss(animated: true)
    }
}

extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = collectionView.bounds.width
        
        return CGSize(
            width: (width - 10 * 5) / 4.0,
            height: (width - 10 * 5) / 4.0
        )
    }
}
