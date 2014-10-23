//
//  ViewController.swift
//  Lemonade Stand
//
//  Created by Dominik Butz on 20/10/14.
//  Copyright (c) 2014 Duoyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var walletLabel: UILabel!
    
    @IBOutlet weak var lemonInventoryLabel: UILabel!
    
    @IBOutlet weak var iceCubeInventoryLabel: UILabel!

    
    @IBOutlet weak var lemonPurchaseQuantityLabel: UILabel!
    @IBOutlet weak var iceCubePurchaseQuantityLabel: UILabel!
    
    @IBOutlet weak var addLemonsLabel: UILabel!
    @IBOutlet weak var addIceCubesLabel: UILabel!
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
   
    var inventory = Inventory(aCash: 10, aLemons: 1, aIceCubes: 1)
    let price = Price()
    var shoppingCart = ShoppingCart()
    var mixer = Mixer()
    
    var weather: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.weatherGenerator()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }
    
    //MARK: IBActions
    
    
    @IBAction func addLemonToShoppingCartButtonPressed(sender: UIButton) {
        
        
        if self.inventory.cash >= self.price.lemon {
            
            self.inventory.cash -= self.price.lemon
            self.inventory.lemons += 1
            
            self.shoppingCart.lemons += 1
            
            self.updateView()
            
        }
        
        else {
            
            
            //alert view not enough funds game over!
        }
        
        
    }
    
    @IBAction func removeLemonFromShoppingCartButtonPressed(sender: UIButton) {
        
        if self.shoppingCart.lemons >= 1 {
            
            self.shoppingCart.lemons -= 1
            self.inventory.lemons -= 1
            self.inventory.cash += self.price.lemon
            self.updateView()
            
        }
        
        
    }
    
    @IBAction func addIceCubeToShoppingCartButtonPressed(sender: UIButton) {
        
        
        if self.inventory.cash >= self.price.iceCube {
            
            self.inventory.cash -= self.price.iceCube
            self.inventory.iceCubes  += 1
            self.shoppingCart.iceCubes += 1
            
            self.updateView()
        
        }
        
    }
    
    
    @IBAction func removeIceCubeFromShoppingCartButtonPressed(sender: UIButton) {
        
        if self.shoppingCart.iceCubes >= 1 {
            
            self.shoppingCart.iceCubes -= 1
            self.inventory.iceCubes  -= 1
            self.inventory.cash += 1
            self.updateView()
            
        }
        
        
    }
    
    
    @IBAction func addLemonToMixButtonPressed(sender: UIButton) {
        
        if self.inventory.lemons >= 1 {
            
            self.inventory.lemons -= 1
            self.mixer.lemons += 1
            
            // checki if this is working!
            self.shoppingCart.lemons = 0
            
            self.updateView()
            
        }
        
        
    }
    
    @IBAction func removeLemonFromMixButtonPressed(sender: UIButton) {
        
        if self.mixer.lemons >= 1 {
            
            self.mixer.lemons -= 1
            self.inventory.lemons += 1
            self.updateView()
            
        }
        
        
    }
    
    @IBAction func addIceCubeToMixButtonPressed(sender: UIButton) {
        
        if self.inventory.iceCubes  >= 1 {
            
            self.inventory.iceCubes  -= 1
            self.mixer.iceCubes += 1
            
            self.shoppingCart.iceCubes = 0
            
            self.updateView()
        }
        
        
    }
    
    
    
    @IBAction func removeIceCubeFromMixButtonPressed(sender: UIButton) {
        
        
        if self.mixer.iceCubes >= 1 {
            
            self.mixer.iceCubes -= 1
            self.inventory.iceCubes  += 1
            self.updateView()
            
            
        }
        
    }
    
    
    @IBAction func startDayButtonPressed(sender: UIButton) {
        
        
        // we need at least 1 lemon and 1 ice cube
        if self.mixer.lemons >= 1 && self.mixer.iceCubes >= 1 {
            
            
            let earningsCalculator = EarningsCalculator()
            
            let result = earningsCalculator.sellLemonade(self.mixer.lemons, iceCubes: self.mixer.iceCubes, weather:self.weather)
            
            self.inventory.cash += result.earnings
            
            self.shoppingCart.lemons = 0
            self.mixer.lemons = 0
            self.shoppingCart.iceCubes = 0
            self.mixer.iceCubes = 0
            
            self.updateView()
            
            let message = "Today, \(result.customers) people showed at up your stand, \(result.buyers) bought lemonade and your turnover was $\(result.earnings)"
            
            self.showAlertWithText(header: "Sales result", message: message, buttonTitle:"OK")
            
    
        }
        
        else {
            
            self.showAlertWithText(message: "Please add at least 1 lemon and 1 ice cube into the mixer!", buttonTitle: "OK")
            
        }
        
        
    }
    

    @IBAction func resetButtonPressed(sender: UIButton) {
        
        self.hardReset()
    }
    
    
//MARK: helper functions
    
    func updateView() {
        
        // inventory
        self.walletLabel.text = "$\(self.inventory.cash)"
        self.lemonInventoryLabel.text = "\(self.inventory.lemons) lemons"
        self.iceCubeInventoryLabel.text = "\(self.inventory.iceCubes) ice cubes"
        
        // purchase quantity
        self.lemonPurchaseQuantityLabel.text = "\(self.shoppingCart.lemons)"
        self.iceCubePurchaseQuantityLabel.text  = "\(self.shoppingCart.iceCubes)"
        
        // mixing the brew
        self.addLemonsLabel.text = "\(self.mixer.lemons)"
        self.addIceCubesLabel.text = "\(self.mixer.iceCubes)"
        
        
    }
    
    
    
    func showAlertWithText (header: String = "Warning", message: String, buttonTitle: String) {
        
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
       // alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.Default, handler: ))
        
        alert.addAction(UIAlertAction(title: buttonTitle, style: UIAlertActionStyle.Default, handler:{ (action) in
            
            self.weatherGenerator()
            
            if self.isGameOver() {
                
                self.showGameOverAlert()
                
            }
            
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
        
    }
    
    
    func showGameOverAlert() {
        
        var alert = UIAlertController(title: "Game over", message: "You don't have sufficient funds - game over. ", preferredStyle: .Alert)
        
        alert.addAction(UIAlertAction(title: "Reset", style: .Default, handler: { (action) in
        
            self.hardReset()
        
        
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    func hardReset() {
        
        self.inventory = Inventory(aCash: 10, aLemons: 1, aIceCubes:1)
 
        self.updateView()
        
    }
    
    
    func isGameOver() -> Bool {
        
        
        if self.inventory.lemons == 0  && self.inventory.cash < 2{
            
            println(" no lemons in inventory and can't buy any more lemons")
                return true
            

        }
        
        else if self.inventory.iceCubes  == 0 && self.inventory.cash == 0{
            
            
            println(" no ice cubes in inventory and can't buy any more ice cubes!")
                return true
            
            
        }
        
        else if self.inventory.iceCubes  == 0 && self.inventory.lemons == 0 && self.inventory.cash < 3 {
            
            return true
        }
        
        return false
        
    }
    
    func weatherGenerator() {
        
        let randomWeather = Int(arc4random_uniform(UInt32(3)))
        
        switch randomWeather {
            case 0:
                self.weather = "cold"
        case 1:
                self.weather = "mild"
        case 2:
                self.weather = "warm"
        default:
            self.weather = ""
            
        }
        
        self.weatherImageView.image = UIImage(named: self.weather)
        
    }
    
   

}

