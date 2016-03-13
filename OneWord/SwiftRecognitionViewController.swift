//
//  SwiftRecognitionViewController.swift
//  ClarifaiApiDemo
//

import UIKit
import ALCameraViewController
import Foundation
import Social

/**
 * This view controller performs recognition using the Clarifai API.
 */
class SwiftRecognitionViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var progress: UILabel!
    @IBOutlet var circleLabel: UIImageView!
    @IBOutlet var Continue: UIButton!
    
    @IBOutlet var takePicture: UIButton!
    
    @IBOutlet var submitButton: UIButton!
    @IBOutlet var retake: UIButton!
    
    @IBOutlet var takePictureLabel: UILabel!
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var label5: UILabel!
    @IBOutlet var label6: UILabel!
    @IBOutlet var label7: UILabel!
    @IBOutlet var label8: UILabel!
    @IBOutlet var label9: UILabel!
    
    @IBOutlet var animate1: SpringImageView!
    
    @IBOutlet var animate2: SpringImageView!
    
    @IBOutlet var animate3: SpringImageView!
    
    @IBOutlet var animate4: SpringImageView!
    
    @IBOutlet var animate5: SpringImageView!
    
    @IBOutlet var animate6: SpringImageView!
    
    @IBOutlet var animate7: SpringImageView!
    
    @IBOutlet var animate8: SpringImageView!
    
    @IBOutlet var animate9: SpringImageView!
    
    var gradient : CAGradientLayer?
    var toColors : AnyObject?
    var fromColors : AnyObject?
    
    var imageArr: [UIImage] = []
    
    var tagsArr: [String] = []
    
    @IBOutlet var cameraImage: UIImageView!
    var cameraDisplay: Bool = true
    // IMPORTANT NOTE: you should replace these keys with your own App ID and secret.
    // These can be obtained at https://developer.clarifai.com/applications
    static let appID = "S7xvLK8H7sqpdC8dPn8jrrw0VsEx9vYl57nL0xpy"
    static let appSecret = "JRIlcUb5q6hNVF33cX-bJQfXngUkqSBc2eNQEjyp"

    // Custom Training (Alpha): to predict against a custom concept (instead of the standard
    // tag model), set this to be the name of the concept you wish to predict against. You must
    // have previously trained this concept using the same app ID and secret as above. For more
    // info on custom training, see https://github.com/Clarifai/hackathon
    static let conceptName: String? = nil
    static let conceptNamespace = "default"

    @IBOutlet weak var imageView: UIImageView!

    private lazy var client : ClarifaiClient = {
        let c = ClarifaiClient(appID: appID, appSecret: appSecret)
        // Uncomment this to request embeddings. Contact us to enable embeddings for your app:
        // c.enableEmbed = true
        return c
    }()

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            // The user picked an image. Send it Clarifai for recognition.
            imageView.image = image
            recognizeImage(image)
        }
    }

    private func recognizeImage(image: UIImage!) {
        // Scale down the image. This step is optional. However, sending large images over the
        // network is slow and does not significantly improve recognition performance.
        let size = CGSizeMake(320, 320 * image.size.height / image.size.width)
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        // Encode as a JPEG.
        let jpeg = UIImageJPEGRepresentation(scaledImage, 0.9)!

        if SwiftRecognitionViewController.conceptName == nil {
            // Standard Recognition: Send the JPEG to Clarifai for standard image tagging.
            client.recognizeJpegs([jpeg]) {
                (results: [ClarifaiResult]?, error: NSError?) in
                if error != nil {
                    print("Error: \(error)\n")
                    print("Sorry, there was an error recognizing your image.")
                } else {
                    self.tagsArr = results![0].tags
                    
                    self.label1.text = self.tagsArr[0]
                    self.label2.text = self.tagsArr[1]
                    self.label3.text = self.tagsArr[2]
                    self.label4.text = self.tagsArr[3]
                    self.label5.text = self.tagsArr[4]
                    self.label6.text = self.tagsArr[5]
                    self.label7.text = self.tagsArr[6]
                    self.label8.text = self.tagsArr[7]
                    self.label9.text = self.tagsArr[8]
                    
                    self.animate1.animation = "fadeIn"
                    self.animate1.duration = 2.0
                    self.animate1.animate()
                    
                    self.animate2.animation = "fadeIn"
                    self.animate2.duration = 2.0
                    self.animate2.animate()
                    
                    self.animate3.animation = "fadeIn"
                    self.animate3.duration = 2.0
                    self.animate3.animate()
                    
                    self.animate4.animation = "fadeIn"
                    self.animate4.duration = 2.0
                    self.animate4.animate()
                    
                    self.animate5.animation = "fadeIn"
                    self.animate5.duration = 2.0
                    self.animate5.animate()
                    
                    self.animate6.animation = "fadeIn"
                    self.animate6.duration = 2.0
                    self.animate6.animate()
                    
                    self.animate7.animation = "fadeIn"
                    self.animate7.duration = 2.0
                    self.animate7.animate()
                    print(self.tagsArr)

                    self.animate8.animation = "fadeIn"
                    self.animate8.duration = 2.0
                    self.animate8.animate()
                    
                    self.animate9.animation = "fadeIn"
                    self.animate9.duration = 2.0
                    self.animate9.animate()
                    
                    let delay = 4.5 * Double(NSEC_PER_SEC)
                    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
                    dispatch_after(time, dispatch_get_main_queue()) {
                        sData.sharedInstance.tagsArr = self.tagsArr

                        self.progress.text = "Continue"
                        self.Continue.enabled = true
                    }
                }
            }
        } else {
            // Custom Training: Send the JPEG to Clarifai for prediction against a custom model.
            client.predictJpegs([jpeg], conceptNamespace: SwiftRecognitionViewController.conceptNamespace, conceptName: SwiftRecognitionViewController.conceptName) {
                (results: [ClarifaiPredictionResult]?, error: NSError?) in
                if error != nil {
                    print("Error: \(error)\n")
                    print("Sorry, there was an error running prediction on your image.")
                } else {
                    print("Prediction score for \(SwiftRecognitionViewController.conceptName!):\n\(results![0].score)")
                }
            }
        }
    }
    

    
    @IBAction func takePicture(sender: AnyObject) {
        
        let cameraViewController = ALCameraViewController(croppingEnabled: false, allowsLibraryAccess: true) { (image) -> Void in
            self.imageView.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        presentViewController(cameraViewController, animated: true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        if ((imageView.image) == nil){
            takePictureLabel.hidden = false
            takePicture.hidden = false
            cameraImage.hidden = false
            
            submitButton.hidden = true
            retake.hidden = true
        } else {
            takePictureLabel.hidden = true
            takePicture.hidden = true
            cameraImage.hidden = true
            
            submitButton.hidden = false
            retake.hidden = false
        }

        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        retake.layer.cornerRadius = 5
        retake.layer.borderWidth = 1
        retake.layer.borderColor = UIColor.whiteColor().CGColor
        retake.titleEdgeInsets = UIEdgeInsetsMake(0, 2.0, 0, 2.0)
        
        let blur = UIVisualEffectView(effect: UIBlurEffect(style:
            UIBlurEffectStyle.Light))
        blur.frame = retake.bounds
        blur.userInteractionEnabled = false
        retake.insertSubview(blur, atIndex: 0)

        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = UIColor.whiteColor().CGColor
        submitButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2.0, 0, 2.0)
        
        let blur2 = UIVisualEffectView(effect: UIBlurEffect(style:
            UIBlurEffectStyle.Light))
        blur2.frame = submitButton.bounds
        blur2.userInteractionEnabled = false
        // Do any additional setup after loading the view, typically from a nib.
        submitButton.insertSubview(blur2, atIndex: 0)
        
        let backblur = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let blurView = UIVisualEffectView(effect: backblur)
        blurView.frame = self.view.bounds
        view.insertSubview(blurView, atIndex: 0)
        
        self.gradient = CAGradientLayer()
        self.gradient?.frame = self.view.bounds
        self.gradient?.colors = [UIColor.orangeColor().CGColor, UIColor.redColor().CGColor]
        self.view.layer.insertSublayer(self.gradient!, atIndex: 0)
        
        self.toColors = [UIColor.redColor().CGColor, UIColor.purpleColor().CGColor]
        animateLayer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    @IBAction func submit(sender: AnyObject) {
        if (imageView.image != nil) {
            recognizeImage(imageView.image)
            sData.sharedInstance.imageTaken = imageView.image
            Continue.hidden = false
            imageView.hidden = true
            submitButton.hidden = true
            retake.hidden = true
            circleLabel.hidden = false
            progress.hidden = false
            Continue.enabled = false
        }
    }
    
    
}
