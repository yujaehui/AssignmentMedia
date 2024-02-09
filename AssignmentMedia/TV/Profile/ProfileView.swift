//
//  ProfileView.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/7/24.
//

import UIKit
import SnapKit

final class ProfileView: BaseView {
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = ColorStyle.backgroundColor
        view.rowHeight = UITableView.automaticDimension
        view.register(ProfileImageTableViewCell.self, forCellReuseIdentifier: ProfileImageTableViewCell.identifier)
        view.register(ProfileInfoTableViewCell.self, forCellReuseIdentifier: ProfileInfoTableViewCell.identifier)
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
