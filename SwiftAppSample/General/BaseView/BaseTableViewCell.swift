//
//  BaseTableViewCell.swift
//  SwiftAppSample
//
//  Created by cjh on 2018/12/18.
//  Copyright © 2018 perfectcjh. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    static func getReuseIdentifier() -> String {
        return String(describing: self.classForCoder())
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    private func config() {
        selectionStyle = .none
        backgroundColor = .white
    }

}

extension BaseTableViewCell {
    
    /// 纯代码cell获取
    static func classCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let className = NSStringFromClass(self.classForCoder())
        tableView.register(self.classForCoder(), forCellReuseIdentifier: className)
        return tableView.dequeueReusableCell(withIdentifier: className, for: indexPath)
    }
    
    /// xibcell获取
    static func xibCell(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let className = NSStringFromClass(self.classForCoder())
        let nibName = className.components(separatedBy: ".").last
        let nib = UINib.init(nibName: nibName!, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: className)
        return tableView.dequeueReusableCell(withIdentifier: className, for: indexPath)
    }
    
}
