//
//  ProfileImageSettingViewController.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/9/24.
//

import UIKit

final class ProfileImageSettingViewController: UIViewController {
    private let profileImageSettingView = ProfileImageSettingView()
    
    private var imageSearchList: [Item] = []
    private var imageLink = UserDefaultsManager.shared.imageLink
    var profileImage: ((String) -> Void)?
    
    override func loadView() {
        self.view = profileImageSettingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        profileImageSettingView.collectionView.dataSource = self
        profileImageSettingView.collectionView.delegate = self
        profileImageSettingView.searchBar.delegate = self
        
        navigationItem.title = "사진 수정"
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(completeButtonClicked))
        
        let url = URL(string: imageLink)
        profileImageSettingView.selectProfileImageView.kf.setImage(with: url)
    }
    
    @objc private func completeButtonClicked() {
        profileImage?(imageLink)
        navigationController?.popViewController(animated: true)
    }
}

extension ProfileImageSettingViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        ImageAPIManager.shared.request(query: text) { image in
            self.imageSearchList = image.items
            self.profileImageSettingView.collectionView.reloadData()
        }
    }
}

extension ProfileImageSettingViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageSearchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicCollectionViewCell.identifier, for: indexPath) as! BasicCollectionViewCell
        let row = imageSearchList[indexPath.row]
        let url = URL(string: row.link)
        cell.posterImageView.kf.setImage(with: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        let row = imageSearchList[indexPath.row]
        let url = URL(string: row.link)
        profileImageSettingView.selectProfileImageView.kf.setImage(with: url)
        imageLink = row.link
    }
}
