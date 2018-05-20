//
//  LYWarriorsRootMainVC.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/5/20.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsRootMainVC: UIViewController {
    let LYWarriorsInterfaceCellID = "LYWarriorsInterfaceCellID"
    
    lazy var professionList :UICollectionView={
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(UINib.init(nibName: "LYWarriorsInterfaceCell", bundle: nil), forCellWithReuseIdentifier: LYWarriorsInterfaceCellID)
        view.dataSource = self
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(professionList)
        
        //professionList
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension LYWarriorsRootMainVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LYWarriorsInterfaceCellID, for: indexPath)
        return cell
    }
}
