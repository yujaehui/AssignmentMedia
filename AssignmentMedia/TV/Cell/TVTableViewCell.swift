//
//  TVTableViewCell.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/30/24.
//

import UIKit

class TVTableViewCell: BaseTableViewCell {
    let categoryLabel = PrimaryLabel()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    var list: [[Result]] = [[], [], []]
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubview(categoryLabel)
        contentView.addSubview(collectionView)
    }
    
    override func configureView() {
        collectionView.backgroundColor = ColorStyle.backgroundColor
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
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

extension TVTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as! TVCollectionViewCell
        let row = list[collectionView.tag][indexPath.row]
        let url = URL(string: TVAPIManager.shared.imageeBaseURL + row.poster_path)
        cell.posterImageView.kf.setImage(with: url)
        return cell
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 120, height: 160)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .horizontal
        return layout
    }
}
