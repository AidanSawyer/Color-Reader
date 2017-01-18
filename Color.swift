//
//  Color.swift
//  Color Reader
//
//  Created by Aidan Sawyer on 7/20/16.
//  Copyright © 2016 Aidan Sawyer. All rights reserved.
//

import Foundation
import UIKit

class Color: NSObject, NSCoding {
    
    var name: NSString!
    var hexCode: NSString!
    var Red: CGFloat
    var Green: CGFloat
    var Blue: CGFloat
    
    init(name: NSString, hexCode: NSString, Red: CGFloat, Green: CGFloat, Blue: CGFloat){
        self.name = name
        self.hexCode = hexCode
        self.Red = Red
        self.Green = Green
        self.Blue = Blue
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let hexCode = aDecoder.decodeObject(forKey: "hexCode") as! String
        let Red = aDecoder.decodeObject(forKey: "Red") as! CGFloat
        let Green = aDecoder.decodeObject(forKey: "Green") as! CGFloat
        let Blue = aDecoder.decodeObject(forKey: "Blue") as! CGFloat
        self.init(name:name as NSString, hexCode: hexCode as NSString, Red: Red, Green: Green, Blue: Blue)
        
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: "name")
        aCoder.encode(hexCode, forKey: "hexCode")
        
    }
}
