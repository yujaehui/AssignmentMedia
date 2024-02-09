//
//  BaseViewController.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/31/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = ColorStyle.backgroundColor
        configureHierarchy()
        configureView()
        configureConstraints()
    }
    
    func configureHierarchy() {}
    func configureView() {}
    func configureConstraints() {}
}
