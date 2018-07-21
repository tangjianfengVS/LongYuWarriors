//
//  LYWarriorsHomeServiceVC.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/1.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

let ServiceViewWidth: CGFloat=335
class LYWarriorsHomeServiceVC: LYWarriorsBaseNormalFuncVC {
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var brandImageView: UIImageView!

    var block: ((CGSize)->())!
    
    lazy var serviceView: LYWarriorsHomeServiceVI={
        let view = UINib(nibName: "LYWarriorsHomeServiceVI", bundle: nil).instantiate(withOwner: nil, options: nil).first as! LYWarriorsHomeServiceVI
        return view
    }()
    
    init(clousre: @escaping (CGSize)->()) {
        block = clousre
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coverView.circularBead(size: nil, corner: nil)
        view.addSubview(serviceView)
        
        serviceView.snp.makeConstraints { (make) in
            make.width.equalTo(ServiceViewWidth)
            make.centerX.equalTo(view)
            make.top.equalTo(brandImageView.snp.bottom).offset(25)
            make.height.equalTo(300)
        }
    }
    
    override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            if view.safeAreaInsets.top > 0 || view.safeAreaInsets.bottom > 0{
                block(CGSize(width: view.safeAreaInsets.top, height: view.safeAreaInsets.bottom))
            }
        }
    }
    
    @IBAction func clickBeginGame(_ sender: UIButton) {
        present(LYWarriorsLoginVC(), animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("Home释放")
    }
}
