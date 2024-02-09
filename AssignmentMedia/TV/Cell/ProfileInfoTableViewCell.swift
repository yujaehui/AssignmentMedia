//
//  ProfileInfoTableViewCell.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/7/24.
//

import UIKit
import SnapKit

final class ProfileInfoTableViewCell: BaseTableViewCell {
    let infoLabel = BasicLabel(type: .secodary)
    let userLabel = BasicLabel(type: .secodary)
    
    override func configureHierarchy() {
        addSubview(infoLabel)
        addSubview(userLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        userLabel.underLine(viewHeight: userLabel.frame.height, viewWidth: userLabel.frame.width)
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
