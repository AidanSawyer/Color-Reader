//
//  View2.swift
//  Color Reader
//
//  Created by Aidan Sawyer on 6/14/16.
//  Copyright © 2016 Aidan Sawyer. All rights reserved.
//

import UIKit
import AVFoundation
import Foundation
import CoreData



extension UIImage {
    
  /*
     gets the rgba data in an array of CGFloat's of a specified pixel (pos)
 */
    func getPixelColor(pos: CGPoint) -> [CGFloat] {
        
        let pixelData = CGDataProviderCopyData(CGImageGetDataProvider(self.CGImage))
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)
        
        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4
        
        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)
        
        
        var Color: [CGFloat] = [r*100, g*100, b*100]
        
        
        return Color
    }

}
public var userDefaults = NSUserDefaults()
class View2: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var captureSession: AVCaptureSession?
    var stillImageOutput: AVCaptureStillImageOutput?
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var ColorLabel: UILabel!
    @IBOutlet weak var ColorImageView: UIImageView!
    @IBOutlet weak var HexLabel: UILabel!
    
    @IBOutlet weak var TakeAnotherButton: UIButton!
    @IBOutlet weak var SaveColorButton: UIButton!
    
    @IBOutlet weak var cameraView: UIView!
    
    var FirstTake: Bool = false
    var loopCount = 0
    
    var Colors = [Color]()
    var hexCode: String = ""
    var Red = CGFloat()
    var Green = CGFloat()
    var Blue = CGFloat()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(colorView)
        
        colorView.backgroundColor = UIColor.whiteColor()
        ColorImageView.hidden = true
        HexLabel.text = ""
        TakeAnotherButton.hidden = true
        SaveColorButton.hidden = true
        
        
        ColorImageView.layer.borderWidth = 5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        previewLayer?.frame = cameraView.bounds
    }

    func IntToCGFloat(x:Int) -> CGFloat{
        return CGFloat(x)
    }
    
    func Hex(x: Int) -> String{
        
        let B16: String = String(x, radix: 16)
        var hex = ""
        if B16.characters.count < 2{
            
            hex = "0" + B16
            return hex
            
        }
       return B16
    }
    
    //code for taking the photo
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        colorView.hidden = true
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = AVCaptureSessionPreset1920x1080
        
        var backCamera = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        var input: AVCaptureDeviceInput
        var error = false
        do{
           input =  try AVCaptureDeviceInput(device: backCamera)
            
            if error == false && (captureSession?.canAddInput(input))!{
                captureSession?.addInput(input)
                
                stillImageOutput = AVCaptureStillImageOutput()
                stillImageOutput?.outputSettings = [AVVideoCodecKey : AVVideoCodecJPEG]
                
                if ((captureSession?.canAddOutput(stillImageOutput)) != nil){
                    captureSession?.addOutput(stillImageOutput)
                    
                    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                    previewLayer?.videoGravity = AVLayerVideoGravityResizeAspect
                    previewLayer?.connection.videoOrientation = AVCaptureVideoOrientation.Portrait
                    
                    captureSession?.sessionPreset = AVCaptureSessionPresetPhoto
                    
                    cameraView.layer.addSublayer(previewLayer!)
                    captureSession?.startRunning()
                    
                }
            }

            
        }catch _{
           error = true
        }
    }
    
    
    
    
    @IBOutlet weak var tempImageView: UIImageView!
    //retreiving the photo
    func didPressTakePhoto(){
        
        if let videoConnection = stillImageOutput?.connectionWithMediaType(AVMediaTypeVideo){
            videoConnection.videoOrientation = AVCaptureVideoOrientation.Portrait
            stillImageOutput?.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: {
                (sampleBuffer, error) in
                if sampleBuffer != nil {
                    
                    var imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    var dataProvider = CGDataProviderCreateWithCFData(imageData)
                    var cgImageRef = CGImageCreateWithJPEGDataProvider(dataProvider, nil, true, CGColorRenderingIntent.RenderingIntentDefault)
                    
                    var image = UIImage(CGImage: cgImageRef!, scale: 1.0, orientation: UIImageOrientation.Right)
                    
                    
                    /*
                        Code Below (here to end of function) deals with retreiving the rgb data of the center 8x8 pixels, averaging then making the averaged pixels in to an array
                    */
                    var xMin = Int(image.size.width/2 - 4) //minimum x value in the 8x8 square
                    var xMax = Int(image.size.width/2 + 4) //maximum x value in 8x8 square
                    
                    var yMin = Int(image.size.height/2 - 4) //minimum y value in 8x8 square
                    var yMax = Int(image.size.height/2 + 4) //maximum y value in 8x8 square
                    
                    
                    var iterationCount: Int = 0
                    
                    let count1 = Float(64)
                    let count2 = Float(3)
                    let repeatedValue = Float(0)
                    var PixelArray = [[CGFloat]]()
                    
                    
                    
                    
                    //this loop loops through all the pixels in 8x8 square and adds it to array
                    for x in xMin..<xMax{
                        for y in yMin..<yMax{
                            
                            var yInt = CGFloat(y)
                            var xInt = CGFloat(x)
                            
                            
                            print("x: " , x)
                            print("y: ", y)
                            print(image.getPixelColor(CGPointMake(yInt*2.55, xInt*2.55)))
                            print("-------")
                            
                            
                            PixelArray.append(image.getPixelColor(CGPointMake(yInt, xInt)))
                            iterationCount += 1
                        }
                    }
                    
                    //print(PixelArray)
                    
                    var red: CGFloat = 0
                    var green: CGFloat = 0
                    var blue: CGFloat = 0
                    
                    /*
                        following loop loops through the rgb data and average each type(r,g,b)
                    */
                    for i in 0...63{
                        red += PixelArray[i][0]
                        green += PixelArray[i][1]
                        blue += PixelArray[i][2]

                    }
                    print("Final Red Value: ",  String((red/64)*2.55))
                    print("Final Green Value: ", String((green/64)*2.55))
                    print("Final Blue Value: ", String((blue/64)*2.55))
                    var averageColor = [red/64, green/64, blue/64]
                    
                    let r = round(red/64)
                    let g = round(green/64)
                    let b = round(blue/64)
                    
                    let hex = self.Hex(Int(r*2.55)) + self.Hex(Int(g*2.55)) + self.Hex(Int(b*2.55))
                    self.hexCode = hex
                    print("final hexadecimal: #" + hex)
                    self.loopCount = iterationCount/64 * 100
                    self.ColorLabel.text = "Color Information Loaded"
                    self.HexLabel.text = "#" + hex
                    
                    self.ColorImageView.layer.borderColor = UIColor.blackColor().CGColor
                    self.ColorImageView.backgroundColor = UIColor(red: r/100, green: g/100, blue: b/100, alpha: 1)
                    self.ColorImageView.hidden = false
                    
                    self.FirstTake = true
                
                    self.Red = r/100
                    self.Green = g/100
                    self.Blue = b/100
                }
            })
        }
        
    }
    
    func SortColorData(Data: [CGFloat]) -> CGFloat{
        
        
        return 1
    }
    
    var didTakePhoto = Bool()
    
    func didPressTakeAnother(){
        
        if didTakePhoto == true{
            tempImageView.hidden = true
            didTakePhoto = false
        }else{
            captureSession?.startRunning()
            didTakePhoto = true
            
            didPressTakePhoto()
        }
        
        
    }
    
    
    @IBAction func TakeAnother(sender: AnyObject) {
        
        
        didPressTakeAnother()
        colorView.hidden = true
        ColorImageView.hidden = true
        HexLabel.text = ""
        
    }
    
    @IBAction func SaveColor(sender: AnyObject) {
        
        //get name
        
        var textField: UITextField = UITextField()
        
        var alert = UIAlertController(title: "Enter Color Name", message: "Enter Color Name", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.text = "enter name here"
        })
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            textField = alert.textFields![0] as UITextField
            print("Text field: \(textField.text)")
        }))
        self.presentViewController(alert, animated: true, completion: nil)
        
        Colors.append(Color(name: String(textField), hexCode: hexCode, Red: Red, Green: Green, Blue: Blue))
        
        //archive data
        /*
        var userDefaults = NSUserDefaults.standardUserDefaults()
        let encodedData = NSKeyedArchiver.archivedDataWithRootObject(Colors)
        userDefaults.setObject(encodedData, forKey: "Colors")
        userDefaults.synchronize()
         */
        

        
        print(Colors)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if colorView.hidden == true{
            didPressTakeAnother()
            print("touch")
        
            colorView.hidden = false
            ColorLabel.text = "Loading Color Information"
        
            TakeAnotherButton.hidden = false
            SaveColorButton.hidden = false
            HexLabel.hidden = false
            
        }
        
       

    }
    
}


