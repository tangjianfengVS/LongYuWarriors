//
//  LYWarriorsLoginVC.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/1.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsLoginVC: UIViewController{
    @IBOutlet weak var userNameView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var topLayout: NSLayoutConstraint!
    @IBOutlet weak var bottomLayout: NSLayoutConstraint!
    
    private var delegate: SafeLayoutProtocol?{
        didSet{
            delegate?.safeLayoutSize(top: topLayout, bottom: bottomLayout)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
       
        userNameView.layer.cornerRadius = userNameView.bounds.height/2
        userNameView.layer.masksToBounds = true
        passwordView.layer.cornerRadius = userNameView.bounds.height/2
        passwordView.layer.masksToBounds = true
        loginBtn.layer.cornerRadius = loginBtn.bounds.height/2
        loginBtn.layer.masksToBounds = true
        registerBtn.layer.cornerRadius = registerBtn.bounds.height/2
        registerBtn.layer.masksToBounds = true
        
        registerBtn.backgroundColor = UIColor.clear
        registerBtn.layer.borderColor = UIColor.white.cgColor
        registerBtn.layer.borderWidth = 0.6
        backBtn.circularBead(size: CGSize(width: backBtn.bounds.width/2, height: backBtn.bounds.width/2), corner: nil)
    }
    
    @IBAction func clickLoginGame(_ sender: UIButton) {
        dismiss(animated: true) {
            NotificationCenter.default.post(name: NSNotification.Name.init(LYWarriorsUpdateRootNotif), object: LYWarriorsChoosegRoleVC(), userInfo: nil)
        }
    }
    
    @IBAction func clickBackBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("Login释放")
    }
}

extension LYWarriorsLoginVC: SafeLayoutProtocol{

}
