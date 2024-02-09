//
//  TopCollectionViewCell.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/1/24.
//

import UIKit

final class TopCollectionViewCell: BaseCollectionViewCell {
    let rangkingLabel = UILabel()
    let posterImageView = PosterImageView(frame: .zero)
    
    override func configureHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(rangkingLabel)
    }
    
    override func configureView() {
        rangkingLabel.textColor = ColorStyle.mainColor
        rangkingLabel.textAlignment = .center
        rangkingLabel.font = UIFont(name: "Helvetica-BoldOblique", size: 60)
    }
    
    override func configureConstraints() {
        rangkingLabel.snp.makeConstraints { make in
            make.leading.bottom.equalTo(contentView)
        }
        posterImageView.snp.makeConstraints { make in
            make.leading.equalTo(rangkingLabel.snp.trailing).offset(10)
            make.verticalEdges.equalTo(contentView)
            make.width.equalTo(120)
        }
    }
}
