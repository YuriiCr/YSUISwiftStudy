//
//  UITableViewExtension.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 27.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

extension UITableView {
    
    func reusableCell<T>(with cls: T.Type, index: IndexPath) -> T {

        guard let cell = self.dequeueReusableCell(withIdentifier: toString(type: cls), for: index) as? T else { fatalError("not valid indetifier")}
        
        return cell
    }
    
    func updateWithBlock(_ block: () -> ()) {
        self.beginUpdates()
        block()
        self.endUpdates()
    }
    
    func updateTableViewWithModel(_ changeModel: ArrayModelChange) {
        changeModel.changeTableView(self)
    }
}
