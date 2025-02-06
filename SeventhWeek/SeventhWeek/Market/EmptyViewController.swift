//
//  EmptyViewController.swift
//  SeventhWeek
//
//  Created by 조성민 on 2/6/25.
//

import UIKit

final class EmptyViewModel {
    init() {
        print("EmptyViewModel init")
    }
    
    deinit {
        print("EmptyViewModel deinit")
    }
}

final class EmptyViewController: UIViewController {
    
    private let viewModel = EmptyViewModel()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        print("EmptyViewController init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("EmptyViewController viewDidLoad!!")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("EmptyViewController viewDidDisappear!!")
    }
    
    deinit {
        print("EmptyViewController deinit!!")
    }
}
