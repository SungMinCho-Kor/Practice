//
//  CityViewController.swift
//  Travel
//
//  Created by 조성민 on 1/7/25.
//

import UIKit

final class CityViewController: UIViewController {
    @IBOutlet var emptyAnnounceLabel: UILabel!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var categorySegmentedControl: UISegmentedControl!
    @IBOutlet var cityCollectionView: UICollectionView!
    
    private let cityInfo = CityInfo()
    private var allCityInfo: [City] {
        cityInfo.city.filter({
            if let textFieldText = searchBar.searchTextField.text?
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .lowercased()
                .replacingOccurrences(
                    of: " ",
                    with: ""
                ), !textFieldText.isEmpty {
                return $0.city_english_name.lowercased().contains(textFieldText) ||
                $0.city_name.lowercased().contains(textFieldText) ||
                $0.city_explain.lowercased().contains(textFieldText)
            } else {
                return true
            }
        })
    }
    private var internalCityInfo: [City] {
        cityInfo.city.filter(
            {
                if let textFieldText = searchBar.searchTextField.text?
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .lowercased()
                    .replacingOccurrences(
                        of: " ",
                        with: ""
                    )
                    , !textFieldText.isEmpty {
                    return (
                        $0.city_english_name.lowercased().contains(textFieldText) ||
                        $0.city_name.lowercased().contains(textFieldText) ||
                        $0.city_explain.lowercased().contains(textFieldText)
                    ) && $0.domestic_travel
                } else {
                    return $0.domestic_travel
                }
            })
    }
    private var domesticCityInfo: [City] {
        cityInfo.city.filter(
            {
                if let textFieldText = searchBar.searchTextField.text?
                    .trimmingCharacters(in: .whitespacesAndNewlines)
                    .lowercased().replacingOccurrences(
                        of: " ",
                        with: ""
                    ),
                   !textFieldText.isEmpty {
                    return (
                        $0.city_english_name.lowercased().contains(textFieldText) ||
                        $0.city_name.lowercased().contains(textFieldText) ||
                        $0.city_explain.lowercased().contains(textFieldText)
                    ) && !$0.domestic_travel
                } else {
                    return !$0.domestic_travel
                }
            })
    }
    private var cellCount: Int {
        if categorySegmentedControl.selectedSegmentIndex == 0 {
            return allCityInfo.count
        } else if categorySegmentedControl.selectedSegmentIndex == 1 {
            return internalCityInfo.count
        } else if categorySegmentedControl.selectedSegmentIndex == 2 {
            return domesticCityInfo.count
        } else {
            print("wrong categorySegmentedControl.selectedSegmentIndex", #function)
            return 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarDesign()
        categorySegmentedControlDesign()
        cityCollectionViewDesign()
        emptyAnnounceLabelDesign()
    }
    
    private func searchBarDesign() {
        searchBar.placeholder = "검색할 도시를 입력해주세요"
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.addTarget(
            self,
            action: #selector(searchBarChanged),
            for: .editingChanged
        )
        searchBar.searchTextField.addTarget(
            self,
            action: #selector(searchBarReturnTapped),
            for: .editingDidEndOnExit
        )
    }
    
    private func categorySegmentedControlDesign() {
        categorySegmentedControl.setTitle(
            "모두",
            forSegmentAt: 0
        )
        categorySegmentedControl.setTitle(
            "국내",
            forSegmentAt: 1
        )
        categorySegmentedControl.setTitle(
            "해외",
            forSegmentAt: 2
        )
        categorySegmentedControl.addTarget(
            self,
            action: #selector(categorySegmentedControlChanged),
            for: .valueChanged
        )
    }
    
    private func cityCollectionViewDesign() {
        cityCollectionView.delegate = self
        cityCollectionView.dataSource = self
        cityCollectionView.register(
            UINib(
                nibName: CityCollectionViewCell.identifier,
                bundle: nil
            ),
            forCellWithReuseIdentifier: CityCollectionViewCell.identifier
        )
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let width = (view.frame.width - (24.0 * 3.0)) / 2.0
        layout.itemSize = CGSize(width: width, height: width * 1.5)
        layout.sectionInset = UIEdgeInsets(
            top: 16,
            left: 24,
            bottom: 16,
            right: 24
        )
        layout.minimumInteritemSpacing = 24
        cityCollectionView.collectionViewLayout = layout
    }
    
    private func emptyAnnounceLabelDesign() {
        emptyAnnounceLabel.text = "도시가 없습니다\n다른 도시를 검색해보세요"
        emptyAnnounceLabel.font = .boldSystemFont(ofSize: 28)
        emptyAnnounceLabel.textAlignment = .center
        emptyAnnounceLabel.textColor = .systemGray4
        emptyAnnounceLabel.numberOfLines = 0
        emptyAnnounceLabel.isHidden = true
    }
    
    @objc private func categorySegmentedControlChanged(_ sender: UISegmentedControl) {
        view.endEditing(true)
        cityCollectionView.reloadData()
        if cellCount > 0 {
            cityCollectionView.scrollToItem(
                at: IndexPath(item: -1, section: 0),
                at: .top,
                animated: false
            )
        }
    }
    
    @objc private func searchBarChanged(_ sender: UITextField) {
        cityCollectionView.reloadData()
        if cellCount > 0 {
            cityCollectionView.scrollToItem(
                at: IndexPath(item: -1, section: 0),
                at: .top,
                animated: false
            )
        }
    }
    
    @objc private func searchBarReturnTapped(_ sender: UITextField) {
        cityCollectionView.reloadData()
        if cellCount > 0 {
            cityCollectionView.scrollToItem(
                at: IndexPath(item: -1, section: 0),
                at: .top,
                animated: false
            )
        }
    }
}

extension CityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if cellCount == 0 {
            emptyAnnounceLabel.isHidden = false
        } else {
            emptyAnnounceLabel.isHidden = true
        }
        return cellCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell =
                collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.identifier, for: indexPath) as? CityCollectionViewCell  else {
            print("CityCollectionViewCell dequeueReusableCell 실패")
            return UICollectionViewCell()
        }
        if categorySegmentedControl.selectedSegmentIndex == 0 {
            cell.configure(
                allCityInfo[indexPath.row],
                highlightString: searchBar.searchTextField.text
            )
        } else if categorySegmentedControl.selectedSegmentIndex == 1 {
            cell.configure(
                internalCityInfo[indexPath.row],
                highlightString: searchBar.searchTextField.text
            )
        } else if categorySegmentedControl.selectedSegmentIndex == 2 {
            cell.configure(
                domesticCityInfo[indexPath.row],
                highlightString: searchBar.searchTextField.text
            )
        } else {
            print("wrong categorySegmentedControl.selectedSegmentIndex", #function)
        }
        
        return cell
    }
}
