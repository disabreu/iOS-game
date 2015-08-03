//
//  InitialViewController.swift
//  myGame
//
//  Created by Diana on 5/3/15.
//  Copyright (c) 2015 Diana. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    var level = ""
    var prueba = 0
    
//    @IBOutlet weak var image: UIImageView!
    
    @IBAction func Button(sender: UIButton) {
        
        level = sender.titleLabel!.text!
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender:
        AnyObject?) {
            if segue.identifier == "segue"{
                let vc = segue.destinationViewController as ViewController
                vc.intValue = prueba
            }
    }
    
    func gameSelection() -> Int{
        
        if(level == "LOW"){
            prueba = 6
        }
            
        else if(level == "MEDIUM"){
            prueba = 5
        }
            
        else {
            prueba = 3
        }
        return prueba
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
