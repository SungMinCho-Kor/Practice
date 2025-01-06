//
//  ShoppingTableViewController.swift
//  Travel
//
//  Created by 조성민 on 1/5/25.
//

import UIKit

// shoppingTextField에 너무 많은 텍스트를 입력하면 addButton이 옆으로 밀려납니다.
// 자동으로 늘어나는 레이아웃의 최대치를 잡는 방법을 모르겠어요 ㅠㅠ
class ShoppingTableViewController: UITableViewController {
    @IBOutlet var containerView: UIView!
    @IBOutlet var shoppingTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    var shoppingInfo = ShoppingInfo() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerViewDesign()
        shoppingTextFieldDesign()
        addButtonDesign()
        tableView.rowHeight = 52
    }
    
    private func containerViewDesign() {
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = .systemGray5
    }
    
    private func shoppingTextFieldDesign() {
        shoppingTextField.borderStyle = .none
        shoppingTextField.placeholder = "무엇을 구매하실 건가요?"
        shoppingTextField.addTarget(
            self,
            action: #selector(shoppingTextFieldChanged),
            for: .editingChanged
        )
    }
    
    func addButtonDesign() {
        var attributedString = AttributedString("추가")
        attributedString.font = .systemFont(ofSize: 14)
        var configuration = UIButton.Configuration.filled()
        configuration.baseForegroundColor = .black
        configuration.baseBackgroundColor = .systemGray4
        configuration.attributedTitle = attributedString
        addButton.configuration = configuration
        addButton.addTarget(
            self,
            action: #selector(addButtonTapped),
            for: .touchUpInside
        )
    }
    
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return shoppingInfo.shoppingList.count
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ShoppingTableViewCell",
            for: indexPath
        ) as! ShoppingTableViewCell
        cell.configure(shoppingInfo.shoppingList[indexPath.row])
        cell.checkButton.tag = indexPath.row
        cell.favoriteButton.tag = indexPath.row
        cell.checkButton.addTarget(
            self,
            action: #selector(checkButtonTapped),
            for: .touchUpInside
        )
        cell.favoriteButton.addTarget(
            self,
            action: #selector(favoriteButtonTapped),
            for: .touchUpInside
        )
        
        return cell
    }
    
    @objc private func addButtonTapped(_ sender: UIButton) {
        guard let text = shoppingTextField.text, !text.isEmpty else {
            print("no text in shoppingTextField")
            return
        }
        shoppingInfo.shoppingList.insert(
            ShoppingListContent(
                checked: false,
                title: text,
                favorite: false
            ),
            at: 0
        )
        shoppingTextField.text = ""
    }
    
    @objc private func checkButtonTapped(_ sender: UIButton) {
        shoppingInfo.shoppingList[sender.tag].checked.toggle()
    }
    
    @objc private func favoriteButtonTapped(_ sender: UIButton) {
        shoppingInfo.shoppingList[sender.tag].favorite.toggle()
    }
    
    @objc private func shoppingTextFieldChanged(_ sender: UITextField) {
        addButton.isEnabled = sender.text?.isEmpty == false
    }
}
