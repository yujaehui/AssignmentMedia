//
//  SearchView.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/4/24.
//

import UIKit

final class SearchView: BaseView {
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.searchTextField.attributedPlaceholder = NSAttributedString(string: "제목을 검색하세요", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        return view
    }()
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
        view.backgroundColor = ColorStyle.backgroundColor
        view.register(BasicCollectionViewCell.self, forCellWithReuseIdentifier: BasicCollectionViewCell.identifier)
        return view
    }()
    
    private static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 10
        let cellWidth = UIScreen.main.bounds.width - (spacing * 4)
        let itemSizeWidth = cellWidth / 3
        layout.itemSize = CGSize(width: itemSizeWidth, height: itemSizeWidth*4/3)
        layout.sectionInset = UIEdgeInsets(top: 0, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        return layout
    }
    
    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(collectionView)
    }
    
    override func configureConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
