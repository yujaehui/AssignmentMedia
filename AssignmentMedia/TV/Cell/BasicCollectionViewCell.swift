//
//  BasicCollectionViewCell.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/30/24.
//

import UIKit

class BasicCollectionViewCell: BaseCollectionViewCell {
    let posterImageView = PosterImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubview(posterImageView)
    }
    
    override func configureView() {}
    
    override func configureConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
