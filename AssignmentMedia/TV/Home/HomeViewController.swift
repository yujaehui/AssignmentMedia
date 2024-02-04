//
//  HomeViewController.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/30/24.
//

import UIKit
import SnapKit
import Kingfisher

enum HomeSectionType: Int, CaseIterable {
    case main
    case basic
}

enum BasicRowType: Int, CaseIterable {
    case top
    case trending
    case popular
    
    var category: String {
        switch self {
        case .top:
            return "TOP 20"
        case .trending:
            return "이번주 뜨는 콘텐츠"
        case .popular:
            return "인기 콘텐츠"
        }
    }
}

class HomeViewController: BaseViewController {
    
    let tvView = HomeView()
    
    override func loadView() {
        self.view = tvView
    }
    
    var mainList: [Result] = []
    var list: [[Result]] = [[], [], []]
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        tvView.tableView.dataSource = self
        tvView.tableView.delegate = self
        
        let group = DispatchGroup()
        
        group.enter()
        TVAPIManager.shared.request(type: TVModel.self, api: .airingToday) { main in
            self.mainList = main.results
            group.leave()
        }
        
        group.enter()
        TVAPIManager.shared.request(type: TVModel.self, api: .top) { top in
            self.list[BasicRowType.top.rawValue] = top.results
            group.leave()
        }
        
        group.enter()
        TVAPIManager.shared.request(type: TVModel.self, api: .trending) { trending in
            self.list[BasicRowType.trending.rawValue] = trending.results
            group.leave()
        }
        
        group.enter()
        TVAPIManager.shared.request(type: TVModel.self, api: .popular) { popular in
            self.list[BasicRowType.popular.rawValue] = popular.results
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tvView.tableView.reloadData()
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return HomeSectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch HomeSectionType.allCases[section] {
        case .main: return 1
        case .basic: return list.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch HomeSectionType.allCases[indexPath.section] {
        case .main:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
            cell.mainList = mainList
            cell.collectionView.reloadData()
            return cell
        default:
            switch BasicRowType.allCases[indexPath.row] {
            case .top:
                let cell = tableView.dequeueReusableCell(withIdentifier: TopTableViewCell.identifier, for: indexPath) as! TopTableViewCell
                cell.list = list
                cell.categoryLabel.text = BasicRowType.allCases[indexPath.row].category
                cell.collectionView.tag = indexPath.row
                cell.collectionView.reloadData()
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: BasicTableViewCell.identifier, for: indexPath) as! BasicTableViewCell
                cell.type = .home
                cell.list = list
                cell.categoryLabel.text = BasicRowType.allCases[indexPath.row].category
                cell.collectionView.tag = indexPath.row
                cell.collectionView.reloadData()
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch HomeSectionType.allCases[indexPath.section] {
        case .main: return UIScreen.main.bounds.width*5/4
        case .basic: return 210
        }
    }
}
