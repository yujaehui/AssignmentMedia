//
//  DetailView.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/1/24.
//

import UIKit

final class DetailView: BaseView {
    let backdropImageView = UIImageView()
    let playButton: UIButton = {
        let view = UIButton()
        view.configuration = .playStyle()
        return view
    }()
    let dismissButton: UIButton = {
        let view = UIButton()
        view.configuration = .dismissStyle()
        return view
    }()
    let xButton: UIButton = {
        let view = UIButton()
        view.configuration = .xStyle()
        return view
    }()
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
        addSubview(playButton)
        addSubview(dismissButton)
        addSubview(xButton)
        addSubview(tableView)
    }
    
    override func configureConstraints() {
        backdropImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        playButton.snp.makeConstraints { make in
            make.center.equalTo(backdropImageView)
        }
        
        dismissButton.snp.makeConstraints { make in
            make.top.leading.equalTo(backdropImageView).inset(8)
            make.size.equalTo(40)
        }
        
        xButton.snp.makeConstraints { make in
            make.top.trailing.equalTo(backdropImageView).inset(8)
            make.size.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(backdropImageView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
