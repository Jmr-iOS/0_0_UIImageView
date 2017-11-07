//
//  FadingImageView
//  0_0 - UIImageView
//
//
//
//
//

import UIKit

class FadingImageView : UIImageView {

    var firstImage :UIImage = UIImage(named:"animal_0")!;

    var secondImage:UIImage = UIImage(named:"animal_1")!;

    var loadThread : NSTimer!;
    var fadeThread : NSTimer!;
    var sizeThread : NSTimer!;

    let loadDelay_s : Double = 0.5;

    enum SIZEMODE { case increasing, decreasing }
    
    var currSizeMode:SIZEMODE!;
    var maxWidth:CGFloat!;
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }

    
    // Init to firstImage
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.alpha = 0; //init as off
        
        self.currSizeMode = .decreasing;
        
        self.maxWidth = frame.width;
        
        self.image = firstImage;

        print("TappableImageView was initialized");
        
        self.loadThread = NSTimer.scheduledTimerWithTimeInterval(loadDelay_s, target: self, selector: #selector(FadingImageView.init_load), userInfo: nil, repeats: true);
        
        return;
    }
    
    
    func init_load() {

        print("Loading after a delay");
        
        fadeThread = NSTimer.scheduledTimerWithTimeInterval(0.0125, target: self, selector: #selector(FadingImageView.incr_fade_step), userInfo: nil, repeats: true);

        sizeThread = NSTimer.scheduledTimerWithTimeInterval(0.025, target: self, selector: #selector(FadingImageView.incr_size_step), userInfo: nil, repeats: true);

        
        loadThread.invalidate();
        return;
    }
    
    
    func incr_fade_step() {

        var newAlpha:CGFloat = self.alpha;
        
        if(newAlpha < 1.0) {
            newAlpha = newAlpha + 0.025;
        }
        
        //print("Trying \(newAlpha)");

        if(newAlpha >= 1.0) {

            newAlpha = 1.0;

            print("Face Complete");

            fadeThread.invalidate(); //stop the thread!
        }
        
        self.alpha = newAlpha;
        
        return;
    }


    func incr_size_step() {
        
        //Get curr frame
        let currFrame:CGRect = self.frame;

        var new_width :CGFloat!;
        var new_height:CGFloat!;
        var new_x     :CGFloat!;
        var new_y     :CGFloat!;
        
        if((currFrame.width < 100)||(currFrame.height<100)) {
            self.currSizeMode = .increasing;            //time to switch it!
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
                
                self.currSizeMode = .decreasing;        //time to switch it!
            }
        } else {
            new_width  = currFrame.width  - 4;
            new_height = currFrame.height - 4;
            new_x      = currFrame.origin.x  + 2;
            new_y      =  currFrame.origin.y + 2;
        }
        
        self.contentMode = .ScaleAspectFill;
        
        self.frame = CGRectMake(new_x, new_y, new_width, new_height);
        
        return;
    }
}
