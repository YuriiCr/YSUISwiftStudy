//
//  SquareViewController.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 24.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class SquareViewController: UIViewController {
    
    // MARK: Public Properties
    var squareView: SquareView? {
        if self.isViewLoaded && self.view.isKind(of: SquareView.self) {
            return self.view as? SquareView
        }
        
        return nil
    }
    
    //MARK: Public Methods
    
    @IBAction func move(_ sender: UIButton) -> () {
        self.squareView?.startPositionChange()
    }
    
    @IBAction func randomMove(_ sender: UIButton) -> () {
        self.squareView?.startRandomPositionChange()
    }
    
}
