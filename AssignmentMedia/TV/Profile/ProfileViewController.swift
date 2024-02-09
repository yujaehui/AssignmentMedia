//
//  ProfileViewController.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/7/24.
//

import UIKit

enum profileType: String, CaseIterable {
    case profileImage
    case profileInfo
}

enum profileInfoType: String, CaseIterable {
    case name = "이름"
    case userName = "사용자 이름"
    case description = "소개"
}

final class ProfileViewController: UIViewController {
    private let profileView = ProfileView()
    
    private var imageLink = UserDefaultsManager.shared.imageLink
    private var userLabelList = UserDefaultsManager.shared.user ?? Array(repeating: "", count: profileInfoType.allCases.count)
    
    override func loadView() {
        self.view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileView.tableView.dataSource = self
        profileView.tableView.delegate = self
        
        navigationItem.title = "프로필 편집"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.backButtonTitle = ""
    }
}

extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return profileType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch profileType.allCases[section] {
        case .profileImage: return 1
        case .profileInfo: return profileInfoType.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch profileType.allCases[indexPath.section] {
        case .profileImage:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileImageTableViewCell.identifier, for: indexPath) as! ProfileImageTableViewCell
            let url = URL(string: imageLink)
            cell.profileImageView.kf.setImage(with: url)
            cell.selectionStyle = .none
            return cell
        case .profileInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileInfoTableViewCell.identifier, for: indexPath) as! ProfileInfoTableViewCell
            cell.infoLabel.text = profileInfoType.allCases[indexPath.row].rawValue
            cell.userLabel.text = userLabelList[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch profileType.allCases[indexPath.section] {
        case .profileImage:
            changeProfileImage()
        case .profileInfo:
            let vc = NameSettingViewController()
            vc.type = profileInfoType.allCases[indexPath.row]
            vc.userText = userLabelList[indexPath.row]
            vc.name = { value in
                self.userLabelList[indexPath.row] = value
                tableView.reloadData()
                UserDefaultsManager.shared.user = self.userLabelList
            }
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    private func changeProfileImage() {
        if imageLink == UserDefaultsManager.shared.basicProfileImage {
            let vc = ProfileImageSettingViewController()
            vc.profileImage = { value in
                self.imageLink = value
                self.profileView.tableView.reloadData()
                UserDefaultsManager.shared.imageLink = self.imageLink
            }
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let selectButton = UIAlertAction(title: "추천 사진에서 선택", style: .default) { action in
                let vc = ProfileImageSettingViewController()
                vc.profileImage = { value in
                    self.imageLink = value
                    self.profileView.tableView.reloadData()
                    UserDefaultsManager.shared.imageLink = self.imageLink
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
            let deleteButton = UIAlertAction(title: "현재 사진 삭제", style: .destructive) { action in
                self.imageLink = UserDefaultsManager.shared.basicProfileImage
                UserDefaultsManager.shared.imageLink = self.imageLink
                self.profileView.tableView.reloadData()
            }
            let cancelButton = UIAlertAction(title: "취소", style: .cancel)
            sheet.addAction(selectButton)
            sheet.addAction(deleteButton)
            sheet.addAction(cancelButton)
            present(sheet, animated: true)
        }
    }
}


