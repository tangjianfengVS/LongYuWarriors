//
//  LYWarriorsDuelDetailVC.swift
//  LongYuWarriors//
//  Created by 汤建锋 on 2018/7/11.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsDuelDetailVC: UIViewController {
    @IBOutlet weak var topImageViewlayout: NSLayoutConstraint!
    @IBOutlet weak var bottomImageViewlayout: NSLayoutConstraint!
    
    private var safeGaugeSize: (CGFloat,CGFloat)=(0,0)
    private lazy var duelDetailVM = LYWarriorsDuelDetailVM()
    
    private var delegate: SafeLayoutProtocol?{
        didSet{
            delegate?.safeLayoutSize(top: topImageViewlayout, bottom: bottomImageViewlayout)
            safeGaugeSize = (delegate?.safeLayoutGaugeSize())!
            if safeGaugeSize.0 == 0 {
                safeGaugeSize.0 = 8
            }
            if safeGaugeSize.1 >= 34 {
                safeGaugeSize.1 = 28
            }
        }
    }
    
    private lazy var detailListVI: LYWarriorsDuelDetailListVI={
        let view = UINib.init(nibName: "LYWarriorsDuelDetailListVI", bundle: nil).instantiate(withOwner: nil, options: nil).first as! LYWarriorsDuelDetailListVI
        return view
    }()
    
    private lazy var actionVI: LYWarriorsDuelDetailFuncVI={
        let view = UINib.init(nibName: "LYWarriorsDuelDetailFuncVI", bundle: nil).instantiate(withOwner: nil, options: nil).first as! LYWarriorsDuelDetailFuncVI
        view.clousre = {[weak self] type in
            switch type {
            case .gameMate:
                self?.duelDetailVM.search(type: type, clousre: { (res, role) in
                    if res && role != nil{
                        let gameSceneVC = LYWarriorsGameSceneVC(roleDefiers: role!)
                        self?.delegate?.reighstCurrentVC(VC: gameSceneVC)
                        self?.present(gameSceneVC, animated: false, completion: nil)
                    }
                })
            default:
                break
            }
        }
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        setupUI()
    }
    
    private func setupUI(){
        view.addSubview(detailListVI)
        view.addSubview(actionVI)
        detailListVI.transform = CGAffineTransform.init(rotationAngle: -.pi/2)
        actionVI.transform = CGAffineTransform.init(rotationAngle: -.pi/2)
        
        let gapSize = (DuelDetailHeight-DuelDetailListWidth)/2
        let resSize = gapSize >= safeGaugeSize.1 ? gapSize-safeGaugeSize.1:-(gapSize-safeGaugeSize.1)
        
        detailListVI.snp.makeConstraints { (make) in
            make.bottom.equalTo(view).offset(resSize)
            make.width.equalTo(DuelDetailListWidth)
            make.centerX.equalTo(view)
            make.height.equalTo(DuelDetailHeight)
        }
        actionVI.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(safeGaugeSize.0-(DuelDetailHeight-DuelDetailWidth)/2)
            make.width.equalTo(DuelDetailWidth)
            make.centerX.equalTo(view)
            make.height.equalTo(DuelDetailHeight)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        get {
            return true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension LYWarriorsDuelDetailVC: SafeLayoutProtocol{
    
}
