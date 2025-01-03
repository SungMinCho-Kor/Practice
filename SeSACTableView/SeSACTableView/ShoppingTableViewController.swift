//
//  ShoppingTableViewController.swift
//  SeSACTableView
//
//  Created by 조성민 on 1/3/25.
//

import UIKit

struct ShoppingCellContent {
    let title: String
    var check: Bool
    var favorite: Bool
}

class ShoppingTableViewController: UITableViewController {
    
    @IBOutlet var headerContainerView: UIView!
    @IBOutlet var shoppingTextField: UITextField!
    @IBOutlet var addButton: UIButton!
    var cellContents: [ShoppingCellContent] = [
        ShoppingCellContent(
            title: "그립톡 구매하기",
            check: true,
            favorite: true
        ),
        ShoppingCellContent(
            title: "사이다 구매",
            check: false,
            favorite: false
        ),
        ShoppingCellContent(
            title: "아이패드 케이스 최저가 알아보기",
            check: false,
            favorite: true
        ),
        ShoppingCellContent(
            title: "양말",
            check: false,
            favorite: true
        )
    ] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 50
        
        headerContainerViewDesign()
        shoppingTextFieldDesign()
        addButtonDesign()
    }
    
    func headerContainerViewDesign() {
        headerContainerView.backgroundColor = .darkGray
        headerContainerView.layer.cornerRadius = 10
    }
    
    func shoppingTextFieldDesign() {
        shoppingTextField.placeholder = "무엇을 구매하실 건가요?"
        shoppingTextField.borderStyle = .none
    }
    
    func addButtonDesign() {
        addButton.setTitle("추가", for: .normal)
        addButton.setTitleColor(.label, for: .normal)
        addButton.layer.cornerRadius = 6
        addButton.backgroundColor = .lightGray
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellContents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCell", for: indexPath)
        cell.imageView?.image = UIImage(systemName: cellContents[indexPath.row].check ? "checkmark.square.fill" : "checkmark.square")
        cell.imageView?.tintColor = .label
        cell.textLabel?.text = cellContents[indexPath.row].title
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellContents[indexPath.row].check.toggle()
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        guard let text = shoppingTextField.text, text.isEmpty == false else {
            print("no text in textField")
            return
        }
        cellContents.insert(
            ShoppingCellContent(
                title: text,
                check: false,
                favorite: false
            ),
            at: 0
        )
        shoppingTextField.text = ""
    }
    
}
