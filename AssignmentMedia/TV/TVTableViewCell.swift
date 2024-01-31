//
//  TVTableViewCell.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/30/24.
//

import UIKit

class TVTableViewCell: BaseTableViewCell {
    
    let promotionLabel = SecondaryLabel()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubview(promotionLabel)
        contentView.addSubview(collectionView)
    }
    
    override func configureView() {
        collectionView.backgroundColor = ColorStyle.backgroundColor
    }
    
    override func configureConstraints() {
        promotionLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).inset(16)
            make.width.equalTo(200)
            make.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(promotionLabel.snp.bottom).offset(8)
            make.horizontalEdges.bottom.equalTo(contentView)
        }
    }
}

extension TVTableViewCell {
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
