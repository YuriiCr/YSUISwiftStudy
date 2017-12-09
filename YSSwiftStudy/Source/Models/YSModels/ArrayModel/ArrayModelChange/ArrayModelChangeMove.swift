//
//  ArrayModelChangeMove.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 27.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class ArrayModelChangeMove: ArrayModelChange {
    
    // MARK: Public Methods
    
    var index: Int
    var destinationIndex: Int
    
    // MARK: Initialization
    
    init(index: Int, destinationIndex: Int) {
        self.index = index
        self.destinationIndex = destinationIndex
    }
    
    // MARK: Public Methods
    
    override func changeTableViewWith(_ tableView: UITableView, inSection: Int, rowAnimation: UITableViewRowAnimation) {
        let index = IndexPath.init(row: self.index, section: inSection)
        let destinationIndex = IndexPath.init(row: self.destinationIndex, section: inSection)
        tableView.updateWithBlock {
            tableView.moveRow(at: index, to: destinationIndex)
        }
    }
}
