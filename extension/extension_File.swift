//
//  extension_File.swift
//  20180612_TableviewWithUISearchbar
//
//  Created by chen hsin hung on 2018/7/29.
//  Copyright © 2018年 chen hsin hung. All rights reserved.
//

import UIKit

extension UIResponder {
    
    func next<T: UIResponder>(_ type: T.Type) -> T? {
        return next as? T ?? next?.next(type)
    }
}


extension UITableViewCell {
    
    var tableView: UITableView? {
        return next(UITableView.self)
    }
    
    var indexPath: IndexPath? {
        return tableView?.indexPath(for: self)
    }
}





