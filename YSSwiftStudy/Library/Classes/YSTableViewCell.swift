//
//  YSTableViewCell.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 09.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class YSTableViewCell: UITableViewCell {
    
    // MARK: Public properties
    
    override var reuseIdentifier: String {
    let className = String(describing: type(of: self))
        return className
    }
}
