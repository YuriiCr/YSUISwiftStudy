//
//  ArrayModelChangeInsert.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 27.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class ArrayModelChangeInsert: ArrayModelChange {
    var index: Int;
    
    init(index: Int ) {
        self.index = index
    }
    
    override func changeTableViewWith(_ tableView: UITableView, inSection: Int, rowAnimation: UITableViewRowAnimation) {
        let index = IndexPath.init(row: self.index, section: inSection)
        tableView.updateWithBlock {
            tableView.insertRows(at: [index], with: rowAnimation)
        }
    }

}
