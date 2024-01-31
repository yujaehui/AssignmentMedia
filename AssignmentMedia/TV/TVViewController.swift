//
//  TVViewController.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/30/24.
//

import UIKit
import SnapKit
import Kingfisher

class TVViewController: BaseViewController {
    
    let tableView = UITableView()
    
    var mainList = TVModel(results: [])
    var descriptionList = ["이번주 뜨는 콘텐츠", "TOP 20", "인기 콘텐츠"]
    var list: [[Result]] = [[], [], []]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let group = DispatchGroup()
        
        group.enter()
        TVAPIManager.shared.fetchTVList(url: "tv/airing_today?language=ko-KR") { main in
            self.mainList = main
            group.leave()
        }
        
        group.enter()
        TVAPIManager.shared.fetchTV(url: "trending/tv/week?language=ko-KR") { result in
            self.list[0] = result
            group.leave()
        }
        
        group.enter()
        TVAPIManager.shared.fetchTV(url: "tv/top_rated?language=ko-KR") { result in
            self.list[1] = result
            group.leave()
        }
        
        group.enter()
        TVAPIManager.shared.fetchTV(url: "tv/popular?language=ko=KR") { result in
            self.list[2] = result
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
        tableView.register(TVMainTableViewCell.self, forCellReuseIdentifier: TVMainTableViewCell.identifier)
        tableView.backgroundColor = ColorStyle.backgroundColor
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
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
            cell.collectionView.isPagingEnabled = true
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
            cell.collectionView.tag = 100
            cell.collectionView.reloadData()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TVTableViewCell.identifier, for: indexPath) as! TVTableViewCell
            cell.promotionLabel.text = descriptionList[indexPath.row]
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
            cell.collectionView.tag = indexPath.row
            cell.collectionView.reloadData()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UIScreen.main.bounds.width*4/3
        } else {
            return 200
        }
    }
}

extension TVViewController: UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 100 {
            let count = min(5, mainList.results.count)
            return count
        } else {
            return list[collectionView.tag].count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as! TVCollectionViewCell
        if collectionView.tag == 100 {
            let row = mainList.results[indexPath.row]
            if let poster = row.poster_path {
                let url = URL(string: TVAPIManager.shared.imageeBaseURL + poster)
                cell.posterImageView.kf.setImage(with: url)
            } else {
                let url = URL(string: TVAPIManager.shared.errorImageURL)
                cell.posterImageView.kf.setImage(with: url)
            }
            return cell
        } else {
            let row = list[collectionView.tag][indexPath.row]
            if let poster = row.poster_path {
                let url = URL(string: TVAPIManager.shared.imageeBaseURL + poster)
                cell.posterImageView.kf.setImage(with: url)
            } else {
                let url = URL(string: TVAPIManager.shared.errorImageURL)
                cell.posterImageView.kf.setImage(with: url)
            }
            return cell
        }
    }
}
