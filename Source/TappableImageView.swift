//
//  TappableImageView
//  0_0 - UIImageView
//
//  URL: http://stackoverflow.com/questions/26244889/extended-uiview-class-using-swift
//
//
//

import UIKit

class TappableImageView : UIImageView {

    var firstImage :UIImage = UIImage(named:"animal_0")!;

    var secondImage:UIImage = UIImage(named:"animal_1")!;


    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
    }

    
    override init(frame: CGRect) {
        super.init(frame: frame);
        
        self.image = firstImage;

        self.addTapRecognizer();
        
        print("TappableImageView was initialized");

        return;
    }
    
    

    func addTapRecognizer() {
        
        let tapRecognizer : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TappableImageView.handleTap(_:)));
        
        tapRecognizer.numberOfTapsRequired    = 1;
        tapRecognizer.numberOfTouchesRequired = 1;
        
        self.addGestureRecognizer(tapRecognizer);
        self.isUserInteractionEnabled = true;
        
        print("addTapRecognizer was called");
        
        return;
    }

    
    func handleTap(_ recognizer:UITapGestureRecognizer) {
        
        //Swap w/Fade
        let fadeAnim:CABasicAnimation = CABasicAnimation(keyPath: "contents");

        fadeAnim.fromValue = (self.image == firstImage) ? firstImage:secondImage;
        fadeAnim.toValue   = (self.image == firstImage) ? secondImage:firstImage;
        
        fadeAnim.duration = 0.8;
        
        //Update ImageView
        self.image = (self.image == firstImage) ? secondImage:firstImage;
        
        self.layer.add(fadeAnim, forKey: "contents");
        
        print("Swap");
        
        return;
    }
}
