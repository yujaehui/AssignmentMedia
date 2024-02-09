//
//  NameSettingView.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/7/24.
//

import UIKit
import SnapKit

final class NameSettingView: BaseView {
    let inputLabel = UILabel()
    let inputTextField = UITextField()
    
    override func configureHierarchy() {
        addSubview(inputLabel)
        addSubview(inputTextField)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        inputTextField.underLine(viewHeight: inputTextField.frame.height, viewWidth: inputTextField.frame.width)
    }
    
    override func configureView() {
        inputLabel.textColor = .systemGray
        inputLabel.font = .systemFont(ofSize: 14)
        
        inputTextField.textColor = .white
        inputTextField.font = .boldSystemFont(ofSize: 16)
        inputTextField.becomeFirstResponder()
        inputTextField.clearButtonMode = .whileEditing
        if let clearButton = inputTextField.value(forKey: "_clearButton") as? UIButton {
            let templateImage = clearButton.imageView?.image?.withRenderingMode(.automatic)
            clearButton.setImage(templateImage, for: .normal)
            clearButton.tintColor = .lightGray
        }
        
    }
    
    override func configureConstraints() {
        inputLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(8)
            make.leading.equalTo(safeAreaLayoutGuide).inset(16)
            make.width.equalTo(100)
            make.height.equalTo(16)
        }
        
        inputTextField.snp.makeConstraints { make in
            make.top.equalTo(inputLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(16)
            make.height.equalTo(34)
        }
    }
}
