//
//  KakaoBookSearchViewController.swift
//  SeSACFourthWeek
//
//  Created by Jack on 1/14/25.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class KakaoBookSearchViewController: UIViewController {
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    var list = Book(documents: [])
    private var searchText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureSearchBar()
        configureTableView()
        
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
    
    func configureSearchBar() {
        view.addSubview(searchBar)
        
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        searchBar.delegate = self
    }
    
    func configureTableView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
        
        tableView.rowHeight = 120
        tableView.delegate = self
        tableView.dataSource = self
        tableView.keyboardDismissMode = .onDrag
        tableView.register(KakaoBookSearchTableViewCell.self, forCellReuseIdentifier: KakaoBookSearchTableViewCell.id)

    }
    


}

extension KakaoBookSearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines), text != searchText else {
            return
        }
        searchText = text
        callRequest(searchText: searchText)
    }
    
    private func callRequest(searchText: String) {
        let url = "https://dapi.kakao.com/v3/search/book?query=\(searchText)"
        let headers: HTTPHeaders = [
            "Authorization": "KakaoAK \(APIKey.kakao)"
        ]
        
        AF.request(url, method: .get, headers: headers)
//            .responseString { value in
//                dump(value)
//            }
            .validate()
            .responseDecodable(of: Book.self) { response in
                print(response.response?.statusCode)
                switch response.result {
                case .success(let value):
                    self.list = value
                    self.tableView.reloadData()
                case .failure(let error):
                    dump(error)
                }
            }
    }
    
}


extension KakaoBookSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: KakaoBookSearchTableViewCell.id, for: indexPath) as? KakaoBookSearchTableViewCell else { return UITableViewCell() }
        let data = list.documents[indexPath.row]
        
        cell.titleLabel.text = "타이틀 레이블: \(data.title)"
        cell.overviewLabel.text = "줄거리 레이블: \(data.contents)"
        cell.thumbnailImageView.kf.setImage(with: URL(string: data.thumbnail))
        
        return cell
    }
    
}

