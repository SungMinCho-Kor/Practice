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
    
    private var list: [Chat] {
        guard let chatList = mockChatList.first(where: { $0.chatroomId == chatRoomID })?.chatList else {
            print(#function, "ChatRoomID wrong")
            return []
        }
        return chatList
    }
    var chatRoomID: Int = -1
    
    private let textViewPlaceholder = "메세지를 입력하세요"
    override func viewDidLoad() {
        super.viewDidLoad()
        configureChatList()
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableViewScrollDown(animated: false)
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
    private func configureChatList() {
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let chatIdentifier = ChatTableViewCell.identifier
        let chatXIB = UINib(
            nibName: chatIdentifier,
            bundle: nil
        )
        let userChatIdentifier = UserChatTableViewCell.identifier
        let userChatXIB = UINib(
            nibName: userChatIdentifier,
            bundle: nil
        )
        tableView.register(
            chatXIB,
            forCellReuseIdentifier: chatIdentifier
        )
        tableView.register(
            userChatXIB,
            forCellReuseIdentifier: userChatIdentifier
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
        let todayDate = Date()
        let dateFormatter = Chat.dateFormatter
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        guard let text = textView.text else {
            print(#function, "Nil text in TextView")
            return
        }
        mockChatList.first(where: {$0.chatroomId == chatRoomID})?
            .chatList.append(
            Chat(
                user: .user,
                date: dateFormatter.string(from: todayDate),
                message: text
            )
        )
        textView.text = ""
        chatButton.isEnabled = false
        tableView.reloadData()
        tableViewScrollDown(animated: true)
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
        tableViewScrollDown()
        return true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
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
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: UserChatTableViewCell.identifier,
                for: indexPath
            ) as? UserChatTableViewCell else {
                print(#function, "UserChatTableViewCell Wrong")
                return UITableViewCell()
            }
            cell.configure(list[indexPath.row])
            return cell

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
    
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        view.endEditing(true)
    }
    
    // TODO: Keyboard event에 대한 반응으로 수정
    private func tableViewScrollDown(animated: Bool = true) {
        Task {
            try await Task.sleep(for: .milliseconds(5))
            tableView.scrollToRow(
                at: IndexPath(
                    row: list.count - 1,
                    section: 0
                ),
                at: .bottom,
                animated: animated
            )
        }
    }
}
