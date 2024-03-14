//
//  TableViewController.swift
//  YWHMovie
//
//  Created by Wells on 2024/3/14.
//

import Foundation
import UIKit
class TableViewController: ViewController, UIScrollViewDelegate {
    lazy var tableView: TableView = {
        let view = TableView(frame: CGRect(), style: .plain)
        view.emptyDataSetSource = self
        view.emptyDataSetDelegate = self
        view.rx.setDelegate(self).disposed(by: rx.disposeBag)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView, let textLabel = view.textLabel {
            textLabel.font = UIFont.systemFont(ofSize: 15)
            textLabel.theme.textColor = themeService.attribute { $0.text }
            view.contentView.theme.backgroundColor = themeService.attribute { $0.primaryDark }
        }
    }
}
