//
//  TVTableViewCell.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/30/24.
//

import UIKit

class TVTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 150, height: 200)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        configureHierarchy()
        configureView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    
    func configureView() {
        titleLabel.textColor = .white
        titleLabel.font = .boldSystemFont(ofSize: 20)
        collectionView.backgroundColor = .black
    }
    
    func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).inset(10)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(contentView)
        }
    }
}
