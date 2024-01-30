//
//  TVViewController.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/30/24.
//

import UIKit
import SnapKit

class TVViewController: UIViewController {
    
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        configureHierarchy()
        configureView()
        configureConstraints()
        
        
    }
    
    func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    func configureView() {
        tableView.backgroundColor = .green
        tableView.rowHeight = 200
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TVTableViewCell.self, forCellReuseIdentifier: "TVTableViewCell")
    }
    
    func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension TVViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVTableViewCell", for: indexPath) as! TVTableViewCell
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
        cell.collectionView.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: "TVCollectionViewCell")
        return cell
    }
}

extension TVViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TVCollectionViewCell", for: indexPath) as! TVCollectionViewCell
        return cell
    }
    
    
}
