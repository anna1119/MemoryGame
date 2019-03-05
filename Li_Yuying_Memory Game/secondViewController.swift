//
//  secondViewController.swift
//  Li_Yuying_Memory Game
//
//  Created by Period One on 2017-11-20.
//  Copyright © 2017 Period One. All rights reserved.
//

import UIKit

class secondViewController: UIViewController {

    @IBOutlet weak var textField1: UITextField!
    
    @IBOutlet weak var textField2: UITextField!
    
    @IBOutlet weak var enter: UIButton!
   

    override func viewDidLoad() {
        
        super.viewDidLoad()
}
        // Do any additional setup after loading the view.


    @IBAction func enter(_ sender: Any) {
        //This function of this code is that when the user input two names, the user will be able to play game, otherwise the user will not be able to begin game.
        if textField1.text != "" && textField2.text != ""{
            performSegue(withIdentifier: "segue", sender: self)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let ViewController=segue.destination as! ViewController
        
        //These codes will pass data to another viewcontroller
        ViewController.playOneName=textField1.text!
        ViewController.playTwoName=textField2.text!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */


}
