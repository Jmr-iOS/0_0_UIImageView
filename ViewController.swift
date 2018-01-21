/************************************************************************************************************************************/
/** @file       ViewController.swift
 *  @project    0_0 - UIImageView
 *  @brief      x
 *  @details    x
 *
 *  @author     Justin Reina, Firmware Engineer, Jaostech
 *  @created    11/22/17
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
 *      none listed
 *
 *  @section    Legal Disclaimer
 *      All contents of this source file and/or any other Jaostech related source files are the explicit property of Jaostech
 *      Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit

//Config
let verbose : Bool = true;


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
        self.loadImage(self.view, image: getImage(), scale: 0.25);
        
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
            
        if(verbose) { print("ViewController.viewDidLoad():       viewDidLoad() complete"); }
        
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        loadImage(_ view : UIView, image : UIImage)
     *  @brief      the plain, simple load
     *  @details    x
     *
     *  @param      [in] (UIView)  view -  view for insertion
     *  @param      [in] (UIImage) image - image for insertion
     *
     */
    /********************************************************************************************************************************/
    func loadImage(_ view : UIView, image : UIImage, scale : CGFloat) {
        let xCoord : CGFloat = 50;
        let yCoord : CGFloat = 200;
        
        let imageView : UIImageView = getScaledImageView(scale);
        
        imageView.center = CGPoint(x: xCoord, y: yCoord);
        
        imageView.image = image;
        
        view.addSubview(imageView);

        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        getImagePaths() -> [String]?
     *  @brief      x
     *  @details    x
     *
     *  @return     ([String]?) all local images found on phone
     *
     *  @section    Supported Types
     *      png, jpg, jpeg
     */
    /********************************************************************************************************************************/
    func getImagePaths() -> [String] {
        
        var rslts = [String]();
        
        let x = Bundle.main.bundleURL;
        let fileEnumerator = FileManager.default.enumerator(at: x, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions());
        
        while let file = fileEnumerator?.nextObject() {
            let s : String = (file as! NSURL).lastPathComponent!;
            
            var type = (file as! NSURL).pathExtension;
            type = type?.lowercased();                                  /* handle both cases                                        */

            let valid : Bool = ((type?.contains("png"))! || (type?.contains("jpg"))! || (type?.contains("jpeg"))!);
            
            //Append
            if(valid) {
                rslts.append(s);
            }
        }
        
        return rslts;
    }
    

    /********************************************************************************************************************************/
    /** @fcn        getImage(_ i : Int?) -> UIImage?
     *  @brief      load the file named
     *  @details    x
     *
     *  @param      [in] (Int?) i - index of image
     *  @return     (UIImage) selected image in array
     *
     */
    /********************************************************************************************************************************/
    func getImage(_ i : Int = -1) -> UIImage {
        
        let img : UIImage;
        let paths : [String]
        var filePath : String?;
        
        
        //Init
        paths = getImagePaths();
        
        //Find example path
        for p in paths {
            if(p.contains("example")) {
                filePath = p;
            }
        }
        
        //If not found
        if(filePath == nil) {
            filePath = paths[0];
        }
        
        //Grab image
        img = UIImage(named: filePath!)!;
        
        return img;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        getTintedImage() -> UIImageView
     *  @brief      apply a color to an image
     *  @details    x
     *
     *  @return     (UIImageView) tinted imageview
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
     *
     *  @param      [in] (CGFloat) scale - scale to apply to imageview (0..1)
     *
     *  @return     (UIImageView) scaled imageview
     */
    /********************************************************************************************************************************/
    func getScaledImageView(_ scale : CGFloat) -> UIImageView {
        var image     : UIImage;
        var imageView : UIImageView;
        
        let xCoord : CGFloat = (UIScreen.main.bounds.width-86)/2 - 100;                 /* offset '-100' to the right of center     */

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
    /** @fcn        getScaledImage(image: UIImage, scale: CGFloat) -> UIImageView
     *  @brief      scale the image from 0 to 1 on scale input
     *  @details    similar to getScaledImageView() but easier to take for use
     *
     *  @param      [in] (UIImage) image - image to scale
     *  @param      [in] (CGFloat) scale - scale value (0..1)
     *
     *  @return     (UIImageView) scaled imageview containing image
     *
     *  @note       recommended method for scaling is UIImageView
     */
    /********************************************************************************************************************************/
    func getScaledImage(image: UIImage, scale: CGFloat) -> UIImageView {
        var imageView : UIImageView;
        
        let newWidth  : CGFloat = scale * image.size.width;
        let newHeight : CGFloat = scale * image.size.height;
        
        imageView       = UIImageView();
        imageView.image = image.withRenderingMode(UIImageRenderingMode.automatic);
        
        imageView.contentMode = .scaleAspectFit;
        
        //init size for scale
        imageView.frame = CGRect(x: 0, y: 0, width: newWidth, height: newHeight);
        
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
    
    /********************************************************************************************************************************/
    /** @fcn        scaledImage(withSize size: CGSize) -> UIImage
     *  @brief      scale an image by redrawing
     *  @details    not recommended but allowed
     *
     *  @param      [in] (CGSize) size - size of scaled image
     *  @return     (UIImage) scaled image
     */
    /********************************************************************************************************************************/
    func scaledImage(withSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
        defer { UIGraphicsEndImageContext(); }
        draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height));
        
        if(verbose) { print("UIImage.scaledImage():              returning scaled image by render"); }
        
        return UIGraphicsGetImageFromCurrentImageContext()!;
    }
    
    /********************************************************************************************************************************/
    /** @fcn        scaleImageToFitSize(size: CGSize) -> UIImage
     *  @brief      scale image to specified image
     *  @details    x
     *
     *  @param      [in] (CGSize) size - size to apply to image
     *  @return     (UIImage) scaled image to size
     */
    /********************************************************************************************************************************/
    func scaleImageToFitSize(size: CGSize) -> UIImage {
        let aspect = self.size.width / self.size.height;
        
        if(verbose) { print("UIImage.scaleImageToFitSize():      returning scaled image of size \(size)"); }
        
        if size.width / aspect <= size.height {
            return scaledImage(withSize: CGSize(width: size.width, height: size.width / aspect));
        } else {
            return scaledImage(withSize: CGSize(width: (size.height * aspect), height: size.height));
        }
    }
}

