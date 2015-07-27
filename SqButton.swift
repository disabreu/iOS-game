//
//  SquareButton.swift
//  myGame
//
//  Created by Diana on 5/2/15.
//  Copyright (c) 2015 Diana. All rights reserved.
//

import Foundation
import UIKit


//that extends uibutton class. so I will be creating buttons i can tap on.
//we are really just going to attach them to existing squares
class SqButton : UIButton {
    

    let squareSize:CGFloat
    var square:Square
    
    //set size and position of the button based on the square model
    
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

   //  returns the value.
    
    func getLabelText() -> Int {

        return square.num
    }
    
    //tapping on the buttons returns a color
    
    func getLabelColor() -> UIColor{
        return square.color
    }
    
    

    
}