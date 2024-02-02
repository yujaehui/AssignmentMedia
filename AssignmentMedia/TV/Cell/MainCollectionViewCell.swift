//
//  MainCollectionViewCell.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/1/24.
//

import UIKit

class MainCollectionViewCell: BaseCollectionViewCell {
    let posterImageView = PosterImageView(frame: .zero)
    let titleLabel = MiniTitleLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
    }
    
    override func configureView() {
        //titleLabel.backgroundColor = .black.withAlphaComponent(0.5)
    }
    
    override func configureConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(posterImageView).inset(10)
            make.bottom.equalTo(posterImageView)
            make.height.equalTo(80)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
