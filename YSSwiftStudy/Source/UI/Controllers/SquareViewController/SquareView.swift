//
//  SquareView.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 24.10.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class SquareView: UIView {
    
    // Mark: public properties
    
    @IBOutlet var square: UIView?
    @IBOutlet var moveButton: UIButton?
    @IBOutlet var randomMove: UIButton?
    
    var position = 0
    
    let positionsCount:Int = 4
    
    enum SquarePosition:Int {
        case topLeft = 0
        case topRight
        case bottomRight
        case bottomLeft
    }
    
    private struct Constants {
        static let defaultDuration:TimeInterval = 1
        static let defaultDelation:TimeInterval = 0
    }
    
    // MARK: Public methods
    
    func setSquarePosition (_ position: Int, animated:Bool) {
        self.setSquarePosition(position, animated: true, completionHandler: nil)
    }
    
    func setSquarePosition (_ position: Int, animated:Bool, completionHandler:(() -> ())?) {
        UIView.animate(withDuration: animated ? Constants.defaultDuration : 0, delay: Constants.defaultDelation, options: .beginFromCurrentState, animations: {
            self.square?.center = self.squareCentrForPosition(position)!
        }) { (_) in
            if let completionHandler = completionHandler {
                completionHandler()
            }
            self.position = position
        }
    }
    
    // MARK: Private methods
    
    func squareCentrForPosition (_ position: Int) -> CGPoint? {
        if let square = self.square {
            var center = CGPoint(x:square.frame.size.width/2,y: square.frame.size.height/2)
            
            let rightX = self.bounds.size.width - square.frame.size.width/2
            let bottomY = self.bounds.size.height - square.frame.height/2
            switch position {
            case SquarePosition.topLeft.rawValue:
                break
            case SquarePosition.topRight.rawValue:
                center.x = rightX
            case SquarePosition.bottomRight.rawValue:
                center.x = rightX
                center.y = bottomY
                break
            case SquarePosition.bottomLeft.rawValue:
                center.y = bottomY
                break
                
            default:
                break
        }
             return center
    }
       return nil
    }
    
    func nextPosition() -> Int {
        return (self.position + 1) % positionsCount

    }
    
    func randomPosition() -> Int {
        let result = randomNumberTo(maxValue: positionsCount)
        
        return result == self.position ? randomPosition() : result
    }
    
    // MARK: Public methods
    
    func startPositionChange () -> () {
        self.setSquarePosition(self.nextPosition(), animated: true) {
            self.startPositionChange()
        }
    }
    
    func startRandomPositionChange () -> () {
        self.setSquarePosition(self.randomPosition(), animated: true) {
            self.startRandomPositionChange()
        }
    }
    
}
