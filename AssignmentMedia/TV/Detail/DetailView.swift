//
//  DetailView.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/1/24.
//

import UIKit

class DetailView: BaseView {
    let backdropImageView = UIImageView()
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = ColorStyle.backgroundColor
        view.register(MainInfoTableViewCell.self, forCellReuseIdentifier: MainInfoTableViewCell.identifier)
        view.register(SubInfoTableViewCell.self, forCellReuseIdentifier: SubInfoTableViewCell.identifier)
        view.register(BasicTableViewCell.self, forCellReuseIdentifier: BasicTableViewCell.identifier)
        return view
    }()
    
    override func configureHierarchy() {
        addSubview(backdropImageView)
        addSubview(tableView)
    }
    
    override func configureConstraints() {
        backdropImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(backdropImageView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
