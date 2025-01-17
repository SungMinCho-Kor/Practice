//
//  ImageZoomViewController.swift
//  FourthWeek
//
//  Created by 조성민 on 1/17/25.
//

import UIKit

class ImageZoomViewController: UIViewController {
    
    private lazy var scrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.backgroundColor = .green
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.maximumZoomScale = 5
        scrollView.minimumZoomScale = 1
        scrollView.delegate = self
        
        return scrollView
    }()
    
    private let imageView = {
        let view = UIImageView(frame: .zero)
        view.backgroundColor = .yellow
        view.image = UIImage(systemName: "star")
        view.contentMode = .scaleAspectFit
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        scrollView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.size.equalTo(200)
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(scrollView)
        }
        
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(doubleTapGesture)
        )
        tap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(tap)
    }

    @objc private func doubleTapGesture() {
        if scrollView.zoomScale == 1 {
            scrollView.setZoomScale(3, animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }
}

extension ImageZoomViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}
