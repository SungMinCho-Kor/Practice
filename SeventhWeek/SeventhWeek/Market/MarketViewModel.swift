//
//  MarketViewModel.swift
//  SeSACSevenWeek_2
//
//  Created by Jack on 2/6/25.
//

import Foundation
import Alamofire

final class MarketViewModel {
    
    let inputViewDidLoadTigger: Observable<Void?> = Observable(nil)
    let outputMarket = Observable(
        [
            Market(
                market: "예시",
                korean_name: "Korea",
                english_name: "English"
            )
        ]
    )
    let inputCellSelected: Observable<Int?> = Observable(nil)
    
    let outputTitle: Observable<String?> = Observable(nil)
    let outputCellSelected: Observable<Market?> = Observable(nil)
    
    init() {
        print("MarketViewModel Init")
        inputViewDidLoadTigger.lazyBind { _ in
            print("inputViewDidLoad Trigger bind")
            self.fetchUpbitMarketAPI()
        }
        inputCellSelected.lazyBind { index in
            guard let index else {
                print("index nil")
                return
            }
            self.outputCellSelected.value = self.outputMarket.value[index]
        }
    }
    
    deinit {
        print("MarketViewModel Deinit")
    }
    
    private func fetchUpbitMarketAPI() {
        let url = "https://api.upbit.com/v1/market/all"
        
        AF.request(url).responseDecodable(of: [Market].self) { response in
            switch response.result {
            case .success(let success):
                self.outputMarket.value = success
                self.outputTitle.value = success.randomElement()?.korean_name
            case .failure(let failure):
                dump(failure)
            }
        }
    }
}
