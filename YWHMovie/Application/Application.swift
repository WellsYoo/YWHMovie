//
//  Application.swift
//  YWHMovie
//
//  Created by Wells on 2024/3/13.
//

import Foundation
import UIKit
final class Application: NSObject {
    static let shared = Application()
    var window: UIWindow?
    var provider: YWHMovieAPI?
    let navigator: Navigator

    override private init() {
        navigator = Navigator.default
        super.init()
        updateProvider()
    }

    func presentInitialScreen(in window: UIWindow?) {
        guard let window = window, let provider = provider else { return }
        updateProvider()
        let viewModel = HomeTabBarViewModel(provider: provider)
        navigator.show(segue: .tabs(viewModel: viewModel), sender: nil, transition: .root(in: window))
    }

    private func updateProvider() {
        let githubProvider = GithubNetworking.defaultNetworking()
//        let trendingGithubProvider = staging ? TrendingGithubNetworking.stubbingNetworking() : TrendingGithubNetworking.defaultNetworking()
//        let codetabsProvider = staging ? CodetabsNetworking.stubbingNetworking() : CodetabsNetworking.defaultNetworking()
//        let restApi = RestApi(githubProvider: githubProvider)
//        provider = restApi

//        if let token = authManager.token, Configs.Network.useStaging == false {
//            switch token.type() {
//            case .oAuth(let token), .personal(let token):
//                provider = GraphApi(restApi: restApi, token: token)
//            default: break
//            }
//        }
    }
}
