//
//  SearchViewController.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/4/24.
//

import UIKit

class SearchViewController: UIViewController {
    
    let searchView = SearchView()
    
    override func loadView() {
        self.view = searchView
    }
    
    var searchList: [Result] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.searchBar.delegate = self
        searchView.collectionView.dataSource = self
        searchView.collectionView.delegate = self
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        TVAPIManager.shared.request(type: TVModel.self, api: .search(query: text)) { search in
            self.searchList = search.results
            self.searchView.collectionView.reloadData()
        }
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicCollectionViewCell.identifier, for: indexPath) as! BasicCollectionViewCell
        let row = searchList[indexPath.row]
        let url = URL(string: TVAPIManager.shared.imageeBaseURL + row.poster_path)
        cell.posterImageView.kf.setImage(with: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("GGG")
        let vc = DetailViewController()
        vc.id = searchList[indexPath.row].id
        present(vc, animated: true)
    }
    
    
}
