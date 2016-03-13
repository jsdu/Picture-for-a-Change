//
//  filterController.swift
//  OneWord
//
//  Created by Jason Du on 2016-03-12.
//  Copyright © 2016 Jason Du. All rights reserved.
//

import UIKit
import Social

class filterController: UIViewController {
    @IBOutlet var facebook: UIButton!
    @IBOutlet var twitter: UIButton!
    @IBOutlet var back: UIButton!
    @IBOutlet var home: UIButton!
    
    var currentSticker: sticker?
    
    @IBOutlet var currentImageView: UIImageView!
    
    @IBOutlet var actualImage: UIImageView!
    

    @IBAction func tweet(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
            
            let tweetShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            tweetShare.addImage(compositeImage(actualImage.image!, image2: currentImageView.image!))
            self.presentViewController(tweetShare, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Twitter account to tweet.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func share(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            let fbShare:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            fbShare.addImage(compositeImage(actualImage.image!, image2: currentImageView.image!))
            self.presentViewController(fbShare, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "Accounts", message: "Please login to a Facebook account to share.", preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func compositeImage(image1: UIImage, image2: UIImage) -> UIImage {
        let size = CGSize(width: image1.size.width, height: image1.size.height)
        UIGraphicsBeginImageContext(size)
        
        let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        image1.drawInRect(areaSize)
        
        image2.drawInRect(areaSize, blendMode: CGBlendMode.Normal, alpha: 1)
        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        facebook.layer.cornerRadius = 5
        facebook.layer.borderWidth = 1
        facebook.layer.borderColor = UIColor.whiteColor().CGColor
        facebook.titleEdgeInsets = UIEdgeInsetsMake(0, 2.0, 0, 2.0)
        
        let blur = UIVisualEffectView(effect: UIBlurEffect(style:
            UIBlurEffectStyle.Light))
        blur.frame = facebook.bounds
        blur.userInteractionEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
        facebook.insertSubview(blur, atIndex: 0)
        
        twitter.layer.cornerRadius = 5
        twitter.layer.borderWidth = 1
        twitter.layer.borderColor = UIColor.whiteColor().CGColor
        twitter.titleEdgeInsets = UIEdgeInsetsMake(0, 2.0, 0, 2.0)
        
        let blur2 = UIVisualEffectView(effect: UIBlurEffect(style:
            UIBlurEffectStyle.Light))
        blur2.frame = facebook.bounds
        blur2.userInteractionEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
        twitter.insertSubview(blur2, atIndex: 0)
        
        back.layer.cornerRadius = 5
        back.layer.borderWidth = 1
        back.layer.borderColor = UIColor.whiteColor().CGColor
        back.titleEdgeInsets = UIEdgeInsetsMake(0, 2.0, 0, 2.0)
        
        let blur3 = UIVisualEffectView(effect: UIBlurEffect(style:
            UIBlurEffectStyle.Light))
        blur3.frame = back.bounds
        blur3.userInteractionEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
        back.insertSubview(blur3, atIndex: 0)
        
        home.layer.cornerRadius = 5
        home.layer.borderWidth = 1
        home.layer.borderColor = UIColor.whiteColor().CGColor
        home.titleEdgeInsets = UIEdgeInsetsMake(0, 2.0, 0, 2.0)
        
        let blur4 = UIVisualEffectView(effect: UIBlurEffect(style:
            UIBlurEffectStyle.Light))
        blur4.frame = home.bounds
        blur4.userInteractionEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
        home.insertSubview(blur4, atIndex: 0)

        
    }
    
    override func viewDidAppear(animated: Bool) {
    //    print("\(currentSticker?.filterImg)")
        currentImageView.image = UIImage(named: "\((currentSticker?.filterImg)!)")
        actualImage.image = sData.sharedInstance.imageTaken
    }
}
