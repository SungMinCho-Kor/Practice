//
//  BoxOfficeViewModel.swift
//  SeSACSevenWeek_2
//
//  Created by Jack on 2/6/25.
//

import Foundation
import Alamofire

class BoxOfficeViewModel {

    private(set) var input: Input
    private(set) var output: Output
    
    struct Input {
        let inputSelectedDate = Observable(Date())
        let inputSearchButtonTapped : Observable<Void?> = Observable(nil)
    }
    
    struct Output {
        let outputBoxOffice: Observable<[Movie]> = Observable([])
        let outputDateString: Observable<String> = Observable("")
    }
    
    private var query: String = ""
    
    init() {
        input = Input()
        output = Output()
        
        print("BoxOfficeViewModel Init")
        callBoxOffice2(date: "20230101")
    }
    
    deinit {
        print("BoxOfficeViewModel Deinit")
    }
    
    private func transform() {
        input.inputSelectedDate.bind { date in
            self.convertDate(date: date)
        }
        input.inputSearchButtonTapped.lazyBind { _ in
            self.callBoxOffice(date: self.query)
        }
    }
    
    private func convertDate(date: Date) {
        let format = DateFormatter()
        format.dateFormat = "yy년 MM월 dd일"
        let string = format.string(from: date)
        output.outputDateString.value = string
        
        format.dateFormat = "yyyyMMdd"
        query = format.string(from: date)
    }
    
    private func callBoxOffice(date: String) {
        let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=6f880d27184cbe92e28d4970282cec8e&targetDt=\(date)"
        
        AF.request(url).responseDecodable(of: BoxOfficeResult.self) { response in
            switch response.result {
            case .success(let success):
                self.output.outputBoxOffice.value = success.boxOfficeResult.dailyBoxOfficeList
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func callNasaAPI() {
        
    }
    
    private func callBoxOffice2(date: String) {
        let urlString = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=6f880d27184cbe92e28d4970282cec8e&targetDt=\(date)"
        guard let url = URL(string: urlString) else {
            return
        }
        let urlRequest = URLRequest(url: url)
        
        print("=== ", Thread.isMainThread)
        let session = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, response,error in
            print("=== ", Thread.isMainThread)
            if let error {
                print("error!")
                return
            }
            guard let response = response as? HTTPURLResponse,
                  (200...299).contains(response.statusCode) else {
                print("상태코드 ERROR")
                return
            }
            
            if let data,
               let movieData = try? JSONDecoder().decode(
                BoxOfficeResult.self,
                from: data
               ) {
                self?.output.outputBoxOffice.value = movieData.boxOfficeResult.dailyBoxOfficeList
            } else {
                
            }
        }
        
        session.resume()
    }

}
