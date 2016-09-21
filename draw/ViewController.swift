//
//  ViewController.swift
//  draw
//
//  Created by do duy hung on 20/09/2016.
//  Copyright © 2016 do duy hung. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    var lastPoint = CGPoint.zero
    var red : CGFloat = 0.0
    var green : CGFloat = 0.0
    var blue : CGFloat = 0.0
    var brushWidth : CGFloat = 10.0
    var opacity : CGFloat = 1.0
    var swiped = false
    var baseImage = UIImage()
    var cap = CGLineCap.Round
    let imgColors = ["Black","Grey","Red","Blue","LightBlue","DarkGreen","LightGreen","Brown","DarkOrange","Yellow"]
    let colors: [(CGFloat, CGFloat, CGFloat)] = [
        (0, 0, 0),
        (105.0 / 255.0, 105.0 / 255.0, 105.0 / 255.0),
        (1.0, 0, 0),
        (0, 0, 1.0),
        (51.0 / 255.0, 204.0 / 255.0, 1.0),
        (102.0 / 255.0, 204.0 / 255.0, 0),
        (102.0 / 255.0, 1.0, 0),
        (160.0 / 255.0, 82.0 / 255.0, 45.0 / 255.0),
        (1.0, 102.0 / 255.0, 0),
        (1.0, 1.0, 0),
        (1.0, 1.0, 1.0),
    ]
    @IBOutlet weak var mainView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func buttonClick(sender: AnyObject) {
        
        var index = sender.tag
        switch(index){
        case 0: brushWidth = 5
        case 1 : brushWidth = 10
        case 2 : brushWidth = 30
        case 3 : (red,green,blue) = colors[10]
        case 4 :    cap = CGLineCap.Square
        case 5 :    cap = CGLineCap.Butt
        case 6 :    cap = CGLineCap.Round
        default : break
        
        }
    }

    @IBAction func reset(sender: AnyObject) {
        mainView.image = baseImage
    }
    
    @IBAction func album(sender: AnyObject) {
        var imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func save(sender: AnyObject) {
        UIImageWriteToSavedPhotosAlbum(mainView.image!, self, nil, nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickerImage:UIImage = (info[UIImagePickerControllerOriginalImage]) as? UIImage {
            baseImage = pickerImage
            mainView.image = baseImage
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.locationInView(view)
        }
        
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        swiped = true
        if let touch = touches.first{
            let currentPoint = touch.locationInView(mainView)
            // Ve
            drawLineFrome(lastPoint, toPoint: currentPoint)
            lastPoint = currentPoint
        
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if (!swiped){
         //ve
            drawLineFrome(lastPoint, toPoint: lastPoint)
        }
    }
    func drawLineFrome(fromePoint:CGPoint,toPoint:CGPoint){
        UIGraphicsBeginImageContext(mainView.frame.size)
        let context = UIGraphicsGetCurrentContext()
        mainView.image?.drawInRect(CGRect(x: 0, y: 0, width: mainView.frame.size.width, height: mainView.frame.size.height))
        CGContextMoveToPoint(context, fromePoint.x, fromePoint.y)
        CGContextAddLineToPoint(context, toPoint.x, toPoint.y)
        
        //  set thuoc tinh
        
        CGContextSetLineCap(context, cap)
        CGContextSetLineWidth(context, brushWidth)
        CGContextSetRGBStrokeColor(context, red, green, blue, 1.0)
        CGContextSetBlendMode(context, CGBlendMode.Normal)
        
        CGContextStrokePath(context)
        mainView.image = UIGraphicsGetImageFromCurrentImageContext()
        mainView.alpha = opacity
        UIGraphicsEndImageContext()
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count - 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! Cell
        
        cell.filteredImageView.image = UIImage(named: imgColors[indexPath.item])
        return cell
    }
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        (red,green,blue) = colors[indexPath.item]
    }
}

