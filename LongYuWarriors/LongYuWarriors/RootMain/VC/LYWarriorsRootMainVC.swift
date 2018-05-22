//
//  LYWarriorsRootMainVC.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/5/20.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit
import SnapKit

class LYWarriorsRootMainVC: UIViewController {
    let LYWarriorsInterfaceCellID = "LYWarriorsInterfaceCellID"
    private let insetsWidth: CGFloat = 8
    
    private lazy var size: CGSize = {
        let count = 3
        let width = UIScreen.main.bounds.width - CGFloat(count + 1) * insetsWidth
        let height: CGFloat = 140
        return CGSize(width: width/CGFloat(count), height: height)
    }()
    
    lazy var professionList :UICollectionView={
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(UINib.init(nibName: "LYWarriorsInterfaceCell", bundle: nil), forCellWithReuseIdentifier: LYWarriorsInterfaceCellID)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = UIColor.white
        
        layout.minimumInteritemSpacing = insetsWidth
        layout.minimumLineSpacing = insetsWidth
        layout.itemSize = self.size
        layout.sectionInset = UIEdgeInsetsMake(0, insetsWidth, 0, insetsWidth)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(professionList)
        
        professionList.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension LYWarriorsRootMainVC: UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LYWarriorsInterfaceCellID, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let VC = LYWarriorsWorkDetailVC()
        present(VC, animated: true, completion: nil)
    }
}
