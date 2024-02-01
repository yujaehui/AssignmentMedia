//
//  BaseView.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/1/24.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = ColorStyle.backgroundColor
        configureHierarchy()
        configureView()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {}
    func configureView() {}
    func configureConstraints() {}
}
