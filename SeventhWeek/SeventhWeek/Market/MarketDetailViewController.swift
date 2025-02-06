//
//  MarketDetailViewController.swift
//  SeventhWeek
//
//  Created by 조성민 on 2/6/25.
//

import UIKit

final class MarketDetailViewController: UIViewController {
    
    private let viewModel: MarketDetailViewModel
    
    init(viewModel: MarketDetailViewModel) {
        self.viewModel = viewModel
        super.init(
            nibName: nil,
            bundle: nil
        )
        print("MarketDetailViewController Init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        viewModel.outputNavigationTitle.bind { [weak self] marketTitle in
            self?.navigationItem.title = marketTitle
        } 
        viewModel.inputViewDidLoadTrigger.value = ()
        print("MarketDetailViewController viewDidLoad")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("MarketDetailViewController viewDidDisappear")
    }
    
    deinit {
        print("MarketDetailViewController Deinit")
    }
}
