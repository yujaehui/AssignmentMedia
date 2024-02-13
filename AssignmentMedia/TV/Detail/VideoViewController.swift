//
//  VideoViewController.swift
//  AssignmentMedia
//
//  Created by Jaehui Yu on 2/13/24.
//

import UIKit

class VideoViewController: UIViewController {
    let videoView = VideoView()
    var id = 0
    var video = Video(id: 0, results: [])
    
    override func loadView() {
        super.loadView()
        self.view = videoView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let group = DispatchGroup()
        
        group.enter()
        TVAPIManager.shared.request(type: Video.self, api: .video(id: id)) { video in
            self.video = video
            group.leave()
        }
        
        group.notify(queue: .main) {
            let link = "https://www.youtube.com/watch?v=\(self.video.results[0].key)"
            if let url = URL(string: link) {
                let request = URLRequest(url: url)
                self.videoView.webView.load(request)
            }
        }
    }
}
