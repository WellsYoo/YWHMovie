//
//  HomeTabBarController.swift
//  YWHMovie
//
//  Created by Wells on 2024/3/14.
//

import Localize_Swift
import RAMAnimatedTabBarController
import RxSwift
import UIKit

enum HomeTabBarItem: Int {
    case news

    private func controller(with viewModel: ViewModel, navigator: Navigator) -> UIViewController {
        switch self {
//        case .search:
//            let vc = SearchViewController(viewModel: viewModel, navigator: navigator)
//            return NavigationController(rootViewController: vc)
        case .news:
//            let vc = EventsViewController(viewModel: viewModel, navigator: navigator)
            let vc = UIViewController()
            return NavigationController(rootViewController: vc)
//        case .notifications:
//            let vc = NotificationsViewController(viewModel: viewModel, navigator: navigator)
//            return NavigationController(rootViewController: vc)
//        case .settings:
//            let vc = SettingsViewController(viewModel: viewModel, navigator: navigator)
//            return NavigationController(rootViewController: vc)
//        case .login:
//            let vc = LoginViewController(viewModel: viewModel, navigator: navigator)
//            return NavigationController(rootViewController: vc)
        }
    }


    var image: UIImage? {
        switch self {
//        case .search: return R.image.icon_tabbar_search()
        case .news: return R.image.icon_tabbar_news()
//        case .notifications: return R.image.icon_tabbar_activity()
//        case .settings: return R.image.icon_tabbar_settings()
//        case .login: return R.image.icon_tabbar_login()
        }
    }

    var title: String {
        switch self {
//        case .search: return R.string.localizable.homeTabBarSearchTitle.key.localized()
        case .news: return R.string.localizable.homeTabBarEventsTitle.key.localized()
//        case .notifications: return R.string.localizable.homeTabBarNotificationsTitle.key.localized()
//        case .settings: return R.string.localizable.homeTabBarSettingsTitle.key.localized()
//        case .login: return R.string.localizable.homeTabBarLoginTitle.key.localized()
        }
    }

    var animation: RAMItemAnimation {
        var animation: RAMItemAnimation
        switch self {
//        case .search: animation = RAMFlipLeftTransitionItemAnimations()
        case .news: animation = RAMBounceAnimation()
//        case .notifications: animation = RAMBounceAnimation()
//        case .settings: animation = RAMRightRotationAnimation()
//        case .login: animation = RAMBounceAnimation()
        }
        animation.theme.iconSelectedColor = themeService.attribute { $0.secondary }
        animation.theme.textSelectedColor = themeService.attribute { $0.secondary }
        return animation
    }

    func getController(with viewModel: ViewModel, navigator: Navigator) -> UIViewController {
        let vc = controller(with: viewModel, navigator: navigator)
        let item = RAMAnimatedTabBarItem(title: title, image: image, tag: rawValue)
        item.animation = animation
        item.theme.iconColor = themeService.attribute { $0.text }
        item.theme.textColor = themeService.attribute { $0.text }
        vc.tabBarItem = item
        return vc
    }
}

class HomeTabBarController: RAMAnimatedTabBarController, Navigatable {
    var navigator: Navigator!
    var viewModel: HomeTabBarViewModel?
    init(navigator: Navigator!, viewModel: HomeTabBarViewModel? = nil) {
        self.navigator = navigator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func makeUI() {
//        NotificationCenter.default
//            .rx.notification(NSNotification.Name(LCLLanguageChangeNotification))
//            .subscribe { [weak self] (event) in
//                self?.animatedItems.forEach({ (item) in
//                    item.title = HomeTabBarItem(rawValue: item.tag)?.title
//                })
//                self?.setViewControllers(self?.viewControllers, animated: false)
//                self?.setSelectIndex(from: 0, to: self?.selectedIndex ?? 0)
//            }.disposed(by: rx.disposeBag)

        tabBar.theme.barTintColor = themeService.attribute { $0.primaryDark }

        themeService.typeStream.delay(DispatchTimeInterval.milliseconds(200), scheduler: MainScheduler.instance)
            .subscribe(onNext: { theme in
                switch theme {
                case .light(let color), .dark(let color):
                    self.changeSelectedColor(color.color, iconSelectedColor: color.color)
                }
            }).disposed(by: rx.disposeBag)
    }

    func bindViewModel() {
        guard let viewModel = viewModel else { return }

        let input = HomeTabBarViewModel.Input()
        let output = viewModel.transform(input: input)

        output.tabBarItems.delay(.milliseconds(50)).drive(onNext: { [weak self] tabBarItems in
            if let strongSelf = self {
                let controllers = tabBarItems.map { $0.getController(with: viewModel, navigator: strongSelf.navigator) }
                strongSelf.setViewControllers(controllers, animated: false)
            }
        }).disposed(by: rx.disposeBag)

//        output.openWhatsNew.drive(onNext: { [weak self] block in
//            if Configs.Network.useStaging == false {
//                self?.navigator.show(segue: .whatsNew(block: block), sender: self, transition: .modal)
//            }
//        }).disposed(by: rx.disposeBag)
    }
}
