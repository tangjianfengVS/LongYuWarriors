//
//  LYWarriorsChoosegRoleVC.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/4.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsChoosegRoleVC: LYWarriorsBaseFuncVC {
    private let LYWarriorsInterfaceCellID = "LYWarriorsInterfaceCellID"
    private let count: CGFloat = 4
    private let insetsWidth: CGFloat = 8
    private let roleListLeftSize: CGFloat = 15
    private let itemSize: CGSize = CGSize(width: 112, height: 180)
    private let choosegRoleVM = LYWarriorsChoosegRoleVM()
    private var selectedIndex: IndexPath?
    
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var topLayout: NSLayoutConstraint!
    @IBOutlet weak var bottomLayout: NSLayoutConstraint!
    
    private var delegate: SafeLayoutProtocol?{
        didSet{
            delegate?.safeLayoutSize(top: topLayout, bottom: bottomLayout)
            delegate?.interfaceOrientations(type: .left)
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
        view.clouse = {[weak self] type in
            if type == .creatRoleType{
                self?.present(LYWarriorsCreatRoleVC(clousre: {
                    self?.loadData()
                }), animated: true, completion: nil)
            }else if type == .beginGameType{
                if self?.selectedIndex != nil{
                    let cell = self?.roleList.cellForItem(at: (self?.selectedIndex)!) as! LYWarriorsInterfaceCell
                    NotificationCenter.default.post(name: NSNotification.Name.init(LYWarriorsUpdateRootNotif), object: LYWarriorsHomeSceneVC(roleInterfaces: cell.roleInterface!), userInfo: nil)
                }
            }
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

        coverView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
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
        loadData()
    }
    
    private func loadData(){
        choosegRoleVM.searchRoleInterface()
        roleList.reloadData()
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
        return choosegRoleVM.roleInterfaceList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LYWarriorsInterfaceCellID, for: indexPath) as! LYWarriorsInterfaceCell
        cell.roleInterface = choosegRoleVM.roleInterfaceList[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndex != nil {
            let cellOld = collectionView.cellForItem(at: selectedIndex!) as! LYWarriorsInterfaceCell
            cellOld.layer.borderColor = UIColor.clear.cgColor
            cellOld.layer.borderWidth = 2
        }
        selectedIndex = indexPath
        let cell = collectionView.cellForItem(at: indexPath) as! LYWarriorsInterfaceCell
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.borderWidth = 2
    }
}
