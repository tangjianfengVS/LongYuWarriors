//
//  LYWarriorsHomeServiceVI.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/7/2.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

class LYWarriorsHomeServiceVI: UIView {
    @IBOutlet weak var areaView: UIView!
    @IBOutlet weak var serverView: UIView!
    @IBOutlet weak var areaLab: UILabel!
    @IBOutlet weak var serverLab: UILabel!
    @IBOutlet weak var bottomLayoutHeight: NSLayoutConstraint!
    
    private let RowBorder: CGFloat = 18
    private let marginRow: CGFloat = 22
    private let marginLine: CGFloat = 10
    private let count: CGFloat = 3
    private lazy var btnSize = CGSize(width: (ScreenWidth - ServiceViewMargin * 2 - RowBorder * 2 - marginRow * (count-1))/count,height: 30)
    
    private let SelectedColor = UIColor(red: 68/256.0, green: 213/256.0, blue: 237/256.0, alpha: 1)
    private var areaBtnList: [UIButton] = []
    private var areaSubBtnList: [UIButton] = []
    private var areaSelectedBtn: UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        areaView.alpha = 0.3
        serverView.alpha = 0.3
        setAreaUI()
        clickAreaBtn(btn: areaBtnList.first!)
    }
    
//    func update(type: LYWarriorsAreaServiceType) -> CGFloat {
//        return 300
//    }
    
    private func setAreaUI(){
        for (index,title) in AreaList.enumerated() {
            let btn = UIButton()
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            btn.setTitleColor(UIColor.white, for: .normal)
            btn.setTitleColor(SelectedColor, for: .selected)
            btn.setTitle(title, for: .normal)
            btn.layer.cornerRadius = 15
            btn.layer.masksToBounds = true
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.white.cgColor
            btn.addTarget(self, action: #selector(clickAreaBtn(btn:)), for: .touchUpInside)
            addSubview(btn)
            areaBtnList.append(btn)

            let line: CGFloat = CGFloat(index/Int(count))
            let row: CGFloat = CGFloat(index%Int(count))

            btn.snp.makeConstraints { (make) in
                make.size.equalTo(btnSize)
                make.top.equalTo(areaLab.snp.bottom).offset(marginLine + line * (marginLine + btnSize.height))
                make.left.equalTo(areaView).offset(RowBorder + row * (marginRow + btnSize.width))
            }
        }
    }
    
    private func updateAreaSubList(str: String){
        var lineValue: CGFloat = 0
        
        for (index,title) in AreaSubList.enumerated() {
            if index < areaSubBtnList.count{
                let btn = areaSubBtnList[index]
                btn.setTitle(title, for: .normal)
                let line: CGFloat = CGFloat(index/Int(count))
                lineValue = line
            }else{
                let btn = UIButton()
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                btn.setTitleColor(UIColor.white, for: .normal)
                btn.setTitleColor(SelectedColor, for: .selected)
                btn.setTitle(title, for: .normal)
                btn.layer.cornerRadius = 15
                btn.layer.masksToBounds = true
                btn.layer.borderWidth = 1
                btn.layer.borderColor = UIColor.white.cgColor
                btn.addTarget(self, action: #selector(clickAreaSubBtn(btn:)), for: .touchUpInside)
                self.addSubview(btn)
                areaSubBtnList.append(btn)
                
                let line: CGFloat = CGFloat(index/Int(count))
                let row: CGFloat = CGFloat(index%Int(count))
                lineValue = line
                btn.snp.makeConstraints { (make) in
                    make.size.equalTo(btnSize)
                    make.top.equalTo(serverLab.snp.bottom).offset(marginLine + line * (marginLine + btnSize.height))
                    make.left.equalTo(areaView).offset(RowBorder + row * (marginRow + btnSize.width))
                }
            }
        }
        
        if areaSubBtnList.count > 0{
            bottomLayoutHeight.constant = 45 + (lineValue + 1) * (marginLine + btnSize.height)
        }
    }
    
    @objc private func clickAreaBtn(btn: UIButton){
        areaSelectedBtn?.layer.borderColor = UIColor.white.cgColor
        btn.layer.borderColor = SelectedColor.cgColor
        areaSelectedBtn?.isSelected = false
        btn.isSelected = true
        areaSelectedBtn = btn
        updateAreaSubList(str: (btn.titleLabel?.text!)!)
    }
    
    @objc private func clickAreaSubBtn(btn: UIButton){
//        areaSelectedBtn?.layer.borderColor = UIColor.white.cgColor
//        btn.layer.borderColor = SelectedColor.cgColor
//        areaSelectedBtn?.isSelected = false
//        btn.isSelected = true
//        areaSelectedBtn = btn
//        updateAreaSubList(str: (btn.titleLabel?.text!)!)
    }
}
