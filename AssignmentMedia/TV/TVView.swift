//
//  TVView.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/1/24.
//

import UIKit

class TVView: BaseView {
    let tableView: UITableView = {
        let view = UITableView()
        view.register(TVMainTableViewCell.self, forCellReuseIdentifier: TVMainTableViewCell.identifier)
        view.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
        view.register(TopTableViewCell.self, forCellReuseIdentifier: TopTableViewCell.identifier)
        view.backgroundColor = ColorStyle.backgroundColor
        return view
    }()

    override func configureHierarchy() {
        addSubview(tableView)
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
