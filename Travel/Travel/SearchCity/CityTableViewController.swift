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
    private var allCityInfo: [City] {
        cityInfo.city.filter({
            if let textFieldText = searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased().replacingOccurrences(of: " ", with: ""), !textFieldText.isEmpty {
                return $0.city_english_name.lowercased().contains(textFieldText) ||
                $0.city_name.lowercased().contains(textFieldText) ||
                $0.city_explain.lowercased().contains(textFieldText)
            } else {
                return true
            }
        })
    }
    private var internalCityInfo: [City] {
        cityInfo.city.filter({
            if let textFieldText = searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased().replacingOccurrences(of: " ", with: ""), !textFieldText.isEmpty {
                return ($0.city_english_name.lowercased().contains(textFieldText) ||
                $0.city_name.lowercased().contains(textFieldText) ||
                $0.city_explain.lowercased().contains(textFieldText)) && $0.domestic_travel
            } else {
                return $0.domestic_travel
            }
        })
    }
    private var domesticCityInfo: [City] {
        cityInfo.city.filter({
            if let textFieldText = searchTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased().replacingOccurrences(of: " ", with: ""), !textFieldText.isEmpty {
                return ($0.city_english_name.lowercased().contains(textFieldText) ||
                $0.city_name.lowercased().contains(textFieldText) ||
                $0.city_explain.lowercased().contains(textFieldText)) && !$0.domestic_travel
            } else {
                return !$0.domestic_travel
            }
        })
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
        searchTextField.placeholder = "도시를 검색해보세요"
        searchTextField.addTarget(
            self,
            action: #selector(searchTextFieldChanged),
            for: .editingChanged
        )
        searchTextField.addTarget(
            self,
            action: #selector(searchTextFieldReturnTapped),
            for: .editingDidEndOnExit
        )
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
            return allCityInfo.count
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
            cell.configure(allCityInfo[indexPath.row])
        } else if categorySegmentedControl.selectedSegmentIndex == 1 {
            cell.configure(internalCityInfo[indexPath.row])
        } else if categorySegmentedControl.selectedSegmentIndex == 2 {
            cell.configure(domesticCityInfo[indexPath.row])
        } else {
            print("wrong categorySegmentedControl.selectedSegmentIndex", #function)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
    @objc private func categorySegmentedControlChanged(_ sender: UISegmentedControl) {
        view.endEditing(true)
        tableView.reloadData()
    }
    
    @objc private func searchTextFieldChanged(_ sender: UITextField) {
        tableView.reloadData()
    }
    
    @objc private func searchTextFieldReturnTapped(_ sender: UITextField) {
        tableView.reloadData()
    }
}
