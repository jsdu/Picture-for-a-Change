//
//  SelectionController.swift
//  OneWord
//
//  Created by Jason Du on 2016-03-12.
//  Copyright © 2016 Jason Du. All rights reserved.
//

import UIKit

class SelectionController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var seeAll: UIButton!

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var topic: UILabel!
    
    var gradient : CAGradientLayer?
    var toColors : AnyObject?
    var fromColors : AnyObject?
    var selectedSticker : sticker?
    var filterArr : [sticker] = []
    var strTopic = ""
    var stickerTitleArr = ["NHacks","Gay Pride","Breast Cancer","Bernie Sanders","Donald Trump","Clarifai","Pepsi","Toaster Filter", "Hefe Filter", "Willow Filter", "Neutral Filter", "Rainbow Filter", "Hillary Clinton", "World Wildlife Fund", "Heart & Stroke Foundation"]
    var stickerLabelArr = [["technology","computer","laptop", "events"],
                            ["celebration","events"],
                            ["charity"],
                            ["politics"],
                            ["politics"],
                            ["sponsors"],
                            ["sponsors"],
                            ["portrait"],
                            ["portrait"],
                            ["portrait"],
                            ["portrait"],
                            ["portrait"],
                            ["politics"],
                            ["charity"],
                            ["charity"]]
    var stickerImgArr = ["logo_nhacks",
        "logo_gayPride",
        "logo_breastCancer",
        "logo_bernie",
        "logo_trump",
        "logo_clarifai",
        "logo_pepsi",
        "logo_toaster",
        "logo_hefe",
        "logo_willow",
        "logo_neutral",
        "logo_rainbow",
        "logo_hillary",
        "logo_wwf",
        "logo_heart"]
    var stickerFilterImgArr = ["nhacks",
        "gayPride",
        "breastCancer",
        "bernie",
        "trump",
        "clarifai",
        "pepsi",
        "toaster",
        "hefe",
        "willow",
        "neutral",
        "rainbow",
        "hillary",
        "wwf",
        "heart"]
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent

        seeAll.layer.cornerRadius = 5
        seeAll.layer.borderWidth = 1
        seeAll.layer.borderColor = UIColor.whiteColor().CGColor
        seeAll.titleEdgeInsets = UIEdgeInsetsMake(0, 2.0, 0, 2.0)
        
        let blur3 = UIVisualEffectView(effect: UIBlurEffect(style:
            UIBlurEffectStyle.Light))
        blur3.frame = seeAll.bounds
        blur3.userInteractionEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
        seeAll.insertSubview(blur3, atIndex: 0)

        
        
        let backblur = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurView = UIVisualEffectView(effect: backblur)
        blurView.frame = self.view.bounds
        view.insertSubview(blurView, atIndex: 0)
        self.gradient = CAGradientLayer()
        self.gradient?.frame = self.view.bounds
        self.gradient?.colors = [UIColor.blackColor().CGColor, UIColor.blueColor().CGColor]
        self.view.layer.insertSublayer(self.gradient!, atIndex: 0)
        
        self.toColors = [UIColor.purpleColor().CGColor, UIColor.blueColor().CGColor]
        animateLayer()
        
        if (!sData.sharedInstance.didLoad) {
            for (var i = 0; i < stickerImgArr.count; i++) {
                let sticker1 = sticker()
                sticker1.filterImg = stickerFilterImgArr[i]
                sticker1.img = stickerImgArr[i]
                sticker1.label = stickerLabelArr[i]
                sticker1.title = stickerTitleArr[i]
                sData.sharedInstance.stickerArr.append(sticker1)
            }
            sData.sharedInstance.didLoad = true
        }
        
        if (sData.sharedInstance.tagsArr.contains("technology")){
            strTopic = "technology"
        } else if (sData.sharedInstance.tagsArr.contains("portrait")){
            strTopic = "portrait"
        } else if (sData.sharedInstance.tagsArr.contains("event")){
            strTopic = "event"
        } else if (sData.sharedInstance.tagsArr.contains("nature")){
            strTopic = "nature"
        } else if (sData.sharedInstance.tagsArr.contains("politics")){
            strTopic = "politics"
        } else if (sData.sharedInstance.tagsArr.contains("charity")){
            strTopic = "charity"
        } else {
            strTopic = sData.sharedInstance.tagsArr[0]
        }
        
        topic.text = strTopic
        
        for items in sData.sharedInstance.stickerArr {
            if (items.label.contains(strTopic)){
                filterArr.append(items)
            }
        }
        
    }
    override func viewWillAppear(animated: Bool) {
        animateTable()
    }
    
    func animateTable() {
        tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            UIView.animateWithDuration(1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransformMakeTranslation(0, 0);
                }, completion: nil)
            
            index += 1
        }
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


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterArr.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell 	{
        let cell:customCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! customCell
        let newSticker = filterArr[indexPath.row]
        cell.cellImage.image = UIImage(named: "\(newSticker.img)")
        cell.cellTitle.text = "\(newSticker.title)"
        return cell
        
    }
    
    // 4
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Row \(indexPath.row) selected")
        
        selectedSticker = filterArr[indexPath.row]
        self.performSegueWithIdentifier("toPhoto", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "toPhoto") {
        let secondViewController = segue.destinationViewController as! filterController
        
        secondViewController.currentSticker = selectedSticker
        }
    }
    
    // 5
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 85
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
