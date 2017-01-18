//
//  View3.swift
//  Color Reader
//
//  Created by Aidan Sawyer on 6/15/16.
//  Copyright © 2016 Aidan Sawyer. All rights reserved.
//


//self.ColorImageView.layer.borderColor = UIColor.blackColor().CGColor
//self.ColorImageView.backgroundColor = UIColor(red: r/100, green: g/100, blue: b/100, alpha: 1)


import UIKit
import AVFoundation
import Foundation
import CoreData

public var Red = CGFloat()
public var Blue = CGFloat()
public var Green = CGFloat()

//let decoded  = userDefaults.objectForKey("Colors") as! NSData
//let decodedColors = NSKeyedUnarchiver.unarchiveObjectWithData(decoded) as! [Color]
//return decodedColors

class View3: UITableViewController {

    
    //var decodedColors: [Color] = [Color.init(name: "A", hexCode: "#000000", Red: 0, Green: 0, Blue: 0)]
    //func getSavedColors() -> [Color]{
     
    //}

   // var Colors = [Color]()
    var Colors: [Color] = [(Color.init(name: "A", hexCode: "#000000", Red: 0, Green: 0, Blue: 0))]
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
       // let defaults = NSUserDefaults.standardUserDefaults()
        
        //getting the name saved
       // if let ColorList = defaults.objectForKey("ColorList") {
            /*
            Colors = ColorList as! [Color]
            print(ColorList)
            print(Colors)
        }
        print(defaults.arrayForKey("ColorList"))
    */
        navigationItem.title = "Saved Colors"
        tableView.register(ColorCell.self, forCellReuseIdentifier: "CellId")
        tableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "HeaderId")
        tableView.sectionHeaderHeight = 50
        
    }

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return Colors.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
       let colorCell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath) as! ColorCell
        colorCell.nameLabel.text = Colors[indexPath.row].Red as CGFloat
        
       // colorCell.nameLabel.text = Colors[indexPath.row].name as String
        /*
        Red = ColorList[indexPath.row].Red as CGFloat
        Green = ColorList[indexPath.row].Green as CGFloat
        Blue = ColorList[indexPath.row].Blue as CGFloat
        
        var redFinal = Red/255
        var greenFinal = Green/255
        var blueFinal = Blue/255
        
        print("------------------------------", Red)
        
        
        colorCell.colorImage.backgroundColor = UIColor(red: redFinal, green: greenFinal, blue: blueFinal, alpha: 1)
        //print(Colors[indexPath.row].Red)
        */
        return colorCell
    }

    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderId")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath)-> CGFloat{
        
        return 120
    }
    
    //func deleteCell()

}

class Header: UITableViewHeaderFooterView{
    
    override init(reuseIdentifier: String?){
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "SavedColors"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews(){
        self.addSubview(nameLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
        
        
        
    }
}

class ColorCell: UITableViewCell{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("delete", for: UIControlState())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = false
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let colorImage: UIImageView = {
        
        
        let colorImage = UIImageView()
        colorImage.layer.borderColor = UIColor.black.cgColor
        colorImage.backgroundColor = UIColor(red: Red/100, green: Green/100, blue: Blue/100, alpha: 1)
        colorImage.translatesAutoresizingMaskIntoConstraints = false
        return colorImage
    }()
    
    func setupViews(){
        self.addSubview(nameLabel)
        self.addSubview(deleteButton)
        self.addSubview(colorImage)
        
        deleteButton.addTarget(self, action: #selector(ColorCell.handleAction), for: .touchUpInside)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-120-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
       // addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-250-[v0(80)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": deleteButton]))
       // addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[v0(100)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": colorImage]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
       // addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-60-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": deleteButton]))
        // addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[v0(100)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":colorImage]))


    }
    
    func handleAction(){
        print("tapped")
    }
    
}










