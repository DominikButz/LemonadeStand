//
//  Inventory.swift
//  Lemonade Stand
//
//  Created by Dominik Butz on 22/10/14.
//  Copyright (c) 2014 Duoyun. All rights reserved.
//

import Foundation

struct Inventory {
    
    var cash = 0
    var lemons = 0
    var iceCubes = 0
    
    init(aCash: Int, aLemons: Int, aIceCubes: Int) {
        
        cash = aCash
        lemons = aLemons
        iceCubes = aIceCubes
        
    }
    
}