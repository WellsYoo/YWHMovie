//
//  HOmeTabBarViewModel.swift
//  YWHMovie
//
//  Created by Wells on 2024/3/14.
//

import Foundation
import RxCocoa
import RxSwift

class HomeTabBarViewModel: ViewModel, ViewModelType {
    struct Input {}

    struct Output {
        let tabBarItems: Driver<[HomeTabBarItem]>
    }

    override init(provider: YWHMovieAPI) {
        super.init(provider: provider)
    }

    func transform(input: Input) -> Output {
        let items: [HomeTabBarItem] = [.news]
        let tabBarItems = Observable.of(items).asDriver(onErrorJustReturn: [])

        return Output(tabBarItems: tabBarItems
        )
    }
}
