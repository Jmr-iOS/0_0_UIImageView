/************************************************************************************************************************************/
/** @file       FadingImageView.swift
 *  @project    0_0 - UIImageView
 *  @brief      x
 *  @details    x
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


class FadingImageView : UIImageView {

    //Images
    var firstImage :UIImage = UIImage(named:"animal_0")!;
    var secondImage:UIImage = UIImage(named:"animal_1")!;

    //Threads
    var loadThread : Timer!;
    var fadeThread : Timer!;
    var sizeThread : Timer!;

    let loadDelay_s : Double = 0.5;

    enum SIZEMODE { case increasing, decreasing }
    
    var currSizeMode:SIZEMODE!;
    var maxWidth:CGFloat!;

    
    /********************************************************************************************************************************/
    /** @fcn        override init(frame: CGRect)
     *  @brief      init to firstImage
     *  @details    x
     */
    /********************************************************************************************************************************/
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.alpha = 0;                                                 /* init as off                                              */
        
        self.currSizeMode = .decreasing;
        
        self.maxWidth = frame.width;
        
        self.image = firstImage;

        if(verbose) { print("FadingImageView.init():             initialization complete"); }
        
        self.loadThread = Timer.scheduledTimer(timeInterval: loadDelay_s, target: self, selector: #selector(FadingImageView.init_load), userInfo: nil, repeats: true);
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        init_load()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    @objc func init_load() {

        if(verbose) { print("FadingImageView.init_load():        loading after a delay complete"); }
        
        fadeThread = Timer.scheduledTimer(timeInterval: 0.0125, target: self, selector: #selector(FadingImageView.incr_fade_step), userInfo: nil, repeats: true);

        sizeThread = Timer.scheduledTimer(timeInterval: 0.025, target: self, selector: #selector(FadingImageView.incr_size_step), userInfo: nil, repeats: true);

        loadThread.invalidate();
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        incr_fade_step()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    @objc func incr_fade_step() {

        var newAlpha:CGFloat = self.alpha;
        
        if(newAlpha < 1.0) {
            newAlpha = newAlpha + 0.025;
        }
        
        if(newAlpha >= 1.0) {

            newAlpha = 1.0;

            if(verbose) { print("FadingImageView.incr_fade_step():   fade complete"); }

            fadeThread.invalidate();                                            /* stop the thread!                                 */
        }
        
        self.alpha = newAlpha;
        
        return;
    }


    /********************************************************************************************************************************/
    /** @fcn        incr_size_step()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    @objc func incr_size_step() {
        
        //Get curr frame
        let currFrame:CGRect = self.frame;

        var new_width :CGFloat!;
        var new_height:CGFloat!;
        var new_x     :CGFloat!;
        var new_y     :CGFloat!;
        
        if((currFrame.width < 100)||(currFrame.height<100)) {
            self.currSizeMode = .increasing;                                    /* time to switch it!                               */
        }
        
        if(self.currSizeMode == .increasing) {

            if(currFrame.width < self.maxWidth) {
                new_width  = currFrame.width  + 4;
                new_height = currFrame.height + 4;
                new_x      = currFrame.origin.x  - 2;
                new_y      =  currFrame.origin.y - 2;
            } else {
                new_width = currFrame.width;
                new_height = currFrame.height;
                new_x = currFrame.origin.x;
                new_y = currFrame.origin.y;
                
                self.currSizeMode = .decreasing;                                /* time to switch it!                               */
            }
        } else {
            new_width  = currFrame.width  - 4;
            new_height = currFrame.height - 4;
            new_x      = currFrame.origin.x  + 2;
            new_y      =  currFrame.origin.y + 2;
        }
        
        self.contentMode = .scaleAspectFill;
        
        self.frame = CGRect(x: new_x, y: new_y, width: new_width, height: new_height);
        
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
