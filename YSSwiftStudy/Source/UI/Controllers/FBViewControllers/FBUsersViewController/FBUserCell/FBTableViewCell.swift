//
//  FBTableViewCell.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 09.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class FBTableViewCell: YSTableViewCell {

    // MARK: Public properties
    
    @IBOutlet var fullNameLabel: UILabel?
    @IBOutlet var userImageView: ImageView?
    
    var user: FBUser? {
        willSet { self.fill(with: newValue) }
    }
    
    // MARK: Public methods
    
    func fill(with user: FBUser?) {
        self.fullNameLabel?.text = user?.fullName
    }
    
    // MARK: Override methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.userImageView?.imageView?.image = nil
    }
    
}
