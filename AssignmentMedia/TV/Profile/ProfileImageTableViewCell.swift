//
//  ProfileImageTableViewCell.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/7/24.
//

import UIKit
import SnapKit

class ProfileImageTableViewCell: BaseTableViewCell {
    let profileImageView = UIImageView()
    let profileImageChangeButton = UIButton()
    
    override func configureHierarchy() {
        addSubview(profileImageView)
        addSubview(profileImageChangeButton)
    }
    
    override func configureView() {
        profileImageView.image = UIImage(systemName: "person.circle.fill")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.tintColor = .gray
        profileImageView.backgroundColor = .white
        
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        
        profileImageChangeButton.setTitle("프로필 사진 수정", for: .normal)
        profileImageChangeButton.setTitleColor(.systemBlue, for: .normal)
        profileImageChangeButton.titleLabel?.font = .boldSystemFont(ofSize: 14)

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
