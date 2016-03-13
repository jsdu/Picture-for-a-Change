//
//  menuController.swift
//  OneWord
//
//  Created by Jason Du on 2016-03-12.
//  Copyright © 2016 Jason Du. All rights reserved.
//

import UIKit

class menuController: UIViewController {

    @IBOutlet var charity: UIButton!
    
    @IBOutlet var politics: UIButton!
    
    @IBOutlet var events: UIButton!
    
    @IBOutlet var sponsors: UIButton!
    
    @IBOutlet var filters: UIButton!
    
    
    var topic : String?
    var gradient : CAGradientLayer?
    var toColors : AnyObject?
    var fromColors : AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        let backblur = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurView = UIVisualEffectView(effect: backblur)
        blurView.frame = self.view.bounds
        view.insertSubview(blurView, atIndex: 0)
        
        self.gradient = CAGradientLayer()
        self.gradient?.frame = self.view.bounds
        self.gradient?.colors = [UIColor.purpleColor().CGColor, UIColor.blueColor().CGColor]
        self.view.layer.insertSublayer(self.gradient!, atIndex: 0)
        
        self.toColors = [UIColor.blueColor().CGColor, UIColor.purpleColor().CGColor]
        animateLayer()
        
        charity.layer.cornerRadius = 5
        charity.layer.borderWidth = 1
        charity.layer.borderColor = UIColor.whiteColor().CGColor
        charity.titleEdgeInsets = UIEdgeInsetsMake(0, 2.0, 0, 2.0)
        
        let blur = UIVisualEffectView(effect: UIBlurEffect(style:
            UIBlurEffectStyle.Light))
        blur.frame = charity.bounds
        blur.userInteractionEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
        charity.insertSubview(blur, atIndex: 0)
        
        politics.layer.cornerRadius = 5
        politics.layer.borderWidth = 1
        politics.layer.borderColor = UIColor.whiteColor().CGColor
        politics.titleEdgeInsets = UIEdgeInsetsMake(0, 2.0, 0, 2.0)
        
        let blur2 = UIVisualEffectView(effect: UIBlurEffect(style:
            UIBlurEffectStyle.Light))
        blur2.frame = politics.bounds
        blur2.userInteractionEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
        politics.insertSubview(blur2, atIndex: 0)
        
        events.layer.cornerRadius = 5
        events.layer.borderWidth = 1
        events.layer.borderColor = UIColor.whiteColor().CGColor
        events.titleEdgeInsets = UIEdgeInsetsMake(0, 2.0, 0, 2.0)
        
        let blur3 = UIVisualEffectView(effect: UIBlurEffect(style:
            UIBlurEffectStyle.Light))
        blur3.frame = events.bounds
        blur3.userInteractionEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
        events.insertSubview(blur3, atIndex: 0)

        sponsors.layer.cornerRadius = 5
        sponsors.layer.borderWidth = 1
        sponsors.layer.borderColor = UIColor.whiteColor().CGColor
        sponsors.titleEdgeInsets = UIEdgeInsetsMake(0, 2.0, 0, 2.0)
        
        let blur4 = UIVisualEffectView(effect: UIBlurEffect(style:
            UIBlurEffectStyle.Light))
        blur4.frame = sponsors.bounds
        blur4.userInteractionEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
        sponsors.insertSubview(blur4, atIndex: 0)

        
        filters.layer.cornerRadius = 5
        filters.layer.borderWidth = 1
        filters.layer.borderColor = UIColor.whiteColor().CGColor
        filters.titleEdgeInsets = UIEdgeInsetsMake(0, 2.0, 0, 2.0)
        
        let blur5 = UIVisualEffectView(effect: UIBlurEffect(style:
            UIBlurEffectStyle.Light))
        blur5.frame = sponsors.bounds
        blur5.userInteractionEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
        filters.insertSubview(blur5, atIndex: 0)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toDetailView") {
            let secondViewController = segue.destinationViewController as! detailTableController
            
            secondViewController.topic = self.topic!
        }
    }

    @IBAction func charityButton(sender: AnyObject) {
        self.topic = "charity"
        self.performSegueWithIdentifier("toDetailView", sender: self)

    }
    
    @IBAction func politicsButton(sender: AnyObject) {
        self.topic = "politics"
        self.performSegueWithIdentifier("toDetailView", sender: self)
    }
    
    
    @IBAction func eventsButton(sender: AnyObject) {
        self.topic = "events"
        self.performSegueWithIdentifier("toDetailView", sender: self)
    }
    
    
    @IBAction func sponsors(sender: AnyObject) {
        self.topic = "sponsors"
        self.performSegueWithIdentifier("toDetailView", sender: self)
    }
    
    
    
    @IBAction func filters(sender: AnyObject) {
        self.topic = "portrait"
        self.performSegueWithIdentifier("toDetailView", sender: self)
    }
    
    
    
    
}
