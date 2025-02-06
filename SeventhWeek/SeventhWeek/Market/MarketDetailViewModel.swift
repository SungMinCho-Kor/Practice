//
//  MarketDetailViewModel.swift
//  SeventhWeek
//
//  Created by 조성민 on 2/6/25.
//

final class MarketDetailViewModel {
    private let market: Market
    
    let inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    
    let outputNavigationTitle: Observable<String?> = Observable(nil)
    
    init(market: Market) {
        self.market = market
        inputViewDidLoadTrigger.lazyBind { [weak self] _ in
            self?.outputNavigationTitle.value = market.korean_name
        }
        print("MarketDetailViewModel Init")
    }
    
    deinit {
        print("MarketDetailViewModel Deinit")
    }
}
