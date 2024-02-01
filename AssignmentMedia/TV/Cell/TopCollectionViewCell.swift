//
//  TopCollectionViewCell.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/1/24.
//

import UIKit

class TopCollectionViewCell: BaseCollectionViewCell {
    let rangkingLabel = UILabel()
    let posterImageView = PosterImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(rangkingLabel)
    }
    
    override func configureView() {
        rangkingLabel.text = "20"
        rangkingLabel.textColor = .white
        rangkingLabel.textAlignment = .center
        rangkingLabel.font = UIFont(name: "Helvetica-BoldOblique", size: 60)
    }
    
    override func configureConstraints() {
        rangkingLabel.snp.makeConstraints { make in
            make.leading.bottom.equalTo(contentView)
            //make.height.equalTo(100)
        }
        posterImageView.snp.makeConstraints { make in
            make.leading.equalTo(rangkingLabel.snp.trailing).offset(10)
            make.verticalEdges.equalTo(contentView)
            make.width.equalTo(120)
        }
    }
}
