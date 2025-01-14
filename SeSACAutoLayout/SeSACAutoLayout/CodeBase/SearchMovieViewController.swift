//
//  SearchMovieViewController.swift
//  SeSACAutoLayout
//
//  Created by 조성민 on 1/13/25.
//

import UIKit
import SnapKit
import Alamofire

enum DateStyle: String {
    case searchMovieDate = "yyyyMMdd"
    case movieCell = "yyyy-MM-dd"
}

extension DateFormatter {
    func setDateStyle(_ style: DateStyle) {
        self.dateFormat = style.rawValue
    }
}

final class SearchMovieViewController: UIViewController {
    
    static let dateFormatter = DateFormatter()
    private var movieList: [Movie] = []
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(resource: .profileBackground)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let backgroundDimView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.6
        return view
    }()
    private let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "yyyyMMdd 형식의 날짜를 입력하세요"
        textField.backgroundColor = .clear
        textField.borderStyle = .none
        return textField
    }()
    private let searchTextFieldBottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(
            self,
            action: #selector(searchButtonTapped),
            for: .touchUpInside
        )
        return button
    }()
    private lazy var movieTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.rowHeight = 48
        tableView.register(
            SearchMovieTableViewCell.self,
            forCellReuseIdentifier: SearchMovieTableViewCell.identifier
        )
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    private lazy var wrongSearchAlert: UIAlertController = {
        let alert = UIAlertController(
            title: nil,
            message: "형식에 맞는 검색어를 입력하세요",
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: "확인",
                style: .default
            )
        )
        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMoview(date: Date().addingTimeInterval(-86400))
        setUI()
        setLayout()
    }
}

//MARK: Design
extension SearchMovieViewController {
    private func setUI() {
        [
            backgroundImageView,
            backgroundDimView,
            searchTextField,
            searchTextFieldBottomView,
            searchButton,
            movieTableView
        ].forEach(view.addSubview)
    }
    
    private func setLayout() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        backgroundDimView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(32)
            make.width.equalTo(300)
            make.height.equalTo(40)
        }
        
        searchTextFieldBottomView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(searchTextField)
            make.top.equalTo(searchTextField.snp.bottom).offset(4)
            make.height.equalTo(2)
        }
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.top)
            make.leading.equalTo(searchTextField.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(46)
        }
        
        movieTableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextFieldBottomView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.keyboardLayoutGuide.snp.top)
        }
    }
}

//MARK: Objective-C
@objc
extension SearchMovieViewController {
    private func searchButtonTapped(_ sender: UIButton) {
        Self.dateFormatter.setDateStyle(.searchMovieDate)
        guard let text = searchTextField.text, !text.isEmpty,
              let searchDate = Self.dateFormatter.date(from: text) else {
            searchTextField.text = ""
            print("searchTextField.text DateFormat wrong")
            present(wrongSearchAlert, animated: true)
            return
        }
        fetchMoview(date: searchDate)
        view.endEditing(true)
    }
}

//MARK: TableView
extension SearchMovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchMovieTableViewCell.identifier,
            for: indexPath
        ) as? SearchMovieTableViewCell else {
            print(#function, "SearchMovieTableViewCell wrong")
            return UITableViewCell()
        }
        cell.configure(movieList[indexPath.row])
        return cell
    }
}

//MARK: Data
extension SearchMovieViewController {
    private func fetchMoview(date: Date) {
        Self.dateFormatter.setDateStyle(.searchMovieDate)
        let dateString = Self.dateFormatter.string(from: date)
        let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=6f880d27184cbe92e28d4970282cec8e&targetDt=\(dateString)"
        AF.request(url, method: .get)
            .responseString { response in
                print(response)
            }
            .responseDecodable(of: MovieResponse.self) { response in
                switch response.result {
                case .success(let value):
                    self.movieList = value.boxOfficeResult.dailyBoxOfficeList
                    self.movieTableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
