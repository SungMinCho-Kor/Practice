//
//  ShoppingTableViewController.swift
//  Travel
//
//  Created by 조성민 on 1/5/25.
//

import UIKit

// shoppingTextField에 너무 많은 텍스트를 입력하면 addButton이 옆으로 밀려납니다.
// 자동으로 늘어나는 레이아웃의 최대치를 잡는 방법을 모르겠어요 ㅠㅠ
final class ShoppingTableViewController: UITableViewController {
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var shoppingTextField: UITextField!
    @IBOutlet private var addButton: UIButton!
    
    private var shoppingInfo = ShoppingInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerViewDesign()
        shoppingTextFieldDesign()
        addButtonDesign()
        tableViewDesign()
    }
    
    private func tableViewDesign() {
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
    
    private func addButtonDesign() {
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
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ShoppingTableViewCell.identifier,
            for: indexPath
        ) as? ShoppingTableViewCell else {
            print("ShoppingTableViewCell dequeueReusableCell 실패")
            return UITableViewCell()
        }
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
    
    override func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(
            style: .normal,
            title: "Delete"
        ) { [weak self] (_, _, success: @escaping (Bool) -> Void) in
            // UIContextualAction 객체와 ShoppingTableViewController의 약한 참조가 필요한 경우인지 정확하게 판단이 잘 되지 않습니다... 확인할 수 있는 방법이 궁금합니다.
            self?.shoppingInfo.shoppingList.remove(at: indexPath.row)
            self?.tableView.reloadData()
            success(true)
        }
        delete.backgroundColor = .white
        delete.image = UIImage(systemName: "trash")?.withTintColor(
            .systemRed,
            renderingMode: .alwaysOriginal
        )
        return UISwipeActionsConfiguration(actions: [delete])
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
        tableView.reloadData()
        shoppingTextField.text = ""
    }
    
    @objc private func checkButtonTapped(_ sender: UIButton) {
        shoppingInfo.shoppingList[sender.tag].checked.toggle()
        tableView.reloadRows(
            at: [IndexPath(
                row: sender.tag,
                section: 0
            )],
            with: .automatic
        )
    }
    
    @objc private func favoriteButtonTapped(_ sender: UIButton) {
        shoppingInfo.shoppingList[sender.tag].favorite.toggle()
        tableView.reloadRows(
            at: [IndexPath(
                row: sender.tag,
                section: 0
            )],
            with: .automatic
        )
    }
    
    @objc private func shoppingTextFieldChanged(_ sender: UITextField) {
        addButton.isEnabled = sender.text?.isEmpty == false
    }
}
