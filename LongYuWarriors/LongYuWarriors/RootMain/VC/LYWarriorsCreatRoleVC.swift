//
//  LYWarriorsCreatRoleVC.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/20.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsCreatRoleVC: LYWarriorsBaseFuncVC {
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var showRoleImageView: UIImageView!
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var creatRoleBtn: UIButton!
    
    private let LYWarriorsCreatRoleCellID: String = "LYWarriorsCreatRoleCellID"
    private let CellSize = CGSize(width: 60, height: 100)
    private let callBack: (()->())!
    private var count: Int=0
    
    private lazy var professionalList: [LYWarriorsProfessionalType]={
        return LYWarriorsProfessionalType.allValues
    }()
    
    private lazy var creatRoleNameVI: UIView={
        let coverView = UIView(frame: self.view.bounds)
        let view = UINib.init(nibName: "LYWarriorsCreatRoleNameVI", bundle: nil).instantiate(withOwner: nil, options: nil).first as! LYWarriorsCreatRoleNameVI
        coverView.addSubview(view)
        
        view.snp.makeConstraints { (make) in
            make.center.equalTo(coverView)
            //make.top.equalTo(listView.snp.bottom)
            make.size.equalTo(CGSize(width: 270, height: 180))
        }
        coverView.backgroundColor = UIColor.clear
        return coverView
    }()
    
    private lazy var listView: UICollectionView={
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let nib = UINib(nibName: "LYWarriorsCreatRoleCell", bundle: nil)
        view.register(nib, forCellWithReuseIdentifier: LYWarriorsCreatRoleCellID)
        layout.itemSize = CellSize
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 6
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        view.backgroundColor = UIColor.clear
        view.dataSource = self
        return view
    }()
    
    private var delegate: SafeLayoutProtocol?{
        didSet{
            delegate?.reighstCurrentVC(VC: self)
        }
    }
    
    init(clousre: @escaping ()->()) {
        callBack = clousre
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        backBtn.layer.cornerRadius = backBtn.bounds.height/2
        backBtn.layer.masksToBounds = true
        backBtn.layer.borderColor = UIColor.gray.cgColor
        backBtn.layer.borderWidth = 0.8
        
        creatRoleBtn.layer.cornerRadius = backBtn.bounds.height/2
        creatRoleBtn.layer.masksToBounds = true
        creatRoleBtn.layer.borderColor = UIColor.blue.cgColor
        creatRoleBtn.layer.borderWidth = 0.8
        
        let value: CGFloat = (view.bounds.size.height - headerImageView.bounds.size.width - 38 + 6) / (CellSize.width + 6)
        count = Int(value)
        view.addSubview(listView)
        
        listView.snp.makeConstraints { (make) in
            make.height.equalTo(CellSize.height)
            make.top.equalTo(headerImageView)
            make.right.equalTo(view).offset(-15)
            make.left.equalTo(headerImageView.snp.right).offset(15)
        }
        showRoleImageView.snp.makeConstraints { (make) in
            make.left.equalTo(headerImageView)
            make.bottom.equalTo(view).offset(-8)
            make.top.equalTo(listView.snp.bottom)
            make.width.equalTo(showRoleImageView.snp.height)
        }
        coverView.snp.makeConstraints { (make) in
            make.right.equalTo(view).offset(-10)
            make.bottom.equalTo(creatRoleBtn.snp.top).offset(-8)
            make.top.equalTo(showRoleImageView)
            make.width.equalTo(coverView.snp.height)
        }
    }
    
    @IBAction func clickCreatRoleBtn(_ sender: UIButton) {
        view.addSubview(creatRoleNameVI)
    }
    
    @IBAction func clickBackBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension LYWarriorsCreatRoleVC: SafeLayoutProtocol,UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LYWarriorsCreatRoleCellID, for: indexPath) as! LYWarriorsCreatRoleCell
        
        if indexPath.row < professionalList.count {
            cell.professionalType = professionalList[indexPath.item]
        }else{
            cell.professionalType = nil
        }
        return cell
    }
}
