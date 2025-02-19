//
//  FirstViewController.swift
//  RxExample
//
//  Created by 조성민 on 2/19/25.
//

import UIKit
import RxSwift
import RxCocoa

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemRed
        view.addGestureRecognizer(
            UITapGestureRecognizer(
                target: self,
                action: #selector(tapped)
            )
        )
    }
    
    @objc private func tapped() {
        navigationController?.pushViewController(HomeworkViewController(), animated: true)
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
