//
//  EarningsCalculator.swift
//  Lemonade Stand
//
//  Created by Dominik Butz on 21/10/14.
//  Copyright (c) 2014 Duoyun. All rights reserved.
//

import Foundation


class EarningsCalculator {
    
    let diluted = "diluted"
    let balanced = "balanced"
    let acidic = "acidic"
    
    let earningsPerGlass = 1
    
    
    func sellLemonade(lemons: Int, iceCubes: Int, weather:String) -> (customers: Int, buyers:Int, earnings: Int) {
    
    
        let acidityRatio: Float =  Float(lemons ) / Float(iceCubes)
    
        println("acidity ratio: \(acidityRatio)")
        // random number of customers
        
        var customerCount = Int(arc4random_uniform(UInt32(10)) + 1)
        
        switch weather {
            case "cold":
                customerCount -= 2
            case "mild":
                customerCount += 2
             case "warm":
                customerCount += 4
            default:
                customerCount += 0
        }
        
        if customerCount < 0 {
            customerCount = 0
        }
        
        println("customers created: \(customerCount)")
    
        let result = self.calculateEarnings(customerCount, acidityRatio: acidityRatio)

        return (customerCount, result.buyers, result.earnings)
    
    
    }
    
    func  calculateEarnings(customerCount: Int, acidityRatio: Float) -> (earnings:Int, buyers:Int) {
    
        var earnings = 0
        var buyers = 0
        
        for x in 0...customerCount {
            
            let randomPreference =  (Float(arc4random_uniform(UInt32(101)))) / 100
            
            // check if the preference matches the acidity ration. if yes earnings += 1
            println("customer \(x) preference: \(randomPreference)")
            
            if self.preferenceType(randomPreference) == self.acidityLevel(acidityRatio) {
                
                earnings += self.earningsPerGlass
                buyers += 1
            }
            
        }
        
        
        return (earnings, buyers)
        
    }
    
    func preferenceType(preferenceCoefficient: Float) -> String {
        
        
        switch preferenceCoefficient {
            case 0...0.4:
                return self.diluted
            case 0.401...0.6:
                return self.balanced
            case 0.601...1:
               return self.acidic
            default:
                return ""

        }
        

        
    }
    
    
    func acidityLevel(acidityRatio: Float) -> String {
        
        if acidityRatio < 1.0 {
            return self.diluted
        }
        else if acidityRatio == 1.0 {
            return self.balanced
        }
        else if acidityRatio > 1.0 {
            
             return self.acidic
        }
        
        else {return ""}
        
    }
    
    
}