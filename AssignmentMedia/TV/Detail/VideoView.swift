//
//  VideoView.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/13/24.
//

import UIKit
import WebKit
import SnapKit

class VideoView: BaseView {
    let webView = WKWebView()
    
    override func configureHierarchy() {
        addSubview(webView)
    }
    
    override func configureConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}

