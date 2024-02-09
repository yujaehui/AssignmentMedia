//
//  HomeView.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/1/24.
//

import UIKit

final class HomeView: BaseView {
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = ColorStyle.backgroundColor
        view.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        view.register(BasicTableViewCell.self, forCellReuseIdentifier: BasicTableViewCell.identifier)
        view.register(TopTableViewCell.self, forCellReuseIdentifier: TopTableViewCell.identifier)
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
