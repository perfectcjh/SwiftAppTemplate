//
//  BaseScrollView.swift
//  SwiftAppSample
//
//  Created by cjh on 2018/12/18.
//  Copyright © 2018 perfectcjh. All rights reserved.
//

import UIKit

class BaseScrollView: UIScrollView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension UIScrollView: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if let cls = NSClassFromString("_FDFullscreenPopGestureRecognizerDelegate"), contentOffset.x <= 0 {
            if otherGestureRecognizer.delegate?.isKind(of: cls) == true {
                return true
            }
        }
        return false
    }
    
}
