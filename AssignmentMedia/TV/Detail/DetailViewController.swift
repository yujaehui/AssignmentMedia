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

final class DetailViewController: BaseViewController {
    weak var delegate: BasicTableViewCellDelegate?
    
    private let detailView = DetailView()
    
    var id = 0
    private var detail = SeriesDetailsModel(backdropPath: "", posterPath: "", name: "", date: "", episodeRunTime: [], networks: [], createdBy: [], overview: "")
    private var credit = AggregateCreditsModel(cast: [])
    private var recommend: [Result] = []
    
    override func loadView() {
        self.view = detailView
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailView.tableView.dataSource = self
        detailView.tableView.delegate = self
        
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
            self.detailView.tableView.reloadData()
            let url = URL(string: TVAPIManager.shared.imageeBaseURL + self.detail.backdropPath)
            self.detailView.backdropImageView.kf.setImage(with: url)
        }
        
        detailView.playButton.addTarget(self, action: #selector(playButtonClicked), for: .touchUpInside)
        detailView.dismissButton.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
        detailView.xButton.addTarget(self, action: #selector(xButtonClicked), for: .touchUpInside)
    }
    
    @objc private func playButtonClicked() {
        print(id)
        let vc = VideoViewController()
        vc.id = id
        present(vc, animated: true)
    }
    
    @objc private func dismissButtonClicked() {
        dismiss(animated: true)
    }
    
    @objc private func xButtonClicked() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        let vc = ViewController()
        sceneDelegate?.window?.rootViewController = vc
        sceneDelegate?.window?.makeKeyAndVisible()
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
            cell.delegate = self
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
}

extension DetailViewController: BasicTableViewCellDelegate {
    func didSelectItem(withID id: Int) {
        let vc = DetailViewController()
        vc.id = id
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
}
