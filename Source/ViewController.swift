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
        self.view.addSubview(TappableImageView(frame:CGRect(x: (375-200)/2, y: 25, width: 200, height: 200)));
        
        //#2 - Fade (swap)
        self.view.addSubview(TappableImageSwapView(frame:CGRect(x: (375-100)/2, y: 235, width: 100, height: 100)));
        
        //#3 - Fade (general)
        self.view.addSubview(FadingImageView(frame:CGRect(x: (375-200)/2, y: 350, width: 200, height: 200)));

        //#4 - Scaled Image
        self.view.addSubview(self.getScaledImage(0.2));         //put any positive number desired here. Best examples are 0.2, 0.4 & 2.0

        //#5 - Colored Image
        self.view.addSubview(self.getTintedImage());
            
        print("ViewController.viewDidLoad():       viewDidLoad() complete");
        
        return;
    }

    
    //the plain, simple load
    func loadImage(_ view:UIView, imageStr:String) {
        
        let width  : CGFloat = 206;
        let height : CGFloat = 190;
        let xCoord : CGFloat = 50;
        let yCoord : CGFloat = 200;
        
        var imageView : UIImageView;
        
        imageView  = UIImageView();
        
        imageView.frame = CGRect(x: xCoord, y: yCoord, width: width, height: height);
        
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
        
        let xCoord : CGFloat = (UIScreen.main.bounds.width-86)/2 + 100;         /* offset '+100' to the right of center     */
        
        image = UIImage(named: "empty")!;
        
        let size  : CGSize = image.size;
        let frame : CGRect = CGRect(x: xCoord, y: 600, width: size.width, height: size.height);
        
        let redCover : UIView = UIView(frame: frame);
        
        redCover.backgroundColor = UIColor.red;
        redCover.layer.opacity = 0.75;
        
        imageView       = UIImageView();
        imageView.image = image.withRenderingMode(UIImageRenderingMode.automatic);
        
        imageView.addSubview(redCover);
        
        return imageView;
    }


    //scale the image from 0 to 1 on scale input
    func getScaledImage(_ scale : CGFloat) -> UIImageView {
        var image     : UIImage;
        var tempImageView : UIImageView;
        
        let xCoord : CGFloat = (UIScreen.main.bounds.width-86)/2 - 100;         /* offset '-100' to the right of center     */

        image = UIImage(named: "animal_1")!;
        
        let newWidth  : CGFloat = scale * image.size.width;
        let newHeight : CGFloat = scale * image.size.height;
        
//      print("Current Image Size is \(image.size.width), \(image.size.height)");
//      print("    New Image Size is \(newWidth), \(newHeight)");

        tempImageView       = UIImageView();
        tempImageView.image = image.withRenderingMode(UIImageRenderingMode.automatic);
        
        tempImageView.contentMode = .scaleAspectFit;
        
        tempImageView.frame = CGRect(x: xCoord, y: 600, width: newWidth, height: newHeight);
        
        return tempImageView;
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();

        return;
    }
}

