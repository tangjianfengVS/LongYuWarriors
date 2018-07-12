//
//  LYWarriorsChoosegRoleVC.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/4.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsChoosegRoleVC: UIViewController {
    private let LYWarriorsInterfaceCellID = "LYWarriorsInterfaceCellID"
    private let count: CGFloat = 4
    private let insetsWidth: CGFloat = 8
    private let roleListLeftSize: CGFloat = 15
    private let itemSize: CGSize = CGSize(width: 112, height: 180)
    private let choosegRoleVM = LYWarriorsChoosegRoleVM()
    var safeGaugeSize: (CGFloat,CGFloat)=(0,0)
    
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var topLayout: NSLayoutConstraint!
    @IBOutlet weak var bottomLayout: NSLayoutConstraint!
    
    private var delegate: SafeLayoutProtocol?{
        didSet{
            delegate?.safeLayoutSize(top: topLayout, bottom: bottomLayout)
            safeGaugeSize = (delegate?.safeLayoutGaugeSize())!
        }
    }
    
    lazy var labView: UIView={
        let view = UIView()
        view.backgroundColor = UIColor.cyan
        return view
    }()
    
    lazy var roleList: UICollectionView={
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(UINib.init(nibName: "LYWarriorsInterfaceCell", bundle: nil), forCellWithReuseIdentifier: LYWarriorsInterfaceCellID)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = UIColor.clear
        layout.minimumInteritemSpacing = insetsWidth
        layout.minimumLineSpacing = insetsWidth
        layout.itemSize = self.itemSize
        return view
    }()
    
    lazy var adscapeView: UIImageView={
        let view = UIImageView()
        view.backgroundColor = UIColor.cyan
        return view
    }()
    
    lazy var actionView: LYWarriorsActionView={
        let view = UINib.init(nibName: "LYWarriorsActionView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! LYWarriorsActionView
        view.clouse = { 
            NotificationCenter.default.post(name: NSNotification.Name.init(LYWarriorsUpdateRootNotif), object: LYWarriorsHomeSceneVC(), userInfo: nil)
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        coverView.backgroundColor = UIColor.clear
        coverView.addSubview(labView)
        coverView.addSubview(roleList)
        coverView.addSubview(adscapeView)
        coverView.addSubview(actionView)
        coverView.transform = CGAffineTransform.init(rotationAngle: -.pi/2)
        
        let offset = safeGaugeSize.0 > 20 ? safeGaugeSize.0-safeGaugeSize.1:0
        let offsetWidth = safeGaugeSize.0 > 20 ? -safeGaugeSize.0:0
        coverView.snp.makeConstraints { (make) in
            make.centerY.equalTo(showImageView).offset(offset)
            make.centerX.equalTo(showImageView)
            make.width.equalTo(showImageView.snp.height).offset(offsetWidth)
            make.height.equalTo(showImageView.snp.width)
        }
        labView.snp.makeConstraints { (make) in
            make.top.equalTo(coverView).offset(5)
            make.left.equalTo(coverView).offset(roleListLeftSize)
            make.right.equalTo(roleList)
            make.height.equalTo(50)
        }
        roleList.snp.makeConstraints { (make) in
            make.centerY.equalTo(coverView)
            make.width.equalTo((itemSize.width + insetsWidth) * count)
            make.left.equalTo(coverView).offset(roleListLeftSize)
            make.height.equalTo(itemSize.height)
        }
        actionView.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.right.left.equalTo(roleList)
            make.bottom.equalTo(coverView).offset(-5)
        }
        adscapeView.snp.makeConstraints { (make) in
            make.top.equalTo(coverView).offset(30)
            make.right.equalTo(coverView).offset(-5)
            make.width.equalTo(140)
            make.bottom.equalTo(coverView).offset(-30)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }
    
    private func loadData(){
        
    }
    
    deinit {
        print("人物选择释放")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension LYWarriorsChoosegRoleVC: UICollectionViewDataSource,UICollectionViewDelegate,SafeLayoutProtocol{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LYWarriorsInterfaceCellID, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let VC = LYWarriorsWorkDetailVC()
        //present(VC, animated: true, completion: nil)
    }
}
