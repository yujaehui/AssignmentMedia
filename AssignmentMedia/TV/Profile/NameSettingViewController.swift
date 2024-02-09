//
//  NameSettingViewController.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/7/24.
//

import UIKit

final class NameSettingViewController: UIViewController {
    private let nameSettingView = NameSettingView()
    
    var name: ((String) -> Void)?
    var type: profileInfoType = .name
    var userText: String = ""
    
    override func loadView() {
        self.view = nameSettingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = type.rawValue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(completeButtonClicked))
        
        nameSettingView.inputLabel.text = type.rawValue
        nameSettingView.inputTextField.text = userText
        nameSettingView.inputTextField.addTarget(self, action: #selector(inputTextFieldChanged), for: .allEvents)
    }
    
    @objc private func completeButtonClicked() {
        guard let text = nameSettingView.inputTextField.text else { return }
        name?(text)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func inputTextFieldChanged() {
        if nameSettingView.inputTextField.text == userText {
            navigationItem.rightBarButtonItem?.isEnabled = false
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }

}
