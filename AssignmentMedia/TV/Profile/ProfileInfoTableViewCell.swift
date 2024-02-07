//
//  ProfileInfoTableViewCell.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/7/24.
//

import UIKit
import SnapKit

class ProfileInfoTableViewCell: BaseTableViewCell {
    let infoLabel = UILabel()
    let userLabel = UILabel()
    
    override func configureHierarchy() {
        addSubview(infoLabel)
        addSubview(userLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userLabel.underLine(viewHeight: userLabel.frame.height, viewWidth: userLabel.frame.width)
    }
    
    override func configureView() {
        infoLabel.textColor = ColorStyle.mainColor
        infoLabel.font = .boldSystemFont(ofSize: 16)
        userLabel.textColor = ColorStyle.mainColor
        userLabel.font = .boldSystemFont(ofSize: 16)
    }
    
    override func configureConstraints() {
        infoLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(safeAreaLayoutGuide).inset(8)
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
        
        userLabel.snp.makeConstraints { make in
            make.verticalEdges.equalTo(safeAreaLayoutGuide).inset(8)
            make.leading.equalTo(infoLabel.snp.trailing).inset(8)
            make.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(50)
        }
    }
}
