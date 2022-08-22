//
//  ViewController.swift
//  WhatsAppShare
//
//  Created by young on 08/22/2022.
//  Copyright (c) 2022 young. All rights reserved.
//

import UIKit
import WhatsAppShare

class ViewController: UIViewController {
    lazy var textBtn: UIButton = {
        let btn = UIButton.init(type: .system)
        btn.setTitle("链接文本分享", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        btn.backgroundColor = .blue
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(shareEventClick(_ :)), for: .touchUpInside)
        return btn
    }()
    
    lazy var picBtn: UIButton = {
        let btn = UIButton.init(type: .system)
        btn.setTitle("图片分享", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        btn.backgroundColor = .blue
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(shareEventClick(_ :)), for: .touchUpInside)
        return btn
    }()
    
    lazy var videoBtn: UIButton = {
        let btn = UIButton.init(type: .system)
        btn.setTitle("视频分享", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        btn.backgroundColor = .blue
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(shareEventClick(_ :)), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textBtn)
        view.addSubview(picBtn)
        view.addSubview(videoBtn)
        let rect = view.bounds
        textBtn.frame = CGRect(x: rect.midX - 100, y: 200, width: 200, height: 40)
        picBtn.frame = CGRect(x: rect.midX - 100, y: 300, width: 200, height: 40)
        videoBtn.frame = CGRect(x: rect.midX - 100, y: 400, width: 200, height: 40)
    }

    @objc func shareEventClick(_ sender : UIButton) {
        if sender.isEqual(textBtn) {
            let privateUrl = "www.baidu.com"
            let text = "这是个链接分享" + privateUrl
            WhatsAppShare.shared.shareText(text)
        }
        else if sender.isEqual(picBtn) {
            let img = UIImage.init(named: "share.jpg")!
            WhatsAppShare.shared.showImg(img, showVC: self)
        }
        else if sender.isEqual(videoBtn) {
            do {
                let data = try Data.init(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "share", ofType: "mp4")!))
                WhatsAppShare.shared.showVideo(data, showVC: self)
            } catch {
                print("获取视频错误:%@", error.localizedDescription)
            }
        }
    }

}


