//
//  PosterImageView.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/31/24.
//

import UIKit

class PosterImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureView() {
        clipsToBounds = true
        layer.cornerRadius = 5
    }
}
