/************************************************************************************************************************************/
/** @file       ViewController.swift
 *  @project    0_0 - UIImageView
 *  @brief      x
 *  @details    x
 *
 *  @author     Justin Reina, Firmware Engineer, Jaostech
 *  @created    x
 *  @last rev   1/21/18
 *
 *  @section    Reference
 *      http://stackoverflow.com/questions/11355671/how-do-i-implement-the-uitapgesturerecognizer-into-my-application
 *      https://developer.apple.com/library/ios/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/GestureRecognizer_basics/GestureRecognizer_basics.html
 *      http://stackoverflow.com/questions/24046898/how-do-i-create-a-new-swift-project-without-using-storyboards
 *      http://stackoverflow.com/questions/24030348/how-to-create-a-button-programmatically
 *      http://stackoverflow.com/questions/24102191/make-a-uibutton-programatically-in-swift
 *      http://stackoverflow.com/questions/26569371/how-do-you-create-a-uiimage-view-programmatically-swift (M)
 *
 *  @notes        x
 *
 *  @section    Opens
 *      Function Headers
 *      Image size auto-detected & applied
 *      loadImage() uses imageStr (B)
 *      loadImage() loads image size directly (B)
 *      load array of pics demo
 *      scaling options (to fit, to scale, to loc, etc.)
 *
 *  @section    Legal Disclaimer
 *      All contents of this source file and/or any other Jaostech related source files are the explicit property of Jaostech
 *      Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class ViewController: UIViewController {

    
    /********************************************************************************************************************************/
    /** @fcn        viewDidLoad()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
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

    
    /********************************************************************************************************************************/
    /** @fcn        loadImage(_ view:UIView, imageStr:String)
     *  @brief      the plain, simple load
     *  @details    x
     */
    /********************************************************************************************************************************/
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
    
    
    /********************************************************************************************************************************/
    /** @fcn        getTintedImage() -> UIImageView
     *  @brief      apply a color to an image
     *  @details    x
     *
     *  @section    Reference
     *      http://stackoverflow.com/questions/28427935/how-can-i-change-image-tintcolor
     *      https://www.captechconsulting.com/blogs/ios-7-tutorial-series-tint-color-and-easy-app-theming
     */
    /********************************************************************************************************************************/
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


    /********************************************************************************************************************************/
    /** @fcn        getScaledImageView(_ scale : CGFloat) -> UIImageView
     *  @brief      scale the image from 0 to 1 on scale input
     *  @details    x
     */
    /********************************************************************************************************************************/
    func getScaledImageView(_ scale : CGFloat) -> UIImageView {
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


    /********************************************************************************************************************************/
    /** @fcn        override func didReceiveMemoryWarning()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();

        return;
    }
}


/************************************************************************************************************************************/
/** @ext        extension UIImage
 *  @brief      Allow Re-sizing of images directly
 *  @details    x
 *
 *  @section    Reference
 *      https://stackoverflow.com/questions/2658738/the-simplest-way-to-resize-an-uiimage
 *
 */
/************************************************************************************************************************************/
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
            return scaledImage(withSize: CGSize(width: (size.height * aspect), height: size.height));
        }
    }
    
}

