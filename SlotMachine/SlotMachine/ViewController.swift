//
//  ViewController.swift
//  SlotMachine
//
//  Created by yousheng chang on 9/28/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Containers
    var firstContainer: UIView!
    var secondContainer: UIView!
    var thirdContainer: UIView!
    var fourthContainer: UIView!
    
    //Information Labels
    var creditsLabel: UILabel!
    var betLabel: UILabel!
    var winnerPaidLabel: UILabel!
    
    var creditsTileLabel: UILabel!
    var betTitlelabel: UILabel!
    var winnerPaidTitleLabel: UILabel!
    
    //buttons in fourth container
    var resetButton: UIButton!
    var betOneButton: UIButton!
    var betMaxButton: UIButton!
    var spinButton: UIButton!
    
    
    
    
    
    
    //Constants
    let kMarginForView:CGFloat = 10.0
    let kMarginForSlot: CGFloat = 2.0
    let kSixth:CGFloat = 1.0/6.0
    let kThird:CGFloat = 1.0/3.0
    let kHalf:CGFloat = 1.0/2.0
    let kEighth:CGFloat = 1.0/8.0
    let kNumberOfContainers = 3
    let kNumberOfSlots = 3
    
    
    
    
    //Top View
    var titleLabel:UILabel!
    
    //Slots array
    var slots:[[Slot]] = []

    //Stats
    var credits:Int = 0
    var winnings:Int = 0
    var currentBet:Int = 0
    
    
    //Second Container View
    
    
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setupContainerViews()
        self.setupFirstContainer(self.firstContainer)
        //self.setupSecondContainer(self.secondContainer)
        self.setupThirdContainer(self.thirdContainer)
        self.setupFourthContainer(self.fourthContainer)
        self.hardReset()
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //IBActions
    
    func resetButtonPressed(button: UIButton){
        //println("resetButtonPressed")
        hardReset()
        
    }
    
    func betOneButtonPressed(button: UIButton){
        //println("betOneButtonPressed: \(button)")
        if(credits <= 0){
            showAlertWithText(header: "No More Credits", message: "Reset Game")
            
        }
        else
        {
            if(currentBet < 5){
                currentBet += 1
                credits -= 1
                updateMainView()
                
            }else{
                showAlertWithText(message: "You can only 5 credits at a time")
            }
        }
        
    }
    
    func betMaxButtonPressed(button: UIButton){
        println("betMaxButtonPressed")
    }
    
    func spinButtonPressed(button: UIButton){
       
        slots = Factory.createSlots()
        removeSlotImageViews()
        setupSecondContainer(self.secondContainer)
        
    }
    

    func setupContainerViews(){
        
        self.firstContainer = UIView(frame: CGRectMake(self.view.bounds.origin.x + kMarginForView, self.view.bounds.origin.y,
            self.view.bounds.width - (kMarginForView * 2), self.view.bounds.height * kSixth))
        self.firstContainer.backgroundColor = UIColor.redColor()
        self.view.addSubview(self.firstContainer)
        
        self.secondContainer = UIView(frame: CGRectMake(self.view.bounds.origin.x + kMarginForView, self.firstContainer.frame.height, self.view.bounds.width - (kMarginForView * 2.0), self.view.bounds.height * (3 * kSixth)))
        self.secondContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.secondContainer)
        
        self.thirdContainer = UIView(frame: CGRectMake(self.view.bounds.origin.x + kMarginForView, self.firstContainer.frame.height + self.secondContainer.frame.height, self.view.bounds.width - (2 * kMarginForView), self.view.bounds.height * kSixth))
        self.thirdContainer.backgroundColor = UIColor.lightGrayColor()
        self.view.addSubview(self.thirdContainer)
        
        self.fourthContainer = UIView(frame: CGRectMake(self.view.bounds.origin.x + kMarginForView, self.firstContainer.frame.height + self.secondContainer.frame.height + self.thirdContainer.frame.height, self.view.bounds.width - (2 * kMarginForView), self.view.bounds.height * kSixth))
        self.fourthContainer.backgroundColor = UIColor.blackColor()
        self.view.addSubview(self.fourthContainer)
        
        
        
        
    }
    
    func setupFirstContainer(containerView: UIView){
        
        self.titleLabel = UILabel()
        self.titleLabel.text = "Super Slots"
        self.titleLabel.textColor = UIColor.yellowColor()
        self.titleLabel.font = UIFont(name: "MarkerFelt-Wide", size: 40)
        self.titleLabel.sizeToFit()
        self.titleLabel.center = containerView.center
        
        containerView.addSubview(self.titleLabel)
    }
    
    func setupSecondContainer(containerView: UIView) {
        
        for var containerNumber = 0; containerNumber < kNumberOfContainers; ++containerNumber {
            for var slotNumber = 0; slotNumber < kNumberOfSlots; ++slotNumber {
                var slot:Slot
                var slotImageView = UIImageView()
                if(slots.count != 0){
                    let slotContainer = slots[containerNumber]
                    slot = slotContainer[slotNumber]
                    slotImageView.image = slot.image
                    
                }else{
                    slotImageView.image = UIImage(named: "Ace")
                }
                //slotImageView.backgroundColor = UIColor.yellowColor()
                slotImageView.frame = CGRectMake(containerView.bounds.origin.x + (containerView.bounds.width * CGFloat(containerNumber) * kThird), containerView.bounds.origin.y + (containerView.bounds.height * CGFloat(slotNumber) * kThird), (containerView.bounds.width * kThird - kMarginForSlot), (containerView.bounds.height * kThird - kMarginForSlot))
                containerView.addSubview(slotImageView)
                
            }
        }
        
    }
    
    func setupThirdContainer(containerView: UIView) {
        
        self.creditsLabel = UILabel()
        self.creditsLabel.text = "000000"
        self.creditsLabel.textColor = UIColor.redColor()
        self.creditsLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        self.creditsLabel.sizeToFit()
        self.creditsLabel.center = CGPointMake(containerView.bounds.width * kSixth, containerView.bounds.height * kThird)
        self.creditsLabel.textAlignment = NSTextAlignment.Center
        self.creditsLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.creditsLabel)
        
        self.betLabel = UILabel()
        self.betLabel.text = "0000"
        self.betLabel.textColor = UIColor.redColor()
        self.betLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        self.betLabel.sizeToFit()
        self.betLabel.center = CGPointMake(containerView.bounds.width * kSixth * 3, containerView.bounds.height * kThird)
        self.betLabel.textAlignment = NSTextAlignment.Center
        self.betLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.betLabel)
        
        self.winnerPaidLabel = UILabel()
        self.winnerPaidLabel.text = "000000"
        self.winnerPaidLabel.textColor = UIColor.redColor()
        self.winnerPaidLabel.font = UIFont(name: "Menlo-Bold", size: 16)
        self.winnerPaidLabel.sizeToFit()
        self.winnerPaidLabel.center = CGPointMake(containerView.bounds.width * kSixth * 5, containerView.bounds.height * kThird)
        self.winnerPaidLabel.textAlignment = NSTextAlignment.Center
        self.winnerPaidLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.winnerPaidLabel)
        
        self.creditsTileLabel = UILabel()
        self.creditsTileLabel.text = "Credits"
        self.creditsTileLabel.textColor = UIColor.blackColor()
        self.creditsTileLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.creditsTileLabel.sizeToFit()
        self.creditsTileLabel.center = CGPointMake(containerView.frame.width * kSixth, containerView.frame.height * kThird * 2)
        //self.creditsTileLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.creditsTileLabel)
        
        self.betTitlelabel = UILabel()
        self.betTitlelabel.text = "Bets"
        self.betTitlelabel.textColor = UIColor.blackColor()
        self.betTitlelabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.betTitlelabel.sizeToFit()
        self.betTitlelabel.center = CGPointMake(containerView.frame.width * kSixth * 3, containerView.frame.height * kThird * 2)
        //self.betTitlelabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.betTitlelabel)
        
        self.winnerPaidTitleLabel = UILabel()
        self.winnerPaidTitleLabel.text = "Winner Paid"
        self.winnerPaidTitleLabel.textColor = UIColor.blackColor()
        self.winnerPaidTitleLabel.font = UIFont(name: "AmericanTypewriter", size: 14)
        self.winnerPaidTitleLabel.sizeToFit()
        self.winnerPaidTitleLabel.center = CGPointMake(containerView.frame.width * kSixth * 5, containerView.frame.height * kThird * 2)
        //self.winnerPaidTitleLabel.backgroundColor = UIColor.darkGrayColor()
        containerView.addSubview(self.winnerPaidTitleLabel)
        
        
    }
    
    func setupFourthContainer(containerView: UIView){
        
        self.resetButton = UIButton()
        self.resetButton.setTitle("Reset", forState: UIControlState.Normal)
        self.resetButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.resetButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.resetButton.backgroundColor = UIColor.lightGrayColor()
        self.resetButton.sizeToFit()
        self.resetButton.center = CGPointMake(containerView.frame.width * kEighth, containerView.frame.height * kHalf)
        self.resetButton.addTarget(self, action: "resetButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.resetButton)
        
        self.betOneButton = UIButton()
        self.betOneButton.setTitle("Bet One", forState: UIControlState.Normal)
        self.betOneButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.betOneButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.betOneButton.backgroundColor = UIColor.greenColor()
        self.betOneButton.sizeToFit()
        self.betOneButton.center = CGPointMake(containerView.frame.width * kEighth * 3, containerView.frame.height * kHalf)
        self.betOneButton.addTarget(self, action: "betOneButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.betOneButton)
        
        self.betMaxButton = UIButton()
        self.betMaxButton.setTitle("Bet Max", forState: UIControlState.Normal)
        self.betMaxButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.betMaxButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.betMaxButton.backgroundColor = UIColor.redColor()
        self.betMaxButton.sizeToFit()
        self.betMaxButton.center = CGPointMake(containerView.frame.width * kEighth * 5, containerView.frame.height * kHalf)
        self.betMaxButton.addTarget(self, action: "betMaxButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.betMaxButton)
        
        self.spinButton = UIButton()
        self.spinButton.setTitle("Spin", forState: UIControlState.Normal)
        self.spinButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        self.spinButton.titleLabel?.font = UIFont(name: "Superclarendon-Bold", size: 12)
        self.spinButton.backgroundColor = UIColor.lightGrayColor()
        self.spinButton.sizeToFit()
        self.spinButton.center = CGPointMake(containerView.frame.width * kEighth * 7, containerView.frame.height * kHalf)
        self.spinButton.addTarget(self, action: "spinButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        containerView.addSubview(self.spinButton)
     
        
    }
    
//Helper functions for the slot machine
    
    func removeSlotImageViews(){
        
        if self.secondContainer != nil {
            
            let container:UIView? = self.secondContainer!
            let subViews:Array? = container!.subviews
            for view in subViews!{
                view.removeFromSuperview()
            }
        }
    }
    
    func hardReset(){
        
        removeSlotImageViews()
        slots.removeAll(keepCapacity: true)
        self.setupSecondContainer(self.secondContainer)
        credits = 50
        winnings = 0
        currentBet = 0
        updateMainView()
        
    }

    func updateMainView(){
        
        self.creditsLabel.text = "\(credits)"
        self.winnerPaidLabel.text = "\(winnings)"
        self.betLabel.text = "\(currentBet)"
        
    }
    
    func showAlertWithText(header:String = "Warnning", message:String){
        
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
}

