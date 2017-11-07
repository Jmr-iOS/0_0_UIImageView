//
//  ViewController.swift
//  0_0 - UIImageView
//
//  URL: http://stackoverflow.com/questions/11355671/how-do-i-implement-the-uitapgesturerecognizer-into-my-application
//  URL: https://developer.apple.com/library/ios/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/GestureRecognizer_basics/GestureRecognizer_basics.html
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.view.translatesAutoresizingMaskIntoConstraints = false;
        
        //#0 - Basic
        //self.loadImage(self.view, imageStr:"example");
        
        //#1 - Tap Handling
        self.view.addSubview(TappableImageView(frame:CGRectMake((375-200)/2, 25, 200, 200)));
        
        //#2 - Fade (swap)
        self.view.addSubview(TappableImageSwapView(frame:CGRectMake((375-100)/2, 235, 100, 100)));
        
        //#3 - Fade (general)
        self.view.addSubview(FadingImageView(frame:CGRectMake((375-200)/2, 350, 200, 200)));

        //#4 - Scaled Image
        self.view.addSubview(self.getScaledImage(0.2));         //put any positive number desired here. Best examples are 0.2, 0.4 & 2.0

        //#5 - Colored Image
        self.view.addSubview(self.getTintedImage());
            
        print("ViewController.viewDidLoad():       viewDidLoad() complete");
        
        return;
    }

    
    //the plain, simple load
    func loadImage(view:UIView, imageStr:String) {
        
        let width  : CGFloat = 206;
        let height : CGFloat = 190;
        let xCoord : CGFloat = 50;
        let yCoord : CGFloat = 200;
        
        var imageView : UIImageView;
        
        imageView  = UIImageView();
        
        imageView.frame = CGRectMake(xCoord, yCoord, width, height);
        
        imageView.image = UIImage(named:"example");
        
        view.addSubview(imageView);
        
        return;
    }
    
    
    //apply a color to an image
    //ref - http://stackoverflow.com/questions/28427935/how-can-i-change-image-tintcolor
    //ref - https://www.captechconsulting.com/blogs/ios-7-tutorial-series-tint-color-and-easy-app-theming
    func getTintedImage() -> UIImageView {
        
        var image     : UIImage;
        var imageView : UIImageView;
        
        let xCoord : CGFloat = (UIScreen.mainScreen().bounds.width-86)/2 + 100;         /* offset '+100' to the right of center     */
        
        image = UIImage(named: "empty")!;
        
        let size  : CGSize = image.size;
        let frame : CGRect = CGRectMake(xCoord, 600, size.width, size.height);
        
        let redCover : UIView = UIView(frame: frame);
        
        redCover.backgroundColor = UIColor.redColor();
        redCover.layer.opacity = 0.75;
        
        imageView       = UIImageView();
        imageView.image = image.imageWithRenderingMode(UIImageRenderingMode.Automatic);
        
        imageView.addSubview(redCover);
        
        return imageView;
    }


    //scale the image from 0 to 1 on scale input
    func getScaledImage(scale : CGFloat) -> UIImageView {
        var image     : UIImage;
        var tempImageView : UIImageView;
        
        let xCoord : CGFloat = (UIScreen.mainScreen().bounds.width-86)/2 - 100;         /* offset '-100' to the right of center     */

        image = UIImage(named: "animal_1")!;
        
        let newWidth  : CGFloat = scale * image.size.width;
        let newHeight : CGFloat = scale * image.size.height;
        
//      print("Current Image Size is \(image.size.width), \(image.size.height)");
//      print("    New Image Size is \(newWidth), \(newHeight)");

        tempImageView       = UIImageView();
        tempImageView.image = image.imageWithRenderingMode(UIImageRenderingMode.Automatic);
        
        tempImageView.contentMode = .ScaleAspectFit;
        
        tempImageView.frame = CGRectMake(xCoord, 600, newWidth, newHeight);
        
        return tempImageView;
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();

        return;
    }
}

