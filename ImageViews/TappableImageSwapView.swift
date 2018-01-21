/************************************************************************************************************************************/
/** @file       TappableImageSwapView.swift
 *  @project    0_0 - UIImageView
 *  @brief      x
 *  @details    x
 *
 *  @section    Reference
 *      http://stackoverflow.com/questions/26244889/extended-uiview-class-using-swift
 *      http://stackoverflow.com/questions/2834573/how-to-animate-the-change-of-image-in-an-uiimageview
 *
 *  @section    Opens
 *      fcn headers
 *
 *  @section    Legal Disclaimer
 *      All contents of this source file and/or any other Jaostech related source files are the explicit property of Jaostech
 *      Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class TappableImageSwapView : UIImageView {

    var firstImage :UIImage = UIImage(named:"one")!;

    var secondImage:UIImage = UIImage(named:"two")!;

    var loadThread : Timer!;
    var fadeThread : Timer!;
    
    let loadDelay_s : Double = 0.5;

    
    /********************************************************************************************************************************/
    /** @fcn        override init(frame: CGRect)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.image = firstImage;

        self.addTapRecognizer();
        
        if(verbose) { print("TappableImageSwapView.init():       initialization complete"); }
        
        return;
    }
    

    /********************************************************************************************************************************/
    /** @fcn        addTapRecognizer()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func addTapRecognizer() {
        
        let tapRecognizer : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TappableImageSwapView.handleTap(_:)));
        
        tapRecognizer.numberOfTapsRequired    = 1;
        tapRecognizer.numberOfTouchesRequired = 1;
        
        self.addGestureRecognizer(tapRecognizer);
        self.isUserInteractionEnabled = true;
        
        if(verbose) { print("TappableImageSwapView.addTpRec():   complete"); }
        
        return;
    }

    /********************************************************************************************************************************/
    /** @fcn        handleTap(_ recognizer:UITapGestureRecognizer)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    @objc func handleTap(_ recognizer:UITapGestureRecognizer) {
        
        //Swap w/Fade
        let fadeAnim:CABasicAnimation = CABasicAnimation(keyPath: "contents");
        
        fadeAnim.fromValue = (self.image == firstImage) ? firstImage:secondImage;
        fadeAnim.toValue   = (self.image == firstImage) ? secondImage:firstImage;
        
        fadeAnim.duration = 0.25;
        
        //Update ImageView
        self.image = (self.image == firstImage) ? secondImage:firstImage;
        
        self.layer.add(fadeAnim, forKey: "contents");
        
        if(verbose) { print("TappableImageSwapView.handleTap():  fade & swap complete"); }
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        required init?(coder aDecoder: NSCoder)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented!");
    }
}

