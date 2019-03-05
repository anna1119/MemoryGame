//
//  ViewController.swift
//  Li_Yuying_Memory Game
//
//  Created by Period One on 2017-11-07.
//  Copyright © 2017 Period One. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var tries1=0
    var playOneSuccess=0
    var playTwoSuccess=0
    var regularSuccess=0
    @IBOutlet weak var playOneLabel1: UILabel!
    @IBOutlet weak var playTwoLabel2: UILabel!
    var playOneName=String()
    var playTwoName=String()
    @IBOutlet weak var order: UILabel!
    @IBOutlet weak var playOne: UITextField!
    @IBOutlet weak var playTwo: UITextField!
    @IBOutlet weak var playOneLabel: UILabel!
    @IBOutlet weak var playTwoLabel: UILabel!
    var playOneScore=0
    var playTwoScore=0
    @IBOutlet weak var tries: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var start: UIButton!
    @IBOutlet weak var timeScoreLabel: UILabel!
    @IBOutlet weak var successOne: UILabel!
    @IBOutlet weak var successTwo: UILabel!
    var scores=0
    //This variable is for regular model
    var value1=0
    var value2=0
    //These two variables are used to compare cards
    var playerOneScore=0 // This variable is for regular model
    var playerTwoScore=0 // This variable is for regular model
    var seconds=60 // This variable is for time model
    var times=Timer()
    var timescores = 390
    // This variable is used to represent the scores which player wins
    
    var mycard:[UIImage]=[#imageLiteral(resourceName: "apple"),#imageLiteral(resourceName: "orange"),#imageLiteral(resourceName: "cherry"),#imageLiteral(resourceName: "blue"),#imageLiteral(resourceName: "mixed"),#imageLiteral(resourceName: "happyFace"),#imageLiteral(resourceName: "allFruit"),#imageLiteral(resourceName: "tropicalFriuts"),#imageLiteral(resourceName: "apple"),#imageLiteral(resourceName: "orange"),#imageLiteral(resourceName: "cherry"),#imageLiteral(resourceName: "blue"),#imageLiteral(resourceName: "mixed"),#imageLiteral(resourceName: "happyFace"),#imageLiteral(resourceName: "allFruit"),#imageLiteral(resourceName: "tropicalFriuts")]
    // This array put all my cards.
    
    var playerName=["PlayerOne","PlayerTwo"]
    //This array will keep two names which are input in text field
    var newOrderPlayerName:[String] = []
    //This empty array will be used when computer shuffles players' name
    var newcard:[UIImage]=[]
    //This empty array will be used when shuffling cards
    
    //This func is used to shuffle players' name, so when in 1v1 model, the computer will show player's name randomly
    func shufflePlayerName() {
        var upperLimit1:UInt32=2
        //Because there are just two players' name, so the limit is 2
        var randomNumber:Int
        //This will represent a random integer between 1 and 2
        for _ in 1...2 {
            randomNumber=Int(arc4random_uniform(upperLimit1))
            //Random number will be 1 or 2
            newOrderPlayerName.append(playerName[randomNumber])
            //This code will add one player's name into new array
            playerName.remove(at: randomNumber)
            //This will remove this playerName from the first array
            upperLimit1 -= 1
            //Every time the computer removes one name from the first array, the limit will minus 1
        }
        order.text=newOrderPlayerName[0]
        //This code will make order textfield show player's name randomly to make sure that this is a fair game.
    }
    
    //This function will shuffle 16 cards
    func shuffle() {
        var upperLimit:UInt32=16
        //Because there are 16 cards in my card array, so the limit is 16
        var random:Int
        //This variable will be used to show a random number from 1 to 16
        for _ in 1...16{
            random=Int(arc4random_uniform(upperLimit))
            //random will represent a random number from 1 to 16
            newcard.append(mycard[random])
            //This code will add a card which is selected by computer randomly to a new array
            mycard.remove(at: random)
           //This code will remove the card which is selected by computer randomly from the original array
            upperLimit -= 1
             //Every time the computer removes one card from the first array, the limit will minus 1
        }
    }
    
    //This function is used to check if all cards have been matched correctly
    func check() {
        if card1.tag==2, card2.tag==2, card3.tag==2, card4.tag==2, card5.tag==2, card6.tag==2, card7.tag==2, card8.tag==2, card9.tag==2, card10.tag==2, card11.tag==2, card12.tag==2, card13.tag==2, card14.tag==2, card15.tag==2, card16.tag==2 {
          
            //When all cards are matched correctly, the player will be able to change method or begin a new game with the same model, and the will see give up button.
            change.isHidden=false
            newGame.isHidden=false
            giveUp.isHidden=true
        }
    }
   
    //This function will be used to compare just two particular cards
    func compareSingleCard(first:UIButton, second:UIButton) {
        //This switch statement will give different values to value1 depend on the image in the button
        switch first.currentImage! {
        case #imageLiteral(resourceName: "apple"):value1=1
        case #imageLiteral(resourceName: "orange"):value1=2
        case #imageLiteral(resourceName: "cherry"):value1=3
        case #imageLiteral(resourceName: "blue"):value1=4
        case #imageLiteral(resourceName: "mixed"):value1=5
        case #imageLiteral(resourceName: "allFruit"):value1=6
        case #imageLiteral(resourceName: "happyFace"):value1=7
        default:value1=8
        }
        //This switch statement will give different values to value2 depend on the image in the button
        switch second.currentImage! {
        case #imageLiteral(resourceName: "apple"):value2=1
        case #imageLiteral(resourceName: "orange"):value2=2
        case #imageLiteral(resourceName: "cherry"):value2=3
        case #imageLiteral(resourceName: "blue"):value2=4
        case #imageLiteral(resourceName: "mixed"):value2=5
        case #imageLiteral(resourceName: "allFruit"):value2=6
        case #imageLiteral(resourceName: "happyFace"):value2=7
        default:value2=8
        }
        tries.text="Tries:" + String(tries1)
        //this code will make tries label show the number of tries.
        score.text="Scores:" + String(scores)
        //This code will make score label show the result.
        playOne.text=String(playOneScore)
        //This will be used in 1v1 model, and shows playerone score
        playTwo.text=String(playTwoScore)
        //This will be used in 1v1 model, and shows playertwo score
        
        //This if statement will be executed when two cards are flipped.
        if first.tag==1 && second.tag==1 {
            
            //This if statement will be executed when in 1v1 model.
            
            //If the computer choose playone's name, this if statement will be executed
            if order.text==playOneName {
                
            //If the computer choose playone's name, and playerone matches cards sucessufully, this if statement will be executed
                if value1==value2 {
                    playOneSuccess += 1
                    // playone successive success will add 1
                    successOne.text="Success: " + String(playOneSuccess)
                    //This code will make successone label show playone successive successes.
                    
                    //This switch statement will make playone's scores be added different according to the number of successive successes.
                    switch playOneSuccess {
                    case 1: playOneScore += 1
                    case 2 : playOneScore += 2
                    case 3 : playOneScore += 3
                    case 4 : playOneScore += 4
                    case 5 : playOneScore += 5
                    case 6 : playOneScore += 6
                    case 7 : playOneScore += 7
                    case 8 : playOneScore += 8
                    case 9 : playOneScore += 9
                    default : playOneScore += 10
                    }
                    playOne.text=String(playOneScore)
                    //This code will make playOne label shows playone's scores.
                    order.text=playOneName
                    //This code will make order label still show the playerone's name if playerone matches cards successfully.
                   
                    first.tag=2
                    second.tag=2
                    //If two cards are clicked and they are the same, their tags will be changed to 2
                    
                }// If the computer choose playone's name but playone fails to match cards, this code will be executed
                else if value1 != value2{
                    order.text=playTwoName
                    //If the computer choose playone's name but playone fails to match cards, the content of order will be changed to playertwo's name.
                    first.tag=0
                    second.tag=0
                    //If the computer choose playone's name but playone fails to match cards, two cards' tag will be change to 0
                    playOneSuccess=0
                    //playone's successive success will be changed to 0
                    successOne.text="Success: " + String(playOneSuccess)
                    //This code will make successone label show playerone's successive success
                }
            }  //If the computer choose playtwo's name, this code will be executed
            else if  order.text==playTwoName {
                
                //If playertwo matches two cards successfully, this code will be exected.
            if value1 == value2 {
                playTwoSuccess += 1
                //If playertwo matches two cards successfully, playertwo's successive success will add 1
                successTwo.text="Success: " + String(playTwoSuccess)
                //this code will make successTwo label show playertwo's successive successes.
                
               //This switch statement will make playtwo's scores be added different according to the number of successive successes.
                switch playTwoSuccess {
                case 1: playTwoScore += 1
                case 2 : playTwoScore += 2
                case 3 : playTwoScore += 3
                case 4 : playTwoScore += 4
                case 5 : playTwoScore += 5
                case 6 : playTwoScore += 6
                case 7 : playTwoScore += 7
                case 8 : playTwoScore += 8
                case 9 : playTwoScore += 9
                default : playTwoScore += 10
                }
                playTwo.text=String(playTwoScore)
                //This will make playTwo label show playertwo's scores
                order.text=playTwoName
                //This code will make order label still show playertwo's name if playertwo matches cards successfully.
                first.tag=2
                 second.tag=2
                //If two cards are clicked and they are the same, their tags will be changed to 2
            
            } // If playertwo fail to match cards, this code will be executed
            else if value1 != value2 {
                first.tag=0
                second.tag=0
                //Two cards' tag will be changed to 0
                order.text=playOneName
                //Becaues playertwo fails to match cards, the content of order labal will be changed to playerone's name
                playTwoSuccess=0
                //This code will change playertwo's successive successes to 0
                successTwo.text="Success: " + String(playTwoSuccess)
                //This code will make successtwo label show playertwo's successive successes.
                
                }
                
                }
            
            //This code will make two labels show two players' name when in 1v1 model
            playOneLabel.text=playOneName + ":"
            playTwoLabel.text=playTwoName + ":"
          
            // Every time the player tries to match cards, the number of tries will add 1
            self.tries1 += 1
            
            //This if statement will be used to compare cards.
            
            //If two cards which ard clicked are the same, the next code will be executed.
            if value1==value2 {
                //This function will have 0.5 seconds'delay before executing code
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    first.setImage(#imageLiteral(resourceName: "download"), for: .normal)
                    second.setImage(#imageLiteral(resourceName: "download"), for: .normal)
                    first.tag=2
                    second.tag=2
                    //If the player matches two cards successfully, the iamges of two cards will be changed to an apple image and their tags will be changed to 2
                    self.check() //The content of this function will be shown after. This function will check if all cards have been matched.
                    first.isEnabled=false
                    second.isEnabled=false
                    //If two cards have been matched, they will not be able to touch.
                    
                    //This switch statement will be used to decide how many scores should be added according to the successive success in regular model.
                    
                    self.regularSuccess += 1
                    // every time the user gets a pair of pictures correct, they get 1 point and the regularsuccess will be added 1. If however, in the very next try, they get another pair right they get 2 points, and then 4 points and so on.
                    
                    //This switch statement will be used to decide how many scores should be added according to the successive successes.
                    switch self.regularSuccess {
                    case 1: self.scores += 1
                    case 2: self.scores += 2
                    case 3: self.scores += 4
                    case 4: self.scores += 8
                    case 5: self.scores += 16
                    case 6: self.scores += 32
                    case 7: self.scores += 64
                    case 8: self.scores += 128
                    case 9: self.scores += 256
                    default: self.scores += 512
                   
                    }
                    self.score.text="Scores:" + String(self.scores)
                    //This code will make score label show the user's scores.
                })
            }//If two cards which are clicked are not the same, the next code will be executed.
            else if value1 != value2 {
                regularSuccess = 0
              //If the user fails to match cards, the user's successive successes will be changed to 0
                score.text="Scores:" + String(scores)
                //This code will make score label show the user's scores.
               
             //This function will make the computer have 0.5 seconds' delay before executing the next code
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    first.setImage(#imageLiteral(resourceName: "tree"), for: .normal)
                    second.setImage(#imageLiteral(resourceName: "tree"), for: .normal)
                    //If the user fails to match two cards, two cards will flip back.
                    first.tag=0
                    second.tag=0
                    //If the user fails to match two cards, two cards' tag will change to 0
                })
                
                //This code will be executed if the user is playing time model
                //If the user fails to match cards in time model and the time is not equal to 0, this code will be executed.
            if timescores != 0 && time.isEnabled {
                //This functiom will make computer have 0.5 seconds' delay before executing code.
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                first.setImage(#imageLiteral(resourceName: "tree"), for: .normal)
                second.setImage(#imageLiteral(resourceName: "tree"), for: .normal)
                first.tag=0
                second.tag=0
                    //The same as above
                    })
                    
                }// If user is playing in 1v1 model, this code will be executed.
            else if vs.isEnabled {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                first.setImage(#imageLiteral(resourceName: "tree"), for: .normal)
                second.setImage(#imageLiteral(resourceName: "tree"), for: .normal)
                first.tag=0
                second.tag=0
                    //The same as above.
                    })                }
                
            }
           
          
        }
                }
    @IBOutlet weak var card1: UIButton!
    @IBOutlet weak var card2: UIButton!
    @IBOutlet weak var card3: UIButton!
    @IBOutlet weak var card4: UIButton!
    @IBOutlet weak var card5: UIButton!
    @IBOutlet weak var card6: UIButton!
    @IBOutlet weak var card7: UIButton!
    @IBOutlet weak var card8: UIButton!
    @IBOutlet weak var card9: UIButton!
    @IBOutlet weak var card10: UIButton!
    @IBOutlet weak var card11: UIButton!
    @IBOutlet weak var card12: UIButton!
    @IBOutlet weak var card13: UIButton!
    @IBOutlet weak var card14: UIButton!
    @IBOutlet weak var card16: UIButton!
    @IBOutlet weak var card15: UIButton!
    @IBOutlet weak var newGame: UIButton!
    @IBOutlet weak var giveUp: UIButton!
    @IBOutlet weak var regular: UIButton!
    @IBOutlet weak var time: UIButton!
    @IBOutlet weak var vs: UIButton!
    @IBOutlet weak var change: UIButton!
    @IBOutlet weak var rule: UIButton!
    @IBOutlet weak var exit: UIButton!
    
    @IBOutlet weak var image1: UIImageView!
    
    @IBOutlet weak var image2: UIImageView!
    
    @IBOutlet weak var image3: UIImageView!
    
    // This function will be used in new game button or the user choose to change model. The computer will make all cards show the same background
    func updateCards(_ card:UIButton)  {
        card.setImage(#imageLiteral(resourceName: "tree"), for: .normal)
    }
    
    // This function will update all cards, and it will be used in new game button.
    func updateAll() {
        updateCards(card1)
        updateCards(card2)
        updateCards(card3)
        updateCards(card4)
        updateCards(card5)
        updateCards(card6)
        updateCards(card7)
        updateCards(card8)
        updateCards(card9)
        updateCards(card10)
        updateCards(card11)
        updateCards(card12)
        updateCards(card13)
        updateCards(card14)
        updateCards(card15)
        updateCards(card16)
        
    }
    
    //This function will be used to compare all cards.
    func compareAll() {
        compareSingleCard(first: card1, second: card2)
        compareSingleCard(first: card1, second: card3)
        compareSingleCard(first: card1, second: card4)
        compareSingleCard(first: card1, second: card5)
        compareSingleCard(first: card1, second: card6)
        compareSingleCard(first: card1, second: card7 )
        compareSingleCard(first: card1, second: card8)
        compareSingleCard(first: card1, second: card9)
        compareSingleCard(first: card1, second: card10)
        compareSingleCard(first: card1, second: card11)
        compareSingleCard(first: card1, second: card12)
        compareSingleCard(first: card1, second: card13)
        compareSingleCard(first: card1, second: card14)
        compareSingleCard(first: card1, second: card15)
        compareSingleCard(first: card1, second: card16)
        compareSingleCard(first: card2, second: card3)
        compareSingleCard(first: card2, second: card4)
        compareSingleCard(first: card2, second: card5)
        compareSingleCard(first: card2, second: card6)
        compareSingleCard(first: card2, second: card7)
        compareSingleCard(first: card2, second: card8)
        compareSingleCard(first: card2, second: card9)
        compareSingleCard(first: card2, second: card10)
        compareSingleCard(first: card2, second: card11)
        compareSingleCard(first: card2, second: card12)
        compareSingleCard(first: card2, second: card13)
        compareSingleCard(first: card2, second: card14)
        compareSingleCard(first: card2, second: card15)
        compareSingleCard(first: card2, second: card16)
        compareSingleCard(first: card3, second: card4)
        compareSingleCard(first: card3, second: card5)
        compareSingleCard(first: card3, second: card6)
        compareSingleCard(first: card3, second: card7)
        compareSingleCard(first: card3, second: card8)
        compareSingleCard(first: card3, second: card9)
        compareSingleCard(first: card3, second: card10)
        compareSingleCard(first: card3, second: card11)
        compareSingleCard(first: card3, second: card12)
        compareSingleCard(first: card3, second: card13)
        compareSingleCard(first: card3, second: card14)
        compareSingleCard(first: card3, second: card15)
        compareSingleCard(first: card3, second: card16)
        compareSingleCard(first: card4, second: card5)
        compareSingleCard(first: card4, second: card6)
        compareSingleCard(first: card4, second: card7)
        compareSingleCard(first: card4, second: card8)
        compareSingleCard(first: card4, second: card9)
        compareSingleCard(first: card4, second: card10)
        compareSingleCard(first: card4, second: card11)
        compareSingleCard(first: card4, second: card12)
        compareSingleCard(first: card4, second: card13)
        compareSingleCard(first: card4, second: card14)
        compareSingleCard(first: card4, second: card15)
        compareSingleCard(first: card4, second: card16)
        compareSingleCard(first: card5, second: card6)
        compareSingleCard(first: card5, second: card7)
        compareSingleCard(first: card5, second: card8)
        compareSingleCard(first: card5, second: card9)
        compareSingleCard(first: card5, second: card10)
        compareSingleCard(first: card5, second: card11)
        compareSingleCard(first: card5, second: card12)
        compareSingleCard(first: card5, second: card13)
        compareSingleCard(first: card5, second: card14)
        compareSingleCard(first: card5, second: card15)
        compareSingleCard(first: card5, second: card16)
        compareSingleCard(first: card6, second: card7)
        compareSingleCard(first: card6, second: card8)
        compareSingleCard(first: card6, second: card9)
        compareSingleCard(first: card6, second: card10)
        compareSingleCard(first: card6, second: card11)
        compareSingleCard(first: card6, second: card12)
        compareSingleCard(first: card6, second: card13)
        compareSingleCard(first: card6, second: card14)
        compareSingleCard(first: card6, second: card15)
        compareSingleCard(first: card6, second: card16)
        compareSingleCard(first: card7, second: card8)
        compareSingleCard(first: card7, second: card9)
        compareSingleCard(first: card7, second: card10)
        compareSingleCard(first: card7, second: card11)
        compareSingleCard(first: card7, second: card12)
        compareSingleCard(first: card7, second: card13)
        compareSingleCard(first: card7, second: card14)
        compareSingleCard(first: card7, second: card15)
        compareSingleCard(first: card7, second: card16)
        compareSingleCard(first: card8, second: card9)
        compareSingleCard(first: card8, second: card10)
        compareSingleCard(first: card8, second: card11)
        compareSingleCard(first: card8, second: card12)
        compareSingleCard(first: card8, second: card13)
        compareSingleCard(first: card8, second: card14)
        compareSingleCard(first: card8, second: card15)
        compareSingleCard(first: card8, second: card16)
        compareSingleCard(first: card9, second: card10)
        compareSingleCard(first: card9, second: card11)
        compareSingleCard(first: card9, second: card12)
        compareSingleCard(first: card9, second: card13)
        compareSingleCard(first: card9, second: card14)
        compareSingleCard(first: card9, second: card15)
        compareSingleCard(first: card9, second: card16)
        compareSingleCard(first: card10, second: card11)
        compareSingleCard(first: card10, second: card12)
        compareSingleCard(first: card10, second: card13)
        compareSingleCard(first: card10, second: card14)
        compareSingleCard(first: card10, second: card15)
        compareSingleCard(first: card10, second: card16)
        compareSingleCard(first: card11, second: card12)
        compareSingleCard(first: card11, second: card13)
        compareSingleCard(first: card11, second: card14)
        compareSingleCard(first: card11, second: card15)
        compareSingleCard(first: card11, second: card16)
        compareSingleCard(first: card12, second: card13)
        compareSingleCard(first: card12, second: card14)
        compareSingleCard(first: card12, second: card15)
        compareSingleCard(first: card12, second: card16)
        compareSingleCard(first: card13, second: card14)
        compareSingleCard(first: card13, second: card15)
        compareSingleCard(first: card13, second: card16)
        compareSingleCard(first: card14, second: card15)
        compareSingleCard(first: card14, second: card16)
        compareSingleCard(first: card15, second: card16)
       
    }
    
    //This function will reveal all cards, and this function will be used in give up function.
    func revealAll() {
        card1.setImage(newcard[0], for: .normal)
        card2.setImage(newcard[1], for: .normal)
        card3.setImage(newcard[2], for: .normal)
        card4.setImage(newcard[3], for: .normal)
        card5.setImage(newcard[4], for: .normal)
        card6.setImage(newcard[5], for: .normal)
        card7.setImage(newcard[6], for: .normal)
        card8.setImage(newcard[7], for: .normal)
        card9.setImage(newcard[8], for: .normal)
        card10.setImage(newcard[9], for: .normal)
        card11.setImage(newcard[10], for: .normal)
        card12.setImage(newcard[11], for: .normal)
        card13.setImage(newcard[12], for: .normal)
        card14.setImage(newcard[13], for: .normal)
        card15.setImage(newcard[14], for: .normal)
        card16.setImage(newcard[15], for: .normal)
    }
    
    //This code will make buttons enable
    func cardEnable() {
        card1.isEnabled=true
        card2.isEnabled=true
        card3.isEnabled=true
        card4.isEnabled=true
        card5.isEnabled=true
        card6.isEnabled=true
        card7.isEnabled=true
        card8.isEnabled=true
        card9.isEnabled=true
        card10.isEnabled=true
        card11.isEnabled=true
        card12.isEnabled=true
        card13.isEnabled=true
        card14.isEnabled=true
        card15.isEnabled=true
        card16.isEnabled=true
    }
    
    //This code will make buttons unable.
    func cardUnable() {
        card1.isEnabled=false
        card2.isEnabled=false
        card3.isEnabled=false
        card4.isEnabled=false
        card5.isEnabled=false
        card6.isEnabled=false
        card7.isEnabled=false
        card8.isEnabled=false
        card9.isEnabled=false
        card10.isEnabled=false
        card11.isEnabled=false
        card12.isEnabled=false
        card13.isEnabled=false
        card14.isEnabled=false
        card15.isEnabled=false
        card16.isEnabled=false    }
    
    override func viewDidLoad() {
        //The followin code will make all labels show the corresponding content
        playOneLabel1.text="Playone: " + playOneName
        playTwoLabel2.text="Playtwo: " + playTwoName
        playOneLabel.text=playOneName
        playTwoLabel.text=playTwoName
        playOne.text=String(playOneScore)
        playTwo.text=String(playTwoScore)
        successOne.text="Success: " + String(playOneSuccess)
        successTwo.text="Success: " + String(playTwoSuccess)
        timeLabel.text=String(seconds)
        timeScoreLabel.text="Scores: " + String(timescores)
         score.text="Scores:" + String(scores)
        super.viewDidLoad()
        cardUnable() //This will make all cards unable initially
     
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    @IBAction func giveUp(_ sender: Any) {
        revealAll()
        //When user clicks give up, the computer will reveal all cards.
        times.invalidate()
        //If player is playing in time model, when player clicks give up, time will stop counting down
        timeLabel.text=String(seconds)
        //This will make one label show seconds
        change.isHidden=false
        //when user clicks give up button, user will see change method button
        newGame.isHidden=false
        //when user clicks give up button, user will see new game button
        cardUnable()
        //when the user click give up button, the user will not able to flip cards
        giveUp.isHidden=true
        //when the user click give up button, it will hide
    }
    
    @IBAction func change(_ sender: Any) {
        regular.isEnabled=true
        //when user clicks change mmodel button, the user will be able to click regular model button.
        time.isEnabled=true
        //when user clicks change mmodel button, the user will be able to click time model button.
        vs.isEnabled=true
        //when user clicks change mmodel button, the user will be able to 1v1 model button.
        
        //when user click change model button, all labels will be hidden
        tries.isHidden=true
        score.isHidden=true
        timeLabel.isHidden=true
        start.isHidden=true
        regular.isHidden=false
        time.isHidden=false
        vs.isHidden=false
       //When the user clicks change model button, all cards will flip back.
        updateAll()
        //When the user clicks change model button, all cards will not be able to touch
        cardUnable()
        
        //When the user clicks change model button, the computer will hide all labels, newgame button, change model button and give up button
        change.isHidden=true
        newGame.isHidden=true
        timeScoreLabel.isHidden=true
        successOne.isHidden=true
        successTwo.isHidden=true
        order.isHidden=true
        playOne.isHidden=true
        playTwo.isHidden=true
        playOneLabel.isHidden=true
        playTwoLabel.isHidden=true
        giveUp.isHidden=true
        
        //when the user choose to change model, the user will be able to see rule and also can exit
        rule.isHidden=false
        exit.isHidden=false
        
        //when the user chooses to give up, three images will show.
        
        image1.isHidden=false
        image2.isHidden=false
        image3.isHidden=false
        
        //when user chooses to give up, the user will see their names
        playOneLabel1.isHidden=false
        playTwoLabel2.isHidden=false
    }
    @IBAction func newGame(_ sender: Any) {
        regular.isHidden=true
        time.isHidden=true
        vs.isHidden=true
        updateAll()
        //when the user clicks newGame button, all cards will show the same background.
        newcard.removeAll()
        //This code will remove all cards in newcard array
       mycard=[#imageLiteral(resourceName: "apple"),#imageLiteral(resourceName: "orange"),#imageLiteral(resourceName: "cherry"),#imageLiteral(resourceName: "blue"),#imageLiteral(resourceName: "mixed"),#imageLiteral(resourceName: "happyFace"),#imageLiteral(resourceName: "allFruit"),#imageLiteral(resourceName: "tropicalFriuts"),#imageLiteral(resourceName: "apple"),#imageLiteral(resourceName: "orange"),#imageLiteral(resourceName: "cherry"),#imageLiteral(resourceName: "blue"),#imageLiteral(resourceName: "mixed"),#imageLiteral(resourceName: "happyFace"),#imageLiteral(resourceName: "allFruit"),#imageLiteral(resourceName: "tropicalFriuts")]
        //this code will make the first array be full of cards again.
        
        shuffle()
        //this function will shuffle cards.
        
        //when the user click new game button, everything will reset
        tries1=0
        //the tries will equal to 0
        tries.text="Tries:" + String(tries1)
        score.text="Scores:" + String(scores)
        //tries and score label in regular model will show 0
        playerName=[playOneName,playTwoName]
        shufflePlayerName()
        //The computer will shuffle players' name and pick one
        playOneScore=0
        playerTwoScore=0
        playOneSuccess=0
        playTwoSuccess=0
        //All scores in different model will equal to 0
        seconds=60
        //the user will have 60 seconds again
        times.invalidate()
        //when the user click new game button, the time will not begin to count down.Just when the user click start button, the time will begin to count down
        timeLabel.text=String(seconds)
        //this code will make time label show seconds
        start.isEnabled=true
        //when the user clicks the new game button, the user will be able to click start button.
        timescores=390
        //The scores in time model reset to 390
        timeScoreLabel.text="Scores:" + String(timescores)
        //This code will make scores label in time model show scores
        
        //the function of this if statement is that when player plays in time medel, when the player clicks new game button, the player will not be able to click cards, but when the player plays in other medels, when the player clicks new game button, the player will be able to flip button instantly
        if start.isHidden==true {
            cardEnable()
        } else if seconds==60 {
            cardUnable()
        }
        newGame.isHidden=true
        //when the user clicks new game button, the computer will hide new game button.
        change.isHidden=true
        //when the user clicks new game button, the computer will hide change model button.
       
        //when the user plays in time medel, when the user clicks new game button, the user will not see give up button, but in other models, the user will see.
        if time.isEnabled {
            giveUp.isHidden=true
        } else {
            giveUp.isHidden=false
        }
    }
    
    @IBAction func regular(_ sender: Any) {
        
        mycard=[#imageLiteral(resourceName: "apple"),#imageLiteral(resourceName: "orange"),#imageLiteral(resourceName: "cherry"),#imageLiteral(resourceName: "blue"),#imageLiteral(resourceName: "mixed"),#imageLiteral(resourceName: "happyFace"),#imageLiteral(resourceName: "allFruit"),#imageLiteral(resourceName: "tropicalFriuts"),#imageLiteral(resourceName: "apple"),#imageLiteral(resourceName: "orange"),#imageLiteral(resourceName: "cherry"),#imageLiteral(resourceName: "blue"),#imageLiteral(resourceName: "mixed"),#imageLiteral(resourceName: "happyFace"),#imageLiteral(resourceName: "allFruit"),#imageLiteral(resourceName: "tropicalFriuts")]
        shuffle()
        //when the user clicks regular button, the computer will shuffle cards.
        
        //the following codes will make just tries label,scores label,and two players'names show when the user plays in regular model.
        playOneLabel1.isHidden=false
        playTwoLabel2.isHidden=false
        time.isEnabled=false
        vs.isEnabled=false
        tries.isHidden=false
        score.isHidden=false
        order.isHidden=true
        playOne.isHidden=true
        playTwo.isHidden=true
        playOneLabel.isHidden=true
        playTwoLabel.isHidden=true
        timeLabel.isHidden=true
        start.isHidden=true
        timeScoreLabel.isHidden=true
        regular.isHidden=true
        time.isHidden=true
        vs.isHidden=true
        
        //The function of the following codes is that when the user first begin to play the game, the user will not see change model button and newGame button, the user just can see give up button. And when the user clicks regular button, the user will be able to click cards, otherwise the user cannot click cards.
        change.isHidden=true
        newGame.isHidden=true
        giveUp.isHidden=false
        cardEnable()
        rule.isHidden=true
        exit.isHidden=true
        
        //when the user chooses regular model, the user will not be able to see three images
        image1.isHidden=true
        image2.isHidden=true
        image3.isHidden=true
    }
    
    @IBAction func time(_ sender: Any) {
        //The function of the following codes is that when player plays in time model, the computer will just show time label, timescore label,start button and two players' names
        regular.isEnabled=false
        vs.isEnabled=false
        order.isHidden=true
        playOneLabel.isHidden=true
        playTwoLabel.isHidden=true
        playOne.isHidden=true
        playTwo.isHidden=true
        timeLabel.isHidden=false
        start.isHidden=false
        regular.isHidden=true
        time.isHidden=true
        vs.isHidden=true
        mycard=[#imageLiteral(resourceName: "apple"),#imageLiteral(resourceName: "orange"),#imageLiteral(resourceName: "cherry"),#imageLiteral(resourceName: "blue"),#imageLiteral(resourceName: "mixed"),#imageLiteral(resourceName: "happyFace"),#imageLiteral(resourceName: "allFruit"),#imageLiteral(resourceName: "tropicalFriuts"),#imageLiteral(resourceName: "apple"),#imageLiteral(resourceName: "orange"),#imageLiteral(resourceName: "cherry"),#imageLiteral(resourceName: "blue"),#imageLiteral(resourceName: "mixed"),#imageLiteral(resourceName: "happyFace"),#imageLiteral(resourceName: "allFruit"),#imageLiteral(resourceName: "tropicalFriuts")]
        shuffle()
        //when the user clicks time button, the computer will shuffle cards
        
        timeScoreLabel.isHidden=false
        cardUnable() //when the user clicks time button, the user will not be able to flip cards until the user clicks start button
        
        playOneLabel1.isHidden=false
        playTwoLabel2.isHidden=false
        seconds=60 //when the user clicks time button, the seconds will be 60
        timeLabel.text=String(seconds)//This code will make timelabel show seconds
        start.isEnabled=true
        //when the user clicks time button, the user will be able to click start button
        timescores=390
        //This will make the user's scores equal to 390 initially
        timeScoreLabel.text="Scores: " + String(timescores)
        //this will make score label show the scores
        
        
        //when the user clicks time button, the user will just see scores,seconds,start button and two players' name.
        change.isHidden=true
        newGame.isHidden=true
        giveUp.isHidden=true
        rule.isHidden=true
        exit.isHidden=true
        
         //when the user chooses regular model, the user will not be able to see three images
        image1.isHidden=true
        image2.isHidden=true
        image3.isHidden=true
        
    }
    
    @IBAction func start(_ sender: Any) {
         times=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.counter), userInfo: nil, repeats: true)
        //This function will be used to count down time
        
         start.isEnabled=false
        //when the user clicks start button, the start button will not be able to click
        cardEnable()
        //when clicking start button, the user will be able to flip cards, otherwise, the user cannot flip cards
        giveUp.isHidden=false
        //when the time begins to count down, the users will be able to give up
        
    }
    //This function will be used to count donw time
    @objc func counter() {
        seconds -= 1
        timeLabel.text=String(seconds)
        
        //This switch statement will build up a score system which minus different scores according to the seconds left.
        switch seconds {
        case 55...60 : timescores -= 1
        case 50...54 : timescores -= 2
        case 45...49 : timescores -= 3
        case 40...44 : timescores -= 4
        case 35...39 : timescores -= 5
        case 30...34 : timescores -= 6
        case 25...29 : timescores -= 7
        case 20...24 : timescores -= 8
        case 15...19 : timescores -= 9
        case 10...14 : timescores -= 10
        case 5...9 : timescores -= 11
        case 1...4 : timescores -= 12
        default : timescores = 0
        revealAll()
        cardUnable()
          //if the time equal to 0, the computer will reveal all cards and the user will not be able to click cards
        }
        
        //If seconds equal to 0, time will stop counting down and the computer will reveal all cards and the user will be able to change model or begins a new game in the same model
        if seconds==0 {
            times.invalidate()
            revealAll()
            change.isHidden=false
            newGame.isHidden=false
            
        }
        if card1.tag==2, card2.tag==2, card3.tag==2, card4.tag==2, card5.tag==2, card6.tag==2, card7.tag==2, card8.tag==2, card9.tag==2, card10.tag==2, card11.tag==2, card12.tag==2, card13.tag==2, card14.tag==2, card15.tag==2, card16.tag==2 {
            //if the user matches all cards successfully before time equal to 0, the time will stop counting down
            times.invalidate()
        }
       
        timeScoreLabel.text="Scores: " + String(timescores)
        //this code will make timescorelabel show the user's scores
    }
    
    @IBAction func vs(_ sender: Any) {
        mycard=[#imageLiteral(resourceName: "apple"),#imageLiteral(resourceName: "orange"),#imageLiteral(resourceName: "cherry"),#imageLiteral(resourceName: "blue"),#imageLiteral(resourceName: "mixed"),#imageLiteral(resourceName: "happyFace"),#imageLiteral(resourceName: "allFruit"),#imageLiteral(resourceName: "tropicalFriuts"),#imageLiteral(resourceName: "apple"),#imageLiteral(resourceName: "orange"),#imageLiteral(resourceName: "cherry"),#imageLiteral(resourceName: "blue"),#imageLiteral(resourceName: "mixed"),#imageLiteral(resourceName: "happyFace"),#imageLiteral(resourceName: "allFruit"),#imageLiteral(resourceName: "tropicalFriuts")]
        shuffle()
        //when the user clicks vs button, the computer will shuffle cards
         playerName=[playOneName,playTwoName]
        shufflePlayerName()
        //when the user clicks vs button, the computer will shuffle players' names which are input in textfield
        
        //the function of the following codes is that when the players choose to play 1v1 model, two players will just see the label which show their turn, their name and corresponding scores and their corresponding successive success
        timeScoreLabel.isHidden=true
        regular.isEnabled=false
        time.isEnabled=false
        tries.isHidden=true
        score.isHidden=true
        order.isHidden=false
        playOneLabel.isHidden=false
        playTwoLabel.isHidden=false
        playOne.isHidden=false
        playTwo.isHidden=false
        
        cardEnable() //when the user clicks 1v1 button, they will be able to click cards
        
        playOneLabel1.isHidden=true
        playTwoLabel2.isHidden=true
        successOne.isHidden=false
        successTwo.isHidden=false
        change.isHidden=true
        newGame.isHidden=true
        giveUp.isHidden=false
        regular.isHidden=true
        time.isHidden=true
        vs.isHidden=true
        rule.isHidden=true
        exit.isHidden=true
        
         //when the user chooses regular model, the user will not be able to see three images
        image1.isHidden=true
        image2.isHidden=true
        image3.isHidden=true
    }
    
    @IBAction func card1(_ sender: Any) {
      card1.setImage(newcard[0], for: .normal)
    //this code will make card1 show the first card in new cards array
       card1.tag=1
    //when the user clicks card1, the card1's tag will become 1
       compareAll()
      //If the user clicks two cards and one of them is card1, it will begin to compare
    }
    
    @IBAction func card2(_ sender: Any) {
        card2.setImage(newcard[1], for: .normal)
        //this code will make card2 show the second card in new cards array
        card2.tag=1
        //when the user clicks card2, the card2's tag will become 1
        compareAll()
       //If the user clicks two cards and one of them is card2, it will begin to compare
           }
    
    @IBAction func card3(_ sender: Any) {
        card3.setImage(newcard[2], for: .normal)
        //this code will make card3 show the third card in new cards array
        card3.tag=1
        //when the user clicks card3, the card3's tag will become 1
        compareAll()
        //If the user clicks two cards and one of them is card3, it will begin to compare
    }
    @IBAction func card4(_ sender: Any) {
        card4.setImage(newcard[3], for: .normal)
        //this code will make card4 show the forth card in new cards array
        card4.tag=1
        //when the user clicks card4, the card4's tag will become 1
        compareAll()
        //If the user clicks two cards and one of them is card4, it will begin to compare
        
    }
    
    @IBAction func card5(_ sender: Any) {
        card5.setImage(newcard[4], for: .normal)
        //this code will make card5 show the fifth card in new cards array
        card5.tag=1
        //when the user clicks card5, the card5's tag will become 1
        compareAll()
        //If the user clicks two cards and one of them is card5, it will begin to compare
    }
    
    @IBAction func card6(_ sender: Any) {
        card6.setImage(newcard[5], for: .normal)
        //this code will make card6 show the sixth card in new cards array
        card6.tag=1
        //when the user clicks card6, the card6's tag will become 1
        compareAll()
        //If the user clicks two cards and one of them is card6, it will begin to compare
    }
    
    @IBAction func card7(_ sender: Any) {
        card7.setImage(newcard[6], for: .normal)
        //this code will make card7 show the seventh card in new cards array
        card7.tag=1
        //when the user clicks card7, the card7's tag will become 1
        compareAll()
        //If the user clicks two cards and one of them is card7, it will begin to compare
    }
    
    @IBAction func card8(_ sender: Any) {
        card8.setImage(newcard[7], for: .normal)
        //this code will make card8 show the eighth card in new cards array
        card8.tag=1
        //when the user clicks card8, the card8's tag will become 1
        compareAll()
        //If the user clicks two cards and one of them is card8, it will begin to compare
    }
    
    @IBAction func card9(_ sender: Any) {
        card9.setImage(newcard[8], for: .normal)
        //this code will make card9 show the ninth card in new cards array
        card9.tag=1
        //when the user clicks card9, the card9's tag will become 1
        compareAll()
        //If the user clicks two cards and one of them is card9, it will begin to compare
    }
    
    @IBAction func card10(_ sender: Any) {
        card10.setImage(newcard[9], for: .normal)
        //this code will make card10 show the tenth card in new cards array
        card10.tag=1
        //when the user clicks card10, the card10's tag will become 1
        compareAll()
        //If the user clicks two cards and one of them is card10, it will begin to compare
    }
    
    @IBAction func card11(_ sender: Any) {
        card11.setImage(newcard[10], for: .normal)
        //this code will make card11 show the eleventh card in new cards array
        card11.tag=1
        //when the user clicks card11, the card11's tag will become 1
        compareAll()
        //If the user clicks two cards and one of them is card11, it will begin to compare
    }
    
    @IBAction func card12(_ sender: Any) {
        card12.setImage(newcard[11], for: .normal)
        //this code will make card12 show the twleveth card in new cards array
        card12.tag=1
        //when the user clicks card12, the card12's tag will become 1
        compareAll()
        //If the user clicks two cards and one of them is card12, it will begin to compare
    }
    
    @IBAction func card13(_ sender: Any) {
        card13.setImage(newcard[12], for: .normal)
        //this code will make card13 show the thirteenth card in new cards array
        card13.tag=1
        compareAll()
        //If the user clicks two cards and one of them is card13, it will begin to compare
    }
    
    @IBAction func card14(_ sender: Any) {
        card14.setImage(newcard[13], for: .normal)
        //this code will make card14 show the fourteenth card in new cards array
        card14.tag=1
        compareAll()
        //If the user clicks two cards and one of them is card14, it will begin to compare
    }
    
    @IBAction func card15(_ sender: Any) {
        card15.setImage(newcard[14], for: .normal)
        //this code will make card15 show the fifteenth card in new cards array
        card15.tag=1
        //when the user clicks card13, the card13's tag will become 1
        compareAll()
        //If the user clicks two cards and one of them is card15, it will begin to compare
    }
    
    @IBAction func card16(_ sender: Any) {
        card16.setImage(newcard[15], for: .normal)
        //this code will make card16 show the sixteenth card in new cards array
        card16.tag=1
        //when the user clicks card16, the card16's tag will become 1
        compareAll()
        //If the user clicks two cards and one of them is card16, it will begin to compare
    }
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

