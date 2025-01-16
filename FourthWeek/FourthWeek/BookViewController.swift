//
//  BookViewController.swift
//  FourthWeek
//
//  Created by 조성민 on 1/13/25.
//

import UIKit
import SnapKit

class BookViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        view.backgroundColor = .white
        NetworkManager.shared.randomUser { name in
            print(name)
        }
    }
    override func loadView() {
        view = BookView()
    }
    
}

