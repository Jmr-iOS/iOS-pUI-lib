/************************************************************************************************************************************/
/** @file       UIDateStamp.swift
 *  @project    Date Stamp for ANote Cell Subview
 *  @brief      x
 *  @details    x
 *
 *  @author     Justin Reina, Firmware Engineer, Jaostech
 *  @created    2/3/18
 *  @last rev   2/3/18
 *
 *
 *  @notes      x
 *
 *  @section    Opens
 *      none current
 *
 *  @section    Legal Disclaimer
 *      All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 *      Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit

//@note     global vars


class UIDateStamp : UIView {

    let dateBox : UIImageView;
    let img : UIImage;
    
    /********************************************************************************************************************************/
    /** @fcn        init(height:CGFloat)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    init(center : CGPoint) {

        //Init vars
        img = UIImage(named: "datestamp_nosel.png")!;
        dateBox = UIImageView(image: img);
        
        //Super
        super.init(frame: CGRect());                                /* dims & loc initialized below from image & center             */
        
        //Config self
        self.sizeToFit();
        self.center = center;

        //Config dateBox
        dateBox.sizeToImage();
        dateBox.center = CGPoint(x:(self.frame.width/2), y:(self.frame.height/2));
        
        //Add view
        self.addSubview(dateBox);

        if(verbose) { print("UIDateStamp.init():  initialization complete"); }

        return;
    }
    

    /********************************************************************************************************************************/
    /** @fcn        class func getInitDims() -> CGSize
     *  @brief      get initial dims of view on init
     *  @details    x
     *
     *  @param      [in] (NSCoder) aDecoder - memory query device (backup access)
     */
    /********************************************************************************************************************************/
    class func getInitDims() -> CGSize {
        let img = UIImage(named: "datestamp_nosel.png")!;
        return img.size;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        init?(coder aDecoder: NSCoder)
     *  @brief      backup restore initialization
     *  @details    x
     *
     *  @param      [in] (NSCoder) aDecoder - memory query device (backup access)
     */
    /********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented");
    }
}

