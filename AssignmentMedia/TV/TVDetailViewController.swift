//
//  TVDetailViewController.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/31/24.
//

import UIKit
import Kingfisher

class TVDetailViewController: BaseViewController {
    
    let backdropImageView = UIImageView()
    let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = ColorStyle.backgroundColor
        return view
    }()

    var detail = SeriesDetailsModel(backdropPath: "", posterPath: "", name: "", date: "", episodeRunTime: [], networks: [], createdBy: [], overview: "")
    var actor = AggregateCreditsModel(cast: [])
    var recommend = TVModel(results: [])
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let group = DispatchGroup()
        
        group.enter()
        TVAPIManager.shared.fetchDetail { detail in
            self.detail = detail
            group.leave()
        }
        
        group.enter()
        TVAPIManager.shared.fetchActor { actor in
            self.actor = actor
            group.leave()
        }
        
        group.enter()
        TVAPIManager.shared.fetchTVList(url: "tv/67915/recommendations?language=ko-KR") { recommend in
            self.recommend = recommend
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(self.detail.backdropPath)")
            self.backdropImageView.kf.setImage(with: url)
        }
    }
    
    override func configureHierarchy() {
        view.addSubview(backdropImageView)
        view.addSubview(tableView)
    }
    
    override func configureView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TVMainInfoTableViewCell.self, forCellReuseIdentifier: TVMainInfoTableViewCell.identifier)
        tableView.register(TVSubInfoTableViewCell.self, forCellReuseIdentifier: TVSubInfoTableViewCell.identifier)
        tableView.register(TVTableViewCell.self, forCellReuseIdentifier: TVTableViewCell.identifier)
    }
    
    override func configureConstraints() {
        backdropImageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(200)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(backdropImageView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension TVDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TVMainInfoTableViewCell.identifier, for: indexPath) as! TVMainInfoTableViewCell
            cell.configureCell(detail: detail)
            return cell
            
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TVSubInfoTableViewCell.identifier, for: indexPath) as! TVSubInfoTableViewCell
            cell.configureCell(detail: detail, actor: actor)
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TVTableViewCell.identifier, for: indexPath) as! TVTableViewCell
            cell.promotionLabel.text = "비슷한 콘텐츠"
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.collectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
            cell.collectionView.tag = 0
            cell.collectionView.reloadData()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return UITableView.automaticDimension
        case 1: return UITableView.automaticDimension
        case 2: return 220
        default: return 0
        }
    }
}

extension TVDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommend.results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as! TVCollectionViewCell
        let row = recommend.results[indexPath.row]
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
