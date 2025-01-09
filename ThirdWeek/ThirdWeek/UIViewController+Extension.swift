//
//  UIViewController+Extension.swift
//  ThirdWeek
//
//  Created by 조성민 on 1/9/25.
//

import UIKit

extension UIViewController {
    func collectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // default : .vertical
        layout.itemSize = CGSize(  // .init 사용 X 속도 차이가 있음
            width: UIScreen.main.bounds.width,
//            width: view.window?.windowScene?.screen.bounds.width ?? 100,
            height: 160
        )
        layout.sectionInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0
        )
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        return layout
    }
}

extension UICollectionViewFlowLayout {
    public convenience init(design: Bool = false) {
        self.init()
        if design {
            scrollDirection = .horizontal // default : .vertical
            itemSize = CGSize(  // .init 사용 X 속도 차이가 있음
                width: UIScreen.main.bounds.width,
                //            width: view.window?.windowScene?.screen.bounds.width ?? 100,
                height: UIScreen.main.bounds.width
            )
            sectionInset = UIEdgeInsets(
                top: 0,
                left: 0,
                bottom: 0,
                right: 0
            )
            minimumInteritemSpacing = 0
            minimumLineSpacing = 0
        }
    }
}

class CustomCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
}
