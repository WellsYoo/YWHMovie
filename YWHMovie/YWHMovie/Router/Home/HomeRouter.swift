//
//  HomeRouter.swift
//  SwiftBilibili
//
//  Created by luowen on 2020/11/18.
//  Copyright © 2020 luowen. All rights reserved.
//

import UIKit
import URLNavigator

struct HomeRouter {
    static var router: Provider<HomeRouterType>!
    static func initialize(navigator: Navigator) {
        self.router = Provider(navigator: navigator, [HomeRouterLoginPlugin()])
    }
}

extension HomeRouter {

    /// 打开
    ///
    /// - Parameters:
    ///   - url: url
    ///   - context: context
    /// - Returns: true or false
    @discardableResult
    static func open(_ url: URLConvertible,
                     completion: ((Bool) -> Void)? = .none) -> Bool {
        return router.open(url, completion: completion)
    }
    
    

    /// 获取视图控制器
    ///
    /// - Parameters:
    ///   - url: url
    ///   - context: context
    /// - Returns: 视图控制器
    static func viewController(_ url: URLConvertible) -> UIViewController? {
        return router.viewController(url)
    }
}
