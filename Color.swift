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
        
        let name = aDecoder.decodeObjectForKey("name") as! String
        let hexCode = aDecoder.decodeObjectForKey("hexCode") as! String
        let Red = aDecoder.decodeObjectForKey("Red") as! CGFloat
        let Green = aDecoder.decodeObjectForKey("Green") as! CGFloat
        let Blue = aDecoder.decodeObjectForKey("Blue") as! CGFloat
        self.init(name:name, hexCode: hexCode, Red: Red, Green: Green, Blue: Blue)
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(name, forKey: "name")
        aCoder.encodeObject(hexCode, forKey: "hexCode")
        
    }
}
