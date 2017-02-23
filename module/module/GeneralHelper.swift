//
//  GeneralHelper.swift
//  housefun_buy
//
//  Created by Truck Liu on 2015/2/6.
//  Copyright (c) 2015年 Truck Liu. All rights reserved.
//

import Foundation
import UIKit

class GeneralHelper {
    class func getTextHeight(_ fontSize:CGFloat) -> CGFloat {
        let contentTextLabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        contentTextLabel.text = "測試"
        contentTextLabel.font = UIFont.systemFont(ofSize: fontSize)
        contentTextLabel.numberOfLines = 0
        contentTextLabel.sizeToFit()
        return contentTextLabel.bounds.height
    }
    
    class func getImageWithColor(_ color: UIColor, size: CGSize) -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    class func getEditBottomImage(_ color: CGColor, size: CGSize) -> UIImage? {
        // Setup our context
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        
        // Setup complete, do drawing here
        if (context != nil) {
            context?.setStrokeColor(color)
            context?.setLineWidth(1.0)
            context?.move(to: CGPoint(x: 0, y: 0))
            context?.addLine(to: CGPoint(x: 0, y: size.height))
            context?.addLine(to: CGPoint(x: size.width, y: size.height))
            context?.addLine(to: CGPoint(x: size.width, y: 0))
            context?.drawPath(using: CGPathDrawingMode.stroke)
        }
        
        // Drawing complete, retrieve the finished image and cleanup
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
