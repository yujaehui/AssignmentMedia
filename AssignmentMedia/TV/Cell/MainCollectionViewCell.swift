//
//  MainCollectionViewCell.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/1/24.
//

import UIKit

final class MainCollectionViewCell: BaseCollectionViewCell {
    let posterImageView = PosterImageView(frame: .zero)
    
    override func configureHierarchy() {
        contentView.addSubview(posterImageView)
    }
    
    override func configureConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
