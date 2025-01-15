//
//  ShoppingDetailViewController.swift
//  Shopping
//
//  Created by 조성민 on 1/15/25.
//

import UIKit
import SnapKit
import Alamofire

enum ShoppingDetailFilter: Int, CaseIterable {
    case accuracy
    case date
    case highPrice
    case lowPrice
    
    var buttonTitle: String {
        switch self {
        case .accuracy:
            return "정확도"
        case .date:
            return "날짜순"
        case .highPrice:
            return "가격높은순"
        case .lowPrice:
            return "가격낮은순"
        }
    }
}

final class ShoppingDetailViewController: UIViewController {
    
    private let searchText: String
    private var filterState = ShoppingDetailFilter.accuracy {
        didSet {
            let prevButton = filterButtons[oldValue.rawValue]
            let nextButton = filterButtons[filterState.rawValue]
            prevButton.configuration?.baseForegroundColor = .white
            prevButton.configuration?.baseBackgroundColor = .black
            nextButton.configuration?.baseForegroundColor = .black
            nextButton.configuration?.baseBackgroundColor = .white
        }
    }
    
    private let resultCountLabel = UILabel()
    private let filterButtonStackView = UIStackView()
    private var filterButtons: [UIButton] = []
    private lazy var shoppingCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: collectionViewLayout()
    )
    
    init(searchText: String) {
        self.searchText = searchText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureViews()
        configureNavigation()
        fetchShoppingList()
    }
}

extension ShoppingDetailViewController: ViewConfiguration {
    func configureHierarchy() {
        [
            resultCountLabel,
            filterButtonStackView,
            shoppingCollectionView
        ].forEach(view.addSubview)
        
        ShoppingDetailFilter.allCases.forEach { filter in
            var configuration = UIButton.Configuration.filled()
            configuration.title = filter.buttonTitle
            configuration.baseBackgroundColor = .black
            configuration.baseForegroundColor = .white
            configuration.titlePadding = .zero
            let button = UIButton(configuration: configuration)
            button.layer.borderWidth = 0.5
            button.layer.cornerRadius = 8
            button.layer.borderColor = UIColor.white.cgColor
            button.tag = filter.rawValue
            button.addTarget(
                self,
                action: #selector(filterButtonTapped),
                for: .touchUpInside
            )
            filterButtons.append(button)
            filterButtonStackView.addArrangedSubview(button)
        }
        filterButtons[0].configuration?.baseForegroundColor = .black
        filterButtons[0].configuration?.baseBackgroundColor = .white
    }
    
    func configureLayout() {
        resultCountLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        filterButtonStackView.snp.makeConstraints { make in
            make.top.equalTo(resultCountLabel.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).inset(16)
        }
        
        shoppingCollectionView.snp.makeConstraints { make in
            make.top.equalTo(filterButtonStackView.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureViews() {
        view.backgroundColor = .black
        
        resultCountLabel.font = .systemFont(ofSize: 12)
        resultCountLabel.textColor = .green
        
        filterButtonStackView.spacing = 1
        filterButtonStackView.distribution = .equalSpacing
    }
    
    private func configureNavigation() {
        navigationItem.title = searchText
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
              let window = sceneDelegate.window else {
            print(#function, "SceneDelegate Wrong")
            return layout
        }
        let sectionInset: CGFloat = 10
        let itemSpacing: CGFloat = 12
        let width = (window.bounds.width - sectionInset * 2 - itemSpacing) / 2
        layout.itemSize = CGSize(width: width, height: width + 90)
        layout.minimumLineSpacing = itemSpacing
        layout.minimumInteritemSpacing = itemSpacing
        layout.sectionInset = UIEdgeInsets(
            top: sectionInset,
            left: sectionInset,
            bottom: sectionInset,
            right: sectionInset
        )
        return layout
    }
}

extension ShoppingDetailViewController {
    private func fetchShoppingList() {
        print("Fetch \(filterState.buttonTitle)")
    }
    
    @objc
    private func filterButtonTapped(_ sender: UIButton) {
        let nextState = ShoppingDetailFilter.allCases[sender.tag]
        if filterState == nextState {
            return
        }
        filterState = nextState
        fetchShoppingList()
    }
}
