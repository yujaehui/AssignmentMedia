//
//  ProfileImageView.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/9/24.
//

import UIKit

final class ProfileImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        contentMode = .scaleAspectFill
        layer.cornerRadius = 50
        clipsToBounds = true
    }
}
