//
//  HeaderViewController.swift
//  hakugin
//
//  Created by 樋口裕貴 on 2020/11/06.
//  Copyright © 2020 Yuki Higuchi. All rights reserved.
//


import UIKit
import MXParallaxHeader

final class HeaderViewController: UIViewController {
    @IBOutlet var visualEffectView: UIVisualEffectView!
    @IBOutlet var titleLabel: UILabel! {
        didSet {
            titleLabel.layer.shadowColor = UIColor.black.cgColor
            titleLabel.layer.shadowOffset = CGSize(width: 0, height: 1)
            titleLabel.layer.shadowOpacity = 0.3
            titleLabel.layer.shadowRadius = 3
        }
    }
      let imageSample = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        parallaxHeader?.delegate = self
        
        
        // スクリーンサイズの取得
              let screenW:CGFloat = view.frame.size.width
              let screenH:CGFloat = view.frame.size.height
              
              // 画像を読み込んで、準備しておいたimageSampleに設定
              imageSample.image = UIImage(named: "yukiyama.jpg")
              // 画像のフレームを設定
              imageSample.frame = CGRect(x:0, y:0, width:414, height:300)
              
              // 画像を中央に設定
              imageSample.center = CGPoint(x:screenW/2, y:screenH/2)
              
              // 設定した画像をスクリーンに表示する
              self.view.addSubview(imageSample)
    }
}

extension HeaderViewController: MXParallaxHeaderDelegate {
    func parallaxHeaderDidScroll(_ parallaxHeader: MXParallaxHeader) {
        let alpha = 1 - min(1, parallaxHeader.progress)
        visualEffectView.alpha = alpha
        titleLabel.alpha = alpha
    }
}
