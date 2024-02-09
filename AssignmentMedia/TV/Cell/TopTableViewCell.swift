//
//  TopTableViewCell.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/1/24.
//

import UIKit

protocol TopTableViewCellDelegate: AnyObject {
    func didSelectItem(withID id: Int)
}

final class TopTableViewCell: BaseTableViewCell {
    weak var delegate: TopTableViewCellDelegate?
    let categoryLabel = BasicLabel(type: .primary)
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    var list: [[Result]] = [[], [], []]
    
    override func configureHierarchy() {
        contentView.addSubview(categoryLabel)
        contentView.addSubview(collectionView)
    }
    
    override func configureView() {
        collectionView.backgroundColor = ColorStyle.backgroundColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TopCollectionViewCell.self, forCellWithReuseIdentifier: TopCollectionViewCell.identifier)
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

extension TopTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCollectionViewCell.identifier, for: indexPath) as! TopCollectionViewCell
        let row = list[collectionView.tag][indexPath.row]
        let url = URL(string: TVAPIManager.shared.imageeBaseURL + row.poster_path)
        cell.posterImageView.kf.setImage(with: url)
        cell.rangkingLabel.text = "\(indexPath.row + 1)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = list[collectionView.tag][indexPath.row].id
        delegate?.didSelectItem(withID: id)
    }
    
    private static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 185, height: 160)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal
        return layout
    }
}
