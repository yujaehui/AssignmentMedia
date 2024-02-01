//
//  TVSubInfoTableViewCell.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/31/24.
//

import UIKit

class TVSubInfoTableViewCell: BaseTableViewCell {
    
    let posterImageView = PosterImageView(frame: .zero)
    let titleLabel = MiniTitleLabel()
    let networkLabel = InfoLabel()
    let creatorInfoLabel = InfoLabel()
    let creatorLabel = InfoLabel()
    let creditInfoLabel = InfoLabel()
    let creditLabel = InfoLabel()
    let descriptionLabel = InfoLabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = ColorStyle.backgroundColor.withAlphaComponent(0.9)
    }
    
    func configureCell(detail: SeriesDetailsModel, credit: AggregateCreditsModel) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(detail.posterPath)")
        posterImageView.kf.setImage(with: url)
        titleLabel.text = detail.name
        networkLabel.text = detail.networks.map { $0.name }.joined(separator: ", ")
        creatorLabel.text = detail.createdBy.map { $0.name }.joined(separator: ", ")
        let creditConut = min(5, credit.cast.count)
        creditLabel.text = credit.cast.prefix(creditConut).map { $0.name }.joined(separator: ", ")
        descriptionLabel.text = detail.overview
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(networkLabel)
        contentView.addSubview(creatorInfoLabel)
        contentView.addSubview(creatorLabel)
        contentView.addSubview(creditInfoLabel)
        contentView.addSubview(creditLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    override func configureView() {
        creatorInfoLabel.text = "크리에이터"
        creditInfoLabel.text = "출연"
        creditLabel.numberOfLines = 0
        descriptionLabel.numberOfLines = 0
    }
    
    override func configureConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).inset(16)
            make.width.equalTo(52.5)
            make.height.equalTo(70)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.trailing.equalTo(contentView).inset(16)
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.height.equalTo(16)
        }
        
        networkLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.trailing.equalTo(contentView).inset(16)
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.height.equalTo(14)
        }
        
        creatorInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(networkLabel.snp.bottom).offset(4)
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.width.equalTo(57)
            make.height.equalTo(14)
        }
        
        creatorLabel.snp.makeConstraints { make in
            make.top.equalTo(networkLabel.snp.bottom).offset(4)
            make.trailing.equalTo(contentView).inset(16)
            make.leading.equalTo(creatorInfoLabel.snp.trailing).offset(8)
            make.height.equalTo(14)
        }
        
        creditInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(creatorInfoLabel.snp.bottom).offset(4)
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.width.equalTo(23)
            make.height.equalTo(14)
        }
        
        creditLabel.snp.makeConstraints { make in
            make.top.equalTo(creatorLabel.snp.bottom).offset(4)
            make.leading.equalTo(creditInfoLabel.snp.trailing).offset(8)
            make.trailing.equalTo(contentView).inset(16)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(creditLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalTo(contentView).inset(8)
            make.bottom.equalTo(contentView).inset(16)
        }
    }
    
    
}
