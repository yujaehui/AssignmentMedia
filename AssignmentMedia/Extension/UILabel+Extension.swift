//
//  UILabel+Extension.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/7/24.
//

import UIKit

extension UILabel {
    func underLine(viewHeight: CGFloat, viewWidth: CGFloat) {
        let border = CALayer()
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: viewHeight, width: viewWidth, height: 1)
        border.borderWidth = 1
        self.layer.addSublayer(border)
    }
}
