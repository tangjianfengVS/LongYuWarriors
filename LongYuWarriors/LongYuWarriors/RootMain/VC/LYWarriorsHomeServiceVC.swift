//
//  LYWarriorsHomeServiceVC.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/1.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

let ServiceViewMargin: CGFloat = 10
class LYWarriorsHomeServiceVC: UIViewController {
    @IBOutlet weak var coverView: UIView!
    
    lazy var serviceView: LYWarriorsHomeServiceVI={
        let view = UINib(nibName: "LYWarriorsHomeServiceVI", bundle: nil).instantiate(withOwner: nil, options: nil).first as! LYWarriorsHomeServiceVI
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        coverView.circularBead(size: nil, corner: nil)
        view.addSubview(serviceView)
        
        serviceView.snp.makeConstraints { (make) in
            make.left.equalTo(view).offset(10)
            make.right.equalTo(view).offset(-10)
            make.top.equalTo(view).offset(50)
            make.height.equalTo(300)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func clickBeginGame(_ sender: UIButton) {
        present(LYWarriorsLoginVC(), animated: true, completion: nil)
    }
    
    deinit {
        print("Home释放")
    }
}
