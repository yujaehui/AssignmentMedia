//
//  BasicLabel.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/9/24.
//

import UIKit

final class BasicLabel: UILabel {
    enum LabelType {
        case title
        case minTitle
        case info
        case primary
        case secodary
        
        var font: UIFont {
            switch self {
            case .title: FontStyle.title
            case .minTitle: FontStyle.miniTitle
            case .info: FontStyle.info
            case .primary: FontStyle.primary
            case .secodary: FontStyle.secondary
            }
        }
        
        var color: UIColor {
            switch self {
            case .info: return ColorStyle.subColor
            default: return ColorStyle.mainColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(type: LabelType) {
        self.init(frame: .zero)
        configureView(type)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView(_ type: LabelType) {
        textColor = type.color
        font = type.font
    }
}

