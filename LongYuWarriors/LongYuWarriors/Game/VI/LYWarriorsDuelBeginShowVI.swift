//
//  LYWarriorsDuelBeginShowVI.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/11.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsDuelBeginShowVI: UIView {
    @IBOutlet weak var mosterImageView: UIImageView!
    @IBOutlet weak var defierImageView: UIImageView!
    @IBOutlet weak var vsImageView: UIImageView!
    var clousre: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        vsImageView.alpha = 0
        mosterImageView.transform = CGAffineTransform.init(translationX: 0, y: ScreenHeight/2)
        defierImageView.transform = CGAffineTransform.init(translationX: 0, y: -ScreenHeight/2)
        
        showbegin()
    }
    
    func showbegin() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.2) {
            UIView.animate(withDuration: 1.2, animations: {
                self.mosterImageView.transform = .identity
                self.defierImageView.transform = .identity
                self.vsImageView.alpha = 1
            }) { (_) in
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.8) {
                    if self.clousre != nil{
                        self.clousre!()
                    }
                    self.removeFromSuperview()
                };
            }
        }
    }
}
