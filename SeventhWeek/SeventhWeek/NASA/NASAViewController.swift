//
//  NASAViewController.swift
//  SeventhWeek
//
//  Created by 조성민 on 2/11/25.
//

import UIKit

enum Nasa: String, CaseIterable {
    
    static let baseURL = "https://apod.nasa.gov/apod/image/"
    
    case one = "2308/sombrero_spitzer_3000.jpg"
    case two = "2212/NGC1365-CDK24-CDK17.jpg"
    case three = "2307/M64Hubble.jpg"
    case four = "2306/BeyondEarth_Unknown_3000.jpg"
    case five = "2307/NGC6559_Block_1311.jpg"
    case six = "2304/OlympusMons_MarsExpress_6000.jpg"
    case seven = "2305/pia23122c-16.jpg"
    case eight = "2308/SunMonster_Wenz_960.jpg"
    case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
    
    static var photo: URL {
        return URL(string: Nasa.baseURL + Nasa.allCases.randomElement()!.rawValue)!
    }
}

final class NASAViewController: UIViewController {
    
    private let requestButton = UIButton()
    private let progressLabel = UILabel()
    private let nasaImageView = UIImageView()
    
    // 총 데이터 양
    var total: Double = 0
    //현재 진행중?
    private var buffer: Data? {
        didSet {
            print("Buffer", buffer)
            let result = Double(buffer?.count ?? 0) / total
            progressLabel.text = "\(result * 100) / 100"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        
        buffer = Data()
    }
    
    private func configureHierarchy() {
        view.addSubview(requestButton)
        view.addSubview(progressLabel)
        view.addSubview(nasaImageView)
    }
    
    private func configureLayout() {
        requestButton.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(50)
        }
        
        progressLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(requestButton.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        nasaImageView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(progressLabel.snp.bottom).offset(20)
        }
    }
    
    private func configureView() {
        view.backgroundColor = .white
        requestButton.backgroundColor = .blue
        progressLabel.backgroundColor = .white
        progressLabel.text = "100% 중 35.5% 완료"
        nasaImageView.backgroundColor = .systemBrown
        requestButton.addTarget(self, action: #selector(requestButtonClicked), for: .touchUpInside)
    }
    
    @objc private func requestButtonClicked() {
        print(#function)
        callRequest()
    }
    
    private func callRequest() {
        let request = URLRequest(
            url: Nasa.photo,
            timeoutInterval: 5
        )
        let configuration = URLSession(
            configuration: .default,
            delegate: self,
            delegateQueue: .main
        )
        configuration.dataTask(with: request).resume()
    }
}

extension NASAViewController: URLSessionDataDelegate {
    func urlSession(
        _ session: URLSession,
        dataTask: URLSessionDataTask,
        didReceive response: URLResponse
    ) async -> URLSession.ResponseDisposition {
        print("=1=", response)
        
        if let response = response as? HTTPURLResponse,
           (200..<300).contains(response.statusCode) {
            
            guard let contentLength = response.value(forHTTPHeaderField: "Content-Length"),
                  let length = Double(contentLength) else {
                return .cancel
            }
            total = length
            buffer = Data()
            return .allow
        }
        
        return .cancel
    }
    func urlSession(
        _ session: URLSession,
        dataTask: URLSessionDataTask,
        didReceive data: Data
    ) {
        print("=2=", data)
        buffer?.append(data)
    }
    func urlSession(
        _ session: URLSession,
        task: URLSessionTask,
        didCompleteWithError error: (any Error)?
    ) {
        if let error {
            progressLabel.text = "문제가 발생했다"
        } else {
            guard let data = buffer else {
                return
            }
            nasaImageView.image = UIImage(data: data)
            print(buffer)
//            buffer = nil
            print("=3=")
        }
    }
}
