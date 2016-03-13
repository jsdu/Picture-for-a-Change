//
//  detailTableController.swift
//  OneWord
//
//  Created by Jason Du on 2016-03-12.
//  Copyright © 2016 Jason Du. All rights reserved.
//

import UIKit

class detailTableController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    var topic = ""
    var gradient : CAGradientLayer?
    var toColors : AnyObject?
    var fromColors : AnyObject?
    var selectedSticker:sticker?
    @IBOutlet var tableVIew: UITableView!
    @IBOutlet var labeltitle: UILabel!
    
    var stickerArr:[sticker] = []
    @IBOutlet var back: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        if (topic == "charity"){
            labeltitle.text = "Charity"
        } else if (topic == "politics") {
            labeltitle.text = "Politics"
        } else if (topic == "events") {
            labeltitle.text = "Events"
        } else if (topic == "sponsors") {
            labeltitle.text = "Sponsors"
        }
    }
    
    override func viewDidLoad() {
        
        back.layer.cornerRadius = 5
        back.layer.borderWidth = 1
        back.layer.borderColor = UIColor.whiteColor().CGColor
        back.titleEdgeInsets = UIEdgeInsetsMake(0, 2.0, 0, 2.0)
        
        let blur = UIVisualEffectView(effect: UIBlurEffect(style:
            UIBlurEffectStyle.Light))
        blur.frame = back.bounds
        blur.userInteractionEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
        back.insertSubview(blur, atIndex: 0)
        
        for stickers in sData.sharedInstance.stickerArr {
            if (stickers.label.contains(topic)){
                stickerArr.append(stickers)
            }
        }
        
        self.gradient = CAGradientLayer()
        self.gradient?.frame = self.view.bounds
        self.gradient?.colors = [UIColor.purpleColor().CGColor, UIColor.blueColor().CGColor]
        self.view.layer.insertSublayer(self.gradient!, atIndex: 0)
        
        self.toColors = [UIColor.blueColor().CGColor, UIColor.purpleColor().CGColor]
        animateLayer()
    }
    
    func animateLayer(){
        
        self.fromColors = self.gradient?.colors
        self.gradient!.colors = self.toColors! as? [AnyObject] // You missed this line
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "colors")
        animation.delegate = self
        animation.fromValue = fromColors
        animation.toValue = toColors
        animation.duration = 20.00
        animation.removedOnCompletion = true
        animation.fillMode = kCAFillModeForwards
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.delegate = self
        
        self.gradient?.addAnimation(animation, forKey:"animateGradient")
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        self.toColors = self.fromColors;
        self.fromColors = self.gradient?.colors
        
        animateLayer()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stickerArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell 	{
        let cell:detailCell = self.tableVIew.dequeueReusableCellWithIdentifier("cell2") as! detailCell
        let newSticker = stickerArr[indexPath.row]
        cell.cellImage.image = UIImage(named: "\(newSticker.img)")
        cell.cellTitle.text = "\(newSticker.title)"
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Row \(indexPath.row) selected")
        
        selectedSticker = stickerArr[indexPath.row]
        self.performSegueWithIdentifier("toPhoto2", sender: self)
        
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toPhoto2") {
            let secondViewController = segue.destinationViewController as! filterController
            
            secondViewController.currentSticker = selectedSticker
        }
    }
    
    // 5
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 85
    }

    
    
    
    
    
}
