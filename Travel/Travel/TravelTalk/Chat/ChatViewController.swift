//
//  ChatViewController.swift
//  Travel
//
//  Created by 조성민 on 1/12/25.
//

import UIKit

final class ChatViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var bottomContainerView: UIView!
    @IBOutlet private var textViewContainerView: UIView!
    @IBOutlet private var textView: UITextView!
    @IBOutlet private var chatButton: UIButton!
    
    var list: [Chat] = []
    
    private let textViewPlaceholder = "메세지를 입력하세요"
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationDesign()
        tableViewDesign()
        bottomContainerViewDesign()
        textViewContainerViewDesign()
        textViewDesign()
        chatButtonDesign()
        configureTableView()
        configureTextView()
        configureChatButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.scrollToRow(
            at: IndexPath(
                row: list.count - 1,
                section: 0
            ),
            at: .bottom,
            animated: false
        )
    }
}

//MARK: Design
extension ChatViewController {
    private func navigationDesign() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "chevron.backward"),
            style: .plain,
            target: self,
            action: #selector(dismissViewController)
        )
        navigationItem.leftBarButtonItem?.tintColor = .black
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = navigationBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
        navigationController?.navigationBar.isTranslucent = false
        
    }
    
    private func tableViewDesign() {
        tableView.separatorStyle = .none
    }
    
    private func bottomContainerViewDesign() {
        
    }
    
    private func textViewContainerViewDesign() {
        textViewContainerView.backgroundColor = .systemGray6
        textViewContainerView.layer.cornerRadius = 10
    }
    
    private func textViewDesign() {
        textView.backgroundColor = .clear
        textView.text = textViewPlaceholder
        textView.textColor = .lightGray
    }
    
    private func chatButtonDesign() {
        chatButton.setTitle(
            "",
            for: .normal
        )
        chatButton.setImage(
            UIImage(systemName: "arrow.up.circle.fill"),
            for: .normal
        )
        chatButton.tintColor = .systemPink
        chatButton.isEnabled = false
    }
}

//MARK: Configure
extension ChatViewController {
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let identifier = ChatTableViewCell.identifier
        let xib = UINib(
            nibName: identifier,
            bundle: nil
        )
        tableView.register(
            xib,
            forCellReuseIdentifier: identifier
        )
    }
    
    private func configureTextView() {
        textView.delegate = self
    }
    
    private func configureChatButton() {
        chatButton.addTarget(
            self,
            action: #selector(chatButtonTapped),
            for: .touchUpInside
        )
    }
}

//MARK: Objective-C
@objc
extension ChatViewController {
    private func chatButtonTapped(_ sender: UIButton) {
        //TODO: Chat 추가
        
        textView.text = textViewPlaceholder
        textView.textColor = .lightGray
        chatButton.isEnabled = false
        view.endEditing(true)
    }
    
    private func dismissViewController(_ sender: UIBarButtonItem) {
        view.window?.layer.add(
            CATransition().popFromRight(),
            forKey: kCATransition
        )
        dismiss(animated: false)
    }
}

//MARK: TextView
extension ChatViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        chatButton.isEnabled = textView.text != textViewPlaceholder && !textView.text.isEmpty
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView.text == textViewPlaceholder {
            textView.text = ""
            textView.textColor = .black
        }
        return true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if textView.text.isEmpty {
            textView.textColor = .lightGray
            textView.text = "메세지를 입력하세요"
        }
        return true
    }
}

//MARK: TableView
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return list.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        if list[indexPath.row].user == .user {
            // TODO: userCell
            return UITableViewCell()
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ChatTableViewCell.identifier,
                for: indexPath
            ) as? ChatTableViewCell else {
                print(#function, "ChatTableViewCell Wrong")
                return UITableViewCell()
            }
            cell.configure(list[indexPath.row])
            return cell
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return UITableView.automaticDimension
    }
}
