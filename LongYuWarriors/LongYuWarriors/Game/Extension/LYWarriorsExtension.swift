//
//  LYWarriorsExtension.swift
//  LongYuWarriors
//
//  Created by 汤建锋 on 2018/6/10.
//  Copyright © 2018年 AllOverTheSkyStar. All rights reserved.
//

import UIKit

extension UIView{
    
    func circularBead(size: CGSize?, corner: UIRectCorner?) {
        var itmeSize = size
        var itmeCorner = corner
        if itmeSize == nil{
            itmeSize = CGSize(width: self.bounds.width/2, height: self.bounds.height/2)
        }
        if itmeCorner == nil{
            itmeCorner = .allCorners
        }
        let basePath = UIBezierPath(roundedRect: bounds, byRoundingCorners: itmeCorner!, cornerRadii: itmeSize!)
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame = bounds
        shapeLayer.path = basePath.cgPath
        layer.mask = shapeLayer
    }
}
