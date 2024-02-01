//
//  TVMainTableViewCell.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/31/24.
//

import UIKit

private enum Const {
    static let itemSize = CGSize(width: UIScreen.main.bounds.width - 48, height: (UIScreen.main.bounds.width - 48)*5/4)
    static let itemSpacing = 12.0
    
    static var insetX: CGFloat {
      (UIScreen.main.bounds.width - Self.itemSize.width) / 2.0
    }
    static var collectionViewContentInset: UIEdgeInsets {
      UIEdgeInsets(top: 0, left: Self.insetX, bottom: 0, right: Self.insetX)
    }
  }

class TVMainTableViewCell: BaseTableViewCell {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: configureCollectionViewLayout())
    
    var mainList: [Result] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubview(collectionView)
    }
    
    override func configureView() {
        collectionView.backgroundColor = ColorStyle.backgroundColor
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TVMainCollectionViewCell.self, forCellWithReuseIdentifier: TVMainCollectionViewCell.identifier)

        collectionView.contentInset = Const.collectionViewContentInset
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.decelerationRate = .fast
    }
    
    override func configureConstraints() {
        collectionView.snp.makeConstraints { make in
            make.left.right.equalTo(contentView)
            make.height.equalTo(Const.itemSize.height)
            make.centerY.equalTo(contentView)
        }
    }
}

extension TVMainTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = min(5, mainList.count)
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TVMainCollectionViewCell.identifier, for: indexPath) as! TVMainCollectionViewCell
        let row = mainList[indexPath.row]
        let url = URL(string: TVAPIManager.shared.imageeBaseURL + row.poster_path)
        cell.posterImageView.kf.setImage(with: url)
        cell.titleLabel.text = row.name
        return cell
    }
    
    static func configureCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = Const.itemSize
        layout.minimumLineSpacing = Const.itemSpacing
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        return layout
    }
}

extension TVMainTableViewCell: UICollectionViewDelegateFlowLayout {
  func scrollViewWillEndDragging(
    _ scrollView: UIScrollView,
    withVelocity velocity: CGPoint,
    targetContentOffset: UnsafeMutablePointer<CGPoint>
  ) {
    let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
    let cellWidth = Const.itemSize.width + Const.itemSpacing
    let index = round(scrolledOffsetX / cellWidth)
    targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
  }
}
