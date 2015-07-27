//
//  Board.swift
//  myGame
//
//  Created by Diana on 5/2/15.
//  Copyright (c) 2015 Diana. All rights reserved.
//

import Foundation
import UIKit

class Board {
    
    //collection of squares
    //2d array of square object models
    

    let size:Int
    
    var squares:[[Square]] = []
    var goodSquares:[Square] = []
    var descript = ""
    var goodOnes = 0
    var colorName = ""
    
    var colorsArray = [
        
        UIColor(red: 90/255.0, green: 187/255.0, blue: 181/255.0, alpha: 1.0), //teal color
        UIColor(red: 222/255.0, green: 171/255.0, blue: 66/255.0, alpha: 1.0), //yellow color
        UIColor(red: 223/255.0, green: 86/255.0, blue: 94/255.0, alpha: 1.0), //red color
        UIColor(red: 239/255.0, green: 130/255.0, blue: 100/255.0, alpha: 1.0), //orange color
        UIColor(red: 77/255.0, green: 75/255.0, blue: 82/255.0, alpha: 1.0), //dark color
        UIColor(red: 105/255.0, green: 94/255.0, blue: 133/255.0, alpha: 1.0), //purple color
        UIColor(red: 85/255.0, green: 176/255.0, blue: 112/255.0, alpha: 1.0), //green color
    ]
    
    var colorsNames = ["TEAL", "YELLOW", "RED", "ORANGE", "BLACK", " PURPLE", "GREEN"]
    
    //double for loop to init the grid of squares
    init(size:Int) {
        self.size = size
        
        for row in 0 ..< size {
            var squareRow:[Square] = []
            for col in 0 ..< size {
                let square = Square(row: row, col: col)
                squareRow.append(square)
            }
            squares.append(squareRow)
        }
    }
    
    //gives each square a VALUE (randomly)
    func addValue(square: Square) {
        square.num = randInRange(0...25)
    }
    
    //associate a UIColor to a square
    func addColor(square: Square) {
        square.color = randomColor()
    }

    //assign numbers and colors to the squares every time we start a game.
    func resetBoard() {

        for row in 0 ..< size {
            for col in 0 ..< size {
                squares[row][col].isRevealed = false
                squares[row][col].isGood = false
                //add value and color to each square of the 2d array RANDOMNLY for each time the method is called.
                self.addValue(squares[row][col])
                self.addColor(squares[row][col])
            }
        }
    }
    
    
    func getEven(){
        //goodSquares = []
        goodOnes = 0

            for row in 0 ..< size {
                for col in 0 ..< size {
                    var sq = squares[row][col]
            
            if sq.num % 2 == 0{
                //goodSquares.append(sq)
                sq.isGood = true
                goodOnes++
           }
         }
       }
      descript = "FIND EVEN NUMBERS"
    }
    
    func getOdd(){
        goodOnes = 0
      for row in 0 ..< size {
           for col in 0 ..< size {
            var sq = squares[row][col]
                
            if sq.num % 2 != 0{
                //goodSquares.append(sq)
                sq.isGood = true
                goodOnes++
            }
          }
        }
        
        descript = "FIND ODD NUMBERS"
      }

    func getMultiplesOf(){
        var multiple = randInRange(1...5)
        goodOnes = 0

        for row in 0 ..< size {
            for col in 0 ..< size {
                var sq = squares[row][col]
                
                if sq.num % multiple == 0{
                    //goodSquares.append(sq)
                    sq.isGood = true
                    goodOnes++
                }
            }
        }
        
        descript = "FIND MULTIPLES OF " + toString(multiple)
    }
    

    
    func getColor(){
        
        var colorin = randomColor()
        goodOnes = 0
        
        for row in 0 ..< size {
            for col in 0 ..< size {
                var sq = squares[row][col]

                if (sq.color == colorin){
                    
                    sq.isGood = true
                    goodOnes++
                
                }
                
            }
        }
        
        descript = "CHOOSE ALL THAT ARE " + colorName
    }
    
    func getNumbAndColor(){
        var number = randInRange(1...5)
        var colorin = randomColor()
        goodOnes = 0
        
        for row in 0 ..< size {
            for col in 0 ..< size {
                var sq = squares[row][col]
                
                if sq.num == number && sq.color == colorin{

                    sq.isGood = true
                    goodOnes++
                }
            }
        }
        descript = "FIND ALL " + colorName + "&" + String(number)
    
    }
    

    //game options. We want a random game to show up every time
    func chooseGameRandomly(){
    
        var random = randInRange(0...5)

        
        switch random {
            
        case 0:
            getNumbAndColor()
            
        case 1:
            getOdd()
            
        case 2:
            getMultiplesOf()
            
        case 3:
            getColor()
            
        case 4:
            getEven()
            
        default:
            getNumbAndColor()
            
        }
        
        if(goodOnes == 0) {
        chooseGameRandomly()
        }
    }
    
    
    func randomColor() -> UIColor {
        
        var randomNumber = randInRange(0...5)
        colorName = colorsNames[randomNumber]
        return colorsArray[randomNumber]
    }
    
    func randInRange(range: Range<Int>) -> Int {
        
        return  Int(arc4random_uniform(UInt32(range.endIndex - range.startIndex))) + range.startIndex
    }
    
    func getTileAtLocation(row : Int, col : Int) -> Square? {
        
        if row >= 0 && row < self.size && col >= 0 && col < self.size {
            return squares[row][col]
        } else {
            return nil
       }
    }
    
}

