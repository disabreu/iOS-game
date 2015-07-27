//
//  SButton.swift
//  myGame
//
//  Created by Diana on 5/6/15.
//  Copyright (c) 2015 Diana. All rights reserved.
//

import Foundation
import UIKit


class SButton : UIButton {
    
    
    let squareSize:CGFloat
    var square:Square
    
    init(squareModel:Square, squareSize:CGFloat) {
        self.square = squareModel
        self.squareSize = squareSize
        
        let x = CGFloat(self.square.col) * (squareSize)
        let y = CGFloat(self.square.row) * (squareSize)
        let Frame = CGRectMake(x, y, squareSize, squareSize)
        
        super.init(frame: Frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // tapping on the buttons returns the value.
    
    func getLabelText() -> Int {
        
        return square.num
    }
    
    //tapping on the buttons returns a color
    
    func getLabelColor() -> UIColor{
        return square.color
    }
    
    
    
    
}
