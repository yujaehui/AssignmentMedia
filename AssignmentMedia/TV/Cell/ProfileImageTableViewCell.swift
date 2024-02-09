//
//  ProfileImageTableViewCell.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/7/24.
//

import UIKit
import SnapKit

final class ProfileImageTableViewCell: BaseTableViewCell {
    let profileImageView = ProfileImageView(frame: .zero)
    let profileImageChangeButton = UIButton()
        
    override func configureHierarchy() {
        addSubview(profileImageView)
        addSubview(profileImageChangeButton)
    }
    
    override func configureView() {
        profileImageChangeButton.setTitle("프로필 사진 수정", for: .normal)
        profileImageChangeButton.setTitleColor(.systemBlue, for: .normal)
        profileImageChangeButton.titleLabel?.font = FontStyle.miniTitle
    }
    
    override func configureConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
            make.size.equalTo(100)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
        
        profileImageChangeButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.bottom.equalTo(safeAreaLayoutGuide).inset(20)
            make.width.equalTo(120)
            make.height.equalTo(40)
            make.centerX.equalTo(safeAreaLayoutGuide)
        }
    }
}
