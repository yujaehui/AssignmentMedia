//
//  DetailViewController.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/31/24.
//

import UIKit
import Kingfisher

enum DetailCellType: Int, CaseIterable {
    case mainInfo
    case subInfo
    case recommend
    
    static var category: String {
        return "비슷한 콘텐츠"
    }
}

class DetailViewController: BaseViewController {
    
    let tvDetailView = DetailView()
    
    override func loadView() {
        self.view = tvDetailView
    }

    var id = 0
    var detail = SeriesDetailsModel(backdropPath: "", posterPath: "", name: "", date: "", episodeRunTime: [], networks: [], createdBy: [], overview: "")
    var credit = AggregateCreditsModel(cast: [])
    var recommend: [Result] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tvDetailView.tableView.dataSource = self
        tvDetailView.tableView.delegate = self
        
        let group = DispatchGroup()
        
        group.enter()
        TVAPIManager.shared.request(type: SeriesDetailsModel.self, api: .detail(id: id)) { detail in
            self.detail = detail
            group.leave()
        }
        
        group.enter()
        TVAPIManager.shared.request(type: AggregateCreditsModel.self, api: .credit(id: id)) { credit in
            self.credit = credit
            group.leave()
        }
        
        group.enter()
        TVAPIManager.shared.request(type: TVModel.self, api: .recommend(id: id)) { recommend in
            self.recommend = recommend.results
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tvDetailView.tableView.reloadData()
            let url = URL(string: TVAPIManager.shared.imageeBaseURL + self.detail.backdropPath)
            self.tvDetailView.backdropImageView.kf.setImage(with: url)
        }
    }
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DetailCellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch DetailCellType.allCases[indexPath.row] {
        case .mainInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: MainInfoTableViewCell.identifier, for: indexPath) as! MainInfoTableViewCell
            cell.configureCell(detail: detail)
            return cell
        case .subInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: SubInfoTableViewCell.identifier, for: indexPath) as! SubInfoTableViewCell
            cell.configureCell(detail: detail, credit: credit)
            return cell
        case .recommend:
            let cell = tableView.dequeueReusableCell(withIdentifier: BasicTableViewCell.identifier, for: indexPath) as! BasicTableViewCell
            cell.type = .detail
            cell.recommend = recommend
            cell.categoryLabel.text = DetailCellType.category
            cell.collectionView.tag = 0
            cell.collectionView.reloadData()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch DetailCellType.allCases[indexPath.row] {
        case .mainInfo: return UITableView.automaticDimension
        case .subInfo: return UITableView.automaticDimension
        case .recommend: return 200
        }
    }
}

extension DetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommend.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicCollectionViewCell.identifier, for: indexPath) as! BasicCollectionViewCell
        let row = recommend[indexPath.row]
        let url = URL(string: TVAPIManager.shared.imageeBaseURL + row.poster_path)
        cell.posterImageView.kf.setImage(with: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("sss")
        let detailViewController = DetailViewController()
        detailViewController.id = recommend[indexPath.row].id
        present(detailViewController, animated: true)
    }
}
