//
//  BasicTableViewCell.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/30/24.
//

import UIKit

protocol BasicTableViewCellDelegate: AnyObject {
    func didSelectItem(withID id: Int)
}

enum ViewType: CaseIterable {
    case home
    case detail
}

final class BasicTableViewCell: BaseTableViewCell {
    weak var delegate: BasicTableViewCellDelegate?
    let categoryLabel = BasicLabel(type: .primary)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    var type: ViewType = .home
    var list: [[Result]] = [[], [], []]
    var recommend: [Result] = []
    
    override func configureHierarchy() {
        contentView.addSubview(categoryLabel)
        contentView.addSubview(collectionView)
    }
    
    override func configureView() {
        collectionView.backgroundColor = ColorStyle.backgroundColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BasicCollectionViewCell.self, forCellWithReuseIdentifier: BasicCollectionViewCell.identifier)
    }
    
    override func configureConstraints() {
        categoryLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).inset(16)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(categoryLabel.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(contentView)
        }
    }
}

extension BasicTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch type {
        case .home: return list[collectionView.tag].count
        case .detail: return recommend.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch type {
        case .home:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicCollectionViewCell.identifier, for: indexPath) as! BasicCollectionViewCell
            let row = list[collectionView.tag][indexPath.row]
            let url = URL(string: TVAPIManager.shared.imageeBaseURL + row.poster_path)
            cell.posterImageView.kf.setImage(with: url)
            return cell
        case .detail:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicCollectionViewCell.identifier, for: indexPath) as! BasicCollectionViewCell
            let row = recommend[indexPath.row]
            let url = URL(string: TVAPIManager.shared.imageeBaseURL + row.poster_path)
            cell.posterImageView.kf.setImage(with: url)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch type {
        case .home:
            let id = list[collectionView.tag][indexPath.row].id
            delegate?.didSelectItem(withID: id)
        case .detail:
            let id = recommend[indexPath.row].id
            delegate?.didSelectItem(withID: id)
        }
    }
    
    private static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 120, height: 160)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal
        return layout
    }
}
