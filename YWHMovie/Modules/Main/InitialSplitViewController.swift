//
//  InitialSplitViewController.swift
//  YWHMovie
//
//  Created by Wells on 2024/3/14.
//

import UIKit

class InitialSplitViewController: TableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func makeUI() {
        super.makeUI()
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = false
        }

        emptyDataSetTitle = R.string.localizable.initialNoResults.key.localized()
        tableView.headRefreshControl = nil
        tableView.footRefreshControl = nil
    }
}
