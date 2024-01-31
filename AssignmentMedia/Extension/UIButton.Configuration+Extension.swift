//
//  UIButton.Configuration+Extension.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/31/24.
//

import UIKit

extension UIButton.Configuration {
    static func detailStyle(title: String, image: String) -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        
        var titleAttr = AttributedString.init(title)
        titleAttr.font = .systemFont(ofSize: 14, weight: .semibold)
        config.attributedTitle = titleAttr
        config.titleAlignment = .center
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .light)
        config.image = UIImage(systemName: image, withConfiguration: imageConfig)
        config.imagePadding = 8
        config.imagePlacement = .top
        
        config.baseForegroundColor = ColorStyle.subColor
        config.baseBackgroundColor = ColorStyle.backgroundColor
        
        return config
    }
}
