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
        
        let cell = self.dequeueReusableCell(withIdentifier: toString(type: cls))
        
        let acell = self.dequeueReusableCell(withIdentifier: toString(type: cls), for: index)
        
        if cell == nil {
            return UINib.object(with: cls)!
        }
        
        return acell as! T
    }
    
    func updateWithBlock(_ block: () -> ()) {
        self.beginUpdates()
        block()
        self.endUpdates()
    }
    
    func updateTableViewWithModel(_ changeModel:ArrayModelChange) {
        changeModel.changeTableView(self)
    }
}
