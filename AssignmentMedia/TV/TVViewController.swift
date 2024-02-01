//
//  TVViewController.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/30/24.
//

import UIKit
import SnapKit
import Kingfisher

enum cellType: Int, CaseIterable {
    case top
    case trending
    case popular
}

class TVViewController: BaseViewController {
    
    let tvView = TVView()
    
    var mainList: [Result] = []
    var list: [[Result]] = [[], [], []]
    
    let categoryList = ["TOP 20", "이번주 뜨는 콘텐츠", "인기 콘텐츠"]
    
    override func loadView() {
        self.view = tvView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvView.tableView.dataSource = self
        tvView.tableView.delegate = self
        
        let group = DispatchGroup()
        
        group.enter()
        TVAPIManager.shared.fetchTV(api: .airingToday) { main in
            self.mainList = main
            group.leave()
        }
        
        group.enter()
        TVAPIManager.shared.fetchTV(api: .top) { top in
            self.list[cellType.top.rawValue] = top
            group.leave()
        }
        
        group.enter()
        TVAPIManager.shared.fetchTV(api: .trending) { trending in
            self.list[cellType.trending.rawValue] = trending
            group.leave()
        }
        
        group.enter()
        TVAPIManager.shared.fetchTV(api: .popular) { popular in
            self.list[cellType.popular.rawValue] = popular
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tvView.tableView.reloadData()
        }
    }
}

extension TVViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return list.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TVMainTableViewCell.identifier, for: indexPath) as! TVMainTableViewCell
            cell.mainList = mainList
            cell.collectionView.reloadData()
            return cell
        } else {
            if indexPath.row == cellType.top.rawValue {
                let cell = tableView.dequeueReusableCell(withIdentifier: TopTableViewCell.identifier, for: indexPath) as! TopTableViewCell
                cell.list = list
                cell.categoryLabel.text = categoryList[indexPath.row]
                cell.collectionView.tag = indexPath.row
                cell.collectionView.reloadData()
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: TVTableViewCell.identifier, for: indexPath) as! TVTableViewCell
                cell.list = list
                cell.categoryLabel.text = categoryList[indexPath.row]
                cell.collectionView.tag = indexPath.row
                cell.collectionView.reloadData()
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UIScreen.main.bounds.width*5/4
        } else {
            return 210
        }
    }
}
