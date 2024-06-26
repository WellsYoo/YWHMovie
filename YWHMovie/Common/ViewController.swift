//
//  ViewController.swift
//  YWHMovie
//
//  Created by Wells on 2024/3/14.
//

import DZNEmptyDataSet
import Foundation
import SVProgressHUD
import UIKit
import RxRelay
import RxSwift

class ViewController: UIViewController, Navigatable {
    var viewModel: ViewModel?
    var navigator: Navigator!
    init(viewModel: ViewModel? = nil, navigator: Navigator!) {
        self.viewModel = viewModel
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        super.init(nibName: nil, bundle: nil)
    }

    let isLoading = BehaviorRelay(value: false)
    let error = PublishSubject<ApiError>()
    var canOpenFlex = true
    
    var emptyDataSetTitle = R.string.localizable.commonNoResults.key.localized()

    override func viewDidLoad() {
        super.viewDidLoad()

        makeUI()
        bindViewModel()
        
        
        // One finger swipe gesture for opening Flex
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleOneFingerSwipe(swipeRecognizer:)))
        swipeGesture.numberOfTouchesRequired = 1
        self.view.addGestureRecognizer(swipeGesture)

        // Two finger swipe gesture for opening Flex and Hero debug
        let twoSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleTwoFingerSwipe(swipeRecognizer:)))
        twoSwipeGesture.numberOfTouchesRequired = 2
        self.view.addGestureRecognizer(twoSwipeGesture)
    }

    func makeUI() {
        //    hero.isEnabled = true
        //    navigationItem.backBarButtonItem = backBarButton
        //
        //    bannerView.load(GADRequest())
        //    LibsManager.shared.bannersEnabled.asDriver().drive(onNext: { [weak self] (enabled) in
        //        guard let self = self else { return }
        //        self.bannerView.removeFromSuperview()
        //        self.stackView.removeArrangedSubview(self.bannerView)
        //        if enabled {
        //            self.stackView.addArrangedSubview(self.bannerView)
        //        }
        //    }).disposed(by: rx.disposeBag)
        //
        //    motionShakeEvent.subscribe(onNext: { () in
        //        let theme = themeService.type.toggled()
        //        themeService.switch(theme)
        //    }).disposed(by: rx.disposeBag)
        //
            view.theme.backgroundColor = themeService.attribute { $0.primaryDark }
//            backBarButton.theme.tintColor = themeService.attribute { $0.secondary }
//            closeBarButton.theme.tintColor = themeService.attribute { $0.secondary }
//            theme.emptyDataSetImageTintColorBinder = themeService.attribute { $0.text }

        updateUI()
    }

    func bindViewModel() {
        viewModel?.loading.asObservable().bind(to: isLoading).disposed(by: rx.disposeBag)
        viewModel?.parsedError.asObservable().bind(to: error).disposed(by: rx.disposeBag)

//        languageChanged.subscribe(onNext: { [weak self] () in
//            self?.emptyDataSetTitle = R.string.localizable.commonNoResults.key.localized()
//        }).disposed(by: rx.disposeBag)
//
        isLoading.subscribe(onNext: { isLoading in
            UIApplication.shared.isNetworkActivityIndicatorVisible = isLoading
        }).disposed(by: rx.disposeBag)
    }

    func updateUI() {}

    func startAnimating() {
        SVProgressHUD.show()
    }

    func stopAnimating() {
        SVProgressHUD.dismiss()
    }
}

extension ViewController {

    var inset: CGFloat {
        return Configs.BaseDimensions.inset
    }

    func emptyView(withHeight height: CGFloat) -> View {
        let view = View()
        view.snp.makeConstraints { (make) in
            make.height.equalTo(height)
        }
        return view
    }

    @objc func handleOneFingerSwipe(swipeRecognizer: UISwipeGestureRecognizer) {
        if swipeRecognizer.state == .recognized, canOpenFlex {
            LibsManager.shared.showFlex()
        }
    }

    @objc func handleTwoFingerSwipe(swipeRecognizer: UISwipeGestureRecognizer) {
        if swipeRecognizer.state == .recognized {
            LibsManager.shared.showFlex()
//            HeroDebugPlugin.isEnabled = !HeroDebugPlugin.isEnabled
        }
    }
}


extension ViewController: DZNEmptyDataSetSource {
//    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
//        return NSAttributedString(string: emptyDataSetTitle)
//    }
//
//    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
//        return NSAttributedString(string: emptyDataSetDescription)
//    }
//
//    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
//        return emptyDataSetImage
//    }
//
//    func imageTintColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
//        return emptyDataSetImageTintColor.value
//    }
//
//    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
//        return .clear
//    }
//
//    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
//        return -60
//    }
}

extension ViewController: DZNEmptyDataSetDelegate {
//    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
//        return !isLoading.value
//    }
//
//    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
//        return true
//    }
//
//    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
//        emptyDataSetButtonTap.onNext(())
//    }
}
