//
//  SlotBrain.swift
//  SlotMachine
//
//  Created by yousheng chang on 10/3/14.
//  Copyright (c) 2014 InfoTech Inc. All rights reserved.
//

import Foundation

class SlotBrain{
    
    class func computeWinnings(slots:[[Slot]]) ->Int{
        
        var slotsInRows = unpackSlotsIntoSlotRows(slots)
        var winnings = 0
        var flushWinCount = 0
        var threeOfAKindWinCount = 0
        var straightWinCount = 0
        
        for slotRow in slots{
            if checkFlush(slotRow) == true{
                println("flush")
                winnings += 1
                flushWinCount += 1
            }
            if checkThreeInARow(slotRow) == true {
                println("Three in a row")
                winnings += 1
                straightWinCount += 1
            }
            if checkThreeInAKind(slotRow) == true {
                println("Three a kind")
                winnings += 3
                threeOfAKindWinCount += 1
            }
            
        }
        if flushWinCount == 3 {
            println("Royal Flush")
            winnings += 15
        }
        if straightWinCount == 3 {
            println("Epic straight")
            winnings += 1000
        }
        if threeOfAKindWinCount == 3 {
            println("Three all a round")
            winnings += 50
        }

        return winnings
        
    }
    
    class func unpackSlotsIntoSlotRows(slots:[[Slot]]) -> [[Slot]]{
        
        var slotRow1: [Slot] = []
        var slotRow2: [Slot] = []
        var slotRow3: [Slot] = []
        
        for slotArray in slots{
            for var index = 0; index < slotArray.count; index++ {
                let slot = slotArray[index]
                if index == 0 {
                    slotRow1.append(slot)
                }
                else if index == 1{
                    slotRow2.append(slot)
                }
                else if index == 2{
                    slotRow3.append(slot)
                }else{
                    println("Error")
                }
            }
        
        }
        var slotRows: [[Slot]] = [slotRow1, slotRow2, slotRow3]
        return slotRows
    }
    
    //Helper functions
    class func checkFlush (slotRow:[Slot]) -> Bool {
        
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if slot1.isRed == true && slot2.isRed == true && slot3.isRed {
            return true
        }
        else if slot1.isRed == false && slot2.isRed == false && slot3.isRed == false {
            return true
        }else{
            return false
        }
    }
    
    class func checkThreeInARow (slotRow:[Slot]) -> Bool {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if slot1.value == slot2.value - 1 && slot1.value == slot3.value - 2 {
            return true
        }
        else if slot1.value == slot2.value + 1 && slot1.value == slot3.value + 2 {
            return true
        }else{
            return false
        }
    
    }
    
    class func checkThreeInAKind (slotRow:[Slot]) -> Bool {
        let slot1 = slotRow[0]
        let slot2 = slotRow[1]
        let slot3 = slotRow[2]
        
        if slot1.value == slot2.value && slot1.value == slot3.value {
            return true
        }else{
            return false
        }
        
    }
    

    
}
