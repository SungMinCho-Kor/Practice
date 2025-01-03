//
//  ShowViewController.swift
//  SesacSecondWeek
//
//  Created by 조성민 on 12/31/24.
//

import UIKit

class ShowViewController: UIViewController {

    let colorList: [UIColor] = [.red, .yellow, .green, .orange, .cyan]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = colorList.randomElement()!
        print(self, #function)
        print("aa")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(self, #function)
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        print(self, #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(self, #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(self, #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(self, #function)
    }

}
