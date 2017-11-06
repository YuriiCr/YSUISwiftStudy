//
//  ArrayModelChange.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 27.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class ArrayModelChange {
    
    //MARK: Public Methods
    
    func changeTableView(_ tableView: UITableView) {
        self.changeTableViewWith(tableView, inSection: 0, rowAnimation: .automatic)
    }
    
    func changeTableViewWith(_ tableView: UITableView, inSection: Int ,rowAnimation: UITableViewRowAnimation) {
        
    }
}
