//
//  CityTableViewController.swift
//  Travel
//
//  Created by 조성민 on 1/6/25.
//

import UIKit

class CityTableViewController: UITableViewController {
    @IBOutlet private var textfieldContainerView: UIView!
    @IBOutlet private var searchTextField: UITextField!
    @IBOutlet private var categorySegmentedControl: UISegmentedControl!
    
    private let cityInfo = CityInfo()
    private var internalCityInfo: [City] {
        cityInfo.city.filter({ $0.domestic_travel })
    }
    private var domesticCityInfo: [City] {
        cityInfo.city.filter({ !$0.domestic_travel })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewDesign()
        textfieldContainerViewDesign()
        searchTextFieldDesign()
        categorySegmentedControlDesign()
    }
    
    private func tableViewDesign() {
        tableView.register(
            UINib(
                nibName: CityTableViewCell.identifier,
                bundle: nil
            ),
            forCellReuseIdentifier: CityTableViewCell.identifier
        )
        tableView.rowHeight = 160
        tableView.separatorStyle = .none
    }
    
    private func textfieldContainerViewDesign() {
        textfieldContainerView.layer.cornerRadius = 10
        textfieldContainerView.backgroundColor = .systemGray6
    }
    
    private func searchTextFieldDesign() {
        searchTextField.borderStyle = .none
    }
    
    private func categorySegmentedControlDesign() {
        categorySegmentedControl.setTitle("모두", forSegmentAt: 0)
        categorySegmentedControl.setTitle("국내", forSegmentAt: 1)
        categorySegmentedControl.setTitle("해외", forSegmentAt: 2)
        categorySegmentedControl.addTarget(
            self,
            action: #selector(categorySegmentedControlChanged),
            for: .valueChanged
        )
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        if categorySegmentedControl.selectedSegmentIndex == 0 {
            return cityInfo.city.count
        } else if categorySegmentedControl.selectedSegmentIndex == 1 {
            return internalCityInfo.count
        } else if categorySegmentedControl.selectedSegmentIndex == 2 {
            return domesticCityInfo.count
        }
        print("wrong categorySegmentedControl.selectedSegmentIndex", #function)
        
        return 0
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CityTableViewCell.identifier,
            for: indexPath
        ) as? CityTableViewCell else {
            print("CityTableViewCell dequeueReusableCell 실패")
            return UITableViewCell()
        }
        if categorySegmentedControl.selectedSegmentIndex == 0 {
            cell.configure(cityInfo.city[indexPath.row])
        } else if categorySegmentedControl.selectedSegmentIndex == 1 {
            cell.configure(internalCityInfo[indexPath.row])
        } else if categorySegmentedControl.selectedSegmentIndex == 2 {
            cell.configure(domesticCityInfo[indexPath.row])
        } else {
            print("wrong categorySegmentedControl.selectedSegmentIndex", #function)
        }
        
        return cell
    }
    
    @objc private func categorySegmentedControlChanged(_ sender: UISegmentedControl) {
        searchTextField.text = ""
        view.endEditing(true)
        tableView.reloadData()
    }
}
