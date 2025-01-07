//
//  GrayViewController.swift
//  SesacSecondWeek
//
//  Created by 조성민 on 1/7/25.
//

import UIKit

class GrayViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    var contents: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = contents
    }
    
    @IBAction func popButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dismissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}
