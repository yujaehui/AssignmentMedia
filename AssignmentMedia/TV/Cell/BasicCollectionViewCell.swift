//
//  BasicCollectionViewCell.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/30/24.
//

import UIKit

final class BasicCollectionViewCell: BaseCollectionViewCell {
    let posterImageView = PosterImageView(frame: .zero)
    
    override func configureHierarchy() {
        contentView.addSubview(posterImageView)
    }
        
    override func configureConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
