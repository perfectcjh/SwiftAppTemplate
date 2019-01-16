//
//  BaseCollectionViewCell.swift
//  SwiftAppSample
//
//  Created by cjh on 2018/12/18.
//  Copyright © 2018 perfectcjh. All rights reserved.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    private func config() {
        backgroundColor = .white
    }
}

extension BaseCollectionViewCell {
    
    /// 纯代码cell获取
    static func classCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        let className = NSStringFromClass(self.classForCoder())
        collectionView.register(self.classForCoder(), forCellWithReuseIdentifier: className)
        return collectionView.dequeueReusableCell(withReuseIdentifier: className, for: indexPath)
    }
    
    /// xibcell获取
    static func xibCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        let className = NSStringFromClass(self.classForCoder())
        let nibName = className.components(separatedBy: ".").last
        let nib = UINib.init(nibName: nibName!, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: className)
        return collectionView.dequeueReusableCell(withReuseIdentifier: className, for: indexPath)
    }
    
}
