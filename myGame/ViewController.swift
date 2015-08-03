//
//  ViewController.swift
//  myGame
//
//  Created by Diana on 5/2/15.
//  Copyright (c) 2015 Diana. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


//the central controller of my application and will communicate the information from the model to the view
class ViewController: UIViewController{
    
    @IBOutlet weak var boardView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var gameDescription: UILabel!
    @IBAction func newGamePressed() {
        println("new game")
        timeLabel.hidden = true
        timer.invalidate()
        self.startNewGame()
    }

    @IBAction func backButton(sender: AnyObject) {
        
        timer.invalidate()
    }
   
    var intValue : Int = 3

    let image = UIImage(named: "apple.png") as UIImage!

    //set a board size
    let boardSize:Int = 4
    //create a board
    var board:Board
    //ARRAY DE BUTTONS
    var sqButtons:[SqButton] = []
    
    
    var timer:NSTimer!
    var timerid = 0
    var counter = 5
    var goodPicks = 0

    
    required init(coder aDecoder: NSCoder)
    {
       self.board = Board(size: boardSize)
        super.init(coder: aDecoder)
    }

    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        
        self.initializeBoard()

        var alertView = UIAlertView()
        alertView.message = "READY?"
        alertView.addButtonWithTitle("START PLAYING!!")
        alertView.show()
        alertView.delegate = self

    }

    //now that we have initialized the board we need to attach those buttons to the squares in the board
    
    func initializeBoard() {
        
        
        for row in 0 ..< board.size {
            for col in 0 ..< board.size {
                let square = board.squares[row][col]
                let squareSize:CGFloat = self.boardView.frame.width / CGFloat(boardSize)
                let sqButton = SqButton(squareModel: square, squareSize: squareSize);
                
                sqButton.setBackgroundImage(image, forState: .Normal)
                sqButton.layer.borderColor = UIColor.grayColor().CGColor
                sqButton.layer.borderWidth = 1
                sqButton.setTitleColor(UIColor(red: 222/255.0, green: 171/255.0, blue: 66/255.0, alpha: 1.0), forState: .Normal)
                
                sqButton.addTarget(self, action: "squareButtonPressed:", forControlEvents: .TouchUpInside)
                self.boardView.addSubview(sqButton)
                self.sqButtons.append(sqButton)
            }
        }
        
    }
    

    func alertView(View: UIAlertView!, clickedButtonAtIndex buttonIndex: Int) {
        //start new game when the alert is dismissed
        self.startNewGame()
    }
    
    func startNewGame() {
        
        //start new game
        counter = 5
        timerid = 0
        self.resetBoard()
    }
    
    //gets called for every game to reset the board
    
    func resetBoard() {
        
        //reset values per square
        self.board.resetBoard()
        
        //randomly chooses a game to play
        self.board.chooseGameRandomly()
        
        //sets the description
        gameDescription.text = self.board.descript
        
        //pass on number of picks that should be selected before winning
        goodPicks = self.board.goodOnes

        //will show values during 3 seconds.
        displaytemp();
        
        timeLabel.hidden = false
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: ("updateTimer"), userInfo: nil, repeats: true)
        
    }
    
    func updateTimer(){

        counter--
        timeLabel.text = "0:\(counter)"

        if(counter <= 0 && timerid == 0){
            timerid = 1
            counter = 10
            startplaying()

        }

        if(counter <= 0 && timerid == 1){
            timeLabel.hidden = true
            timer.invalidate()
            lose()
        }
    }
    
    //display real values for 3 seconds..
    func displaytemp(){
        
        for sqButton in self.sqButtons {
            sqButton.setTitle("\(sqButton.getLabelText())", forState: .Normal)
            sqButton.backgroundColor = sqButton.getLabelColor()
        }
    }
    
    //after 4 seconds we start playing! So we cover those values by changing the button's title
    func startplaying(){
        
        for sqButton in self.sqButtons {
            sqButton.setTitle("?", forState: .Normal)
            sqButton.setBackgroundImage(image, forState: .Normal)
            sqButton.layer.shadowColor = UIColor.darkGrayColor().CGColor
            sqButton.layer.shadowOpacity = 1.0
            
            sqButton.layer.borderWidth = 1
            sqButton.layer.shadowOffset = CGSizeMake(0, 1.0)
            sqButton.backgroundColor = UIColor.darkGrayColor()
            sqButton.setTitleColor(UIColor(red: 222/255.0, green: 171/255.0, blue: 66/255.0, alpha: 1.0), forState: .Normal)
            
        }
    }
    
    
    func squareButtonPressed(sender: SqButton) {
        
        //press to see value.
        if(!sender.square.isRevealed) {
            sender.square.isRevealed = true
            //audioPlayer.play()
            sender.setTitle("\(sender.getLabelText())", forState: .Normal)
            sender.backgroundColor = sender.getLabelColor()
            //sender.setTitle()
        }
        
        //if value wrong you lose
        if !sender.square.isGood {
            
            timeLabel.hidden = true
            self.lose()
        }
        
        //if value correct, let's continue!
        if sender.square.isGood {
            goodPicks--

            if(goodPicks == 0) {
                self.win()
            }
        
        }
    }
    

    func lose() {
        
        timer.invalidate()
        
        var alertView = UIAlertView()
        alertView.addButtonWithTitle("New Game")
        alertView.title = "HEY!!"
        
        if counter == 0 {
         alertView.message = "TIMEOUT!"
        } else {
        alertView.message = "You tapped on a wrong one!"
        }
        alertView.show()
        alertView.delegate = self

    }
    
    func win(){

        timeLabel.hidden = true
        timer.invalidate()
        var alertView = UIAlertView()
        alertView.addButtonWithTitle("Next Game")
        alertView.title = "CONGRATULATIONS!!"
        alertView.show()
        alertView.delegate = self
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

