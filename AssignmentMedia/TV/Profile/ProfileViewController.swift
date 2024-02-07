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

class ProfileViewController: UIViewController {
    
    let profileView = ProfileView()
    var userLabelList = UserDefaultsManager.shared.user ?? Array(repeating: "", count: profileInfoType.allCases.count)
    
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
            return cell
        case .profileInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileInfoTableViewCell.identifier, for: indexPath) as! ProfileInfoTableViewCell
            cell.infoLabel.text = profileInfoType.allCases[indexPath.row].rawValue
            cell.userLabel.text = userLabelList[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch profileType.allCases[indexPath.section] {
        case .profileImage:
            print("ggg")
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
}
