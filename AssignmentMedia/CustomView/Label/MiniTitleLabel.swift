//
//  MiniTitleLabel.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/31/24.
//

import UIKit

class MiniTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        textColor = ColorStyle.mainColor
        font = FontStyle.miniTitle
    }
}

