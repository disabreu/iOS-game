//
//  squares.swift
//  myGame
//
//  Created by Diana on 5/2/15.
//  Copyright (c) 2015 Diana. All rights reserved.
//

import Foundation
import UIKit

//initializes and stores the state of a given square!

class Square {
    
    let row:Int
    let col:Int
    
    var num = 0
    var color = UIColor()
    var isGood = false
    var isRevealed = false
    
    init(row:Int, col:Int) {
        
        //store the row and column of the square in the grid
        self.row = row
        self.col = col
    }
}