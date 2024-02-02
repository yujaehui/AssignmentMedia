//
//  MainInfoTableViewCell.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 1/31/24.
//

import UIKit

class MainInfoTableViewCell: BaseTableViewCell {
    
    let titleLabel = TitleLabel()
    let infoLabel = InfoLabel()
    let heartButton = UIButton()
    let shareButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func configureCell(detail: SeriesDetailsModel) {
        titleLabel.text = detail.name
        if detail.episodeRunTime.isEmpty {
            infoLabel.text = detail.date
        } else {
            infoLabel.text = "\(detail.date) · \(detail.episodeRunTime.first!)분"
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(infoLabel)
        contentView.addSubview(heartButton)
        contentView.addSubview(shareButton)
    }
    
    override func configureView() {
        heartButton.configuration = .detailStyle(title: "찜", image: "heart")
        shareButton.configuration = .detailStyle(title: "공유", image: "square.and.arrow.up")
    }
    
    override func configureConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(16)
            make.horizontalEdges.equalTo(contentView).inset(8)
            make.height.equalTo(25)
        }
        
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView).inset(8)
            make.height.equalTo(20)
        }
        
        heartButton.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(20)
            make.leading.equalTo(contentView).inset(8)
            make.height.equalTo(40)
            make.bottom.equalTo(contentView).inset(16)

        }
        
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(infoLabel.snp.bottom).offset(20)
            make.leading.equalTo(heartButton.snp.trailing).offset(8)
            make.height.equalTo(40)
            make.bottom.equalTo(contentView).inset(16)
        }
    }
    
}
