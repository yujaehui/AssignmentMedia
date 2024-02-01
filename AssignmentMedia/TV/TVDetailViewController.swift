//
//  TVDetailViewController.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/31/24.
//

import UIKit
import Kingfisher

class TVDetailViewController: BaseViewController {
    
    let tvDetailView = TVDetailView()
    
    override func loadView() {
        self.view = tvDetailView
    }

    var detail = SeriesDetailsModel(backdropPath: "", posterPath: "", name: "", date: "", episodeRunTime: [], networks: [], createdBy: [], overview: "")
    var credit = AggregateCreditsModel(cast: [])
    var recommend: [Result] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvDetailView.tableView.dataSource = self
        tvDetailView.tableView.delegate = self
        
        let group = DispatchGroup()
        
        group.enter()
        TVAPIManager.shared.fetchDetail(api: .detail(id: 67915)) { detail in
            self.detail = detail
            group.leave()
        }
        
        group.enter()
        TVAPIManager.shared.fetchCredit(api: .credit(id: 67915)) { credit in
            self.credit = credit
            group.leave()
        }
        
        group.enter()
        TVAPIManager.shared.fetchTV(api: .recommend(id: 67915)) { recommend in
            self.recommend = recommend
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tvDetailView.tableView.reloadData()
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(self.detail.backdropPath)")
            self.tvDetailView.backdropImageView.kf.setImage(with: url)
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
            cell.configureCell(detail: detail, credit: credit)
            return cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TVTableViewCell.identifier, for: indexPath) as! TVTableViewCell
            cell.categoryLabel.text = "비슷한 콘텐츠"
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
        return recommend.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as! TVCollectionViewCell
        let row = recommend[indexPath.row]
        let url = URL(string: TVAPIManager.shared.imageeBaseURL + row.poster_path)
        cell.posterImageView.kf.setImage(with: url)
        return cell
    }
}
