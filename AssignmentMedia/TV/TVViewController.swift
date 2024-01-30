//
//  TVViewController.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/30/24.
//

import UIKit
import SnapKit
import Kingfisher

class TVViewController: UIViewController {
    
    let tableView = UITableView()
    
    var descriptionList = ["이번주 뜨는 콘텐츠", "TOP 20", "인기 콘텐츠"]
    var list: [[Result]] = [[], [], []]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        configureHierarchy()
        configureView()
        configureConstraints()
        
        TVAPIManager.shared.fetchTV(url: "https://api.themoviedb.org/3/trending/tv/week?language=ko-KR") { result in
            self.list[0] = result
            self.tableView.reloadData()
        }
        TVAPIManager.shared.fetchTV(url: "https://api.themoviedb.org/3/tv/top_rated?language=ko-KR") { result in
            self.list[1] = result
            self.tableView.reloadData()
        }
        TVAPIManager.shared.fetchTV(url: "https://api.themoviedb.org/3/tv/popular?language=ko=KR") { result in
            self.list[2] = result
            self.tableView.reloadData()
        }
    }
    
    func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    func configureView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TVTableViewCell.self, forCellReuseIdentifier: "TVTableViewCell")
        tableView.backgroundColor = .black
    }
    
    func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension TVViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVTableViewCell", for: indexPath) as! TVTableViewCell
        cell.titleLabel.text = descriptionList[indexPath.row]
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: "TVCollectionViewCell")
        cell.collectionView.tag = indexPath.row
        cell.collectionView.reloadData()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

extension TVViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVCollectionViewCell", for: indexPath) as! TVCollectionViewCell
        let row = list[collectionView.tag][indexPath.row]
        if let poster = row.poster_path {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(poster)")
            cell.posterImageView.kf.setImage(with: url)
        } else {
            let url = URL(string: "https://lh3.googleusercontent.com/proxy/4qYlpVBIvCD9r_JD8iEEoo-FJE3ecW8wdrDaqCxilzZsoCKSyf5_lXOG8stFWGQp7_Wji7q-2kzwXEXjD4Lx_T53iUZ2HWH03tk")
            cell.posterImageView.kf.setImage(with: url)
        }
        return cell
    }
}
