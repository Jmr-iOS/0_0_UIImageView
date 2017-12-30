//
//  ViewController.swift
//  0_0 - UIImageView
//
//  URL: http://stackoverflow.com/questions/11355671/how-do-i-implement-the-uitapgesturerecognizer-into-my-application
//  URL: https://developer.apple.com/library/ios/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/GestureRecognizer_basics/GestureRecognizer_basics.html
//
//  @section    Opens
//      File Headers
//      Function Headers
//      Image size auto-detected & applied
//      loadImage() uses imageStr (B)
//      loadImage() loads image size directly (B)

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
        
        //#4 - Scaled ImageView
        self.view.addSubview(self.getScaledImageView(0.2));

        //#5 - Colored Image
        self.view.addSubview(self.getTintedImage());
            
        print("ViewController.viewDidLoad():       viewDidLoad() complete");
        
        return;
    }

    
    //the plain, simple load
    @objc func loadImage(_ view:UIView, imageStr:String) {
        
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
    @objc func getTintedImage() -> UIImageView {
        
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
    @objc func getScaledImageView(_ scale : CGFloat) -> UIImageView {
        var image     : UIImage;
        var imageView : UIImageView;
        
        let xCoord : CGFloat = (UIScreen.main.bounds.width-86)/2 - 100;         /* offset '-100' to the right of center     */

        image = UIImage(named: "animal_1")!;
        
        let newWidth  : CGFloat = scale * image.size.width;
        let newHeight : CGFloat = scale * image.size.height;
        
        //print("Current Image Size is \(image.size.width), \(image.size.height)");
        //print("    New Image Size is \(newWidth), \(newHeight)");

        imageView       = UIImageView();
        imageView.image = image.withRenderingMode(UIImageRenderingMode.automatic);
        
        imageView.contentMode = .scaleAspectFit;
        
        imageView.frame = CGRect(x: xCoord, y: 600, width: newWidth, height: newHeight);
        
        return imageView;
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();

        return;
    }
}


//@brief    Allow Re-sizing of image directly
//@ref      https://stackoverflow.com/questions/2658738/the-simplest-way-to-resize-an-uiimage
extension UIImage {
    
    func scaledImage(withSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
        defer { UIGraphicsEndImageContext(); }
        draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height));
        return UIGraphicsGetImageFromCurrentImageContext()!;
    }
    
    func scaleImageToFitSize(size: CGSize) -> UIImage {
        let aspect = self.size.width / self.size.height;
        if size.width / aspect <= size.height {
            return scaledImage(withSize: CGSize(width: size.width, height: size.width / aspect));
        } else {
            return scaledImage(withSize: CGSize(width: size.height * aspect, height: size.height));
        }
    }
    
}
