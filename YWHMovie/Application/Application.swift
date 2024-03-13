//
//  Application.swift
//  YWHMovie
//
//  Created by Wells on 2024/3/13.
//

import Foundation
import UIKit
final class Application: NSObject {
    static let share = Application()
    var window: UIWindow?

    let navigator: Navigator

    override private init() {
        navigator = Navigator.default
        super.init()
    }

    func presentInitialScreen(in window: UIWindow?) {
        guard let window = window else { return }
        
//        self.navigator.show(segue: <#T##Navigator.Scene#>, sender: <#T##UIViewController?#>)  
    }
}
