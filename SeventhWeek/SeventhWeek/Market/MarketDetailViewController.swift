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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBrown
        viewModel.outputNavigationTitle.bind { marketTitle in
            self.navigationItem.title = marketTitle
        } 
        viewModel.inputViewDidLoadTrigger.value = ()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
