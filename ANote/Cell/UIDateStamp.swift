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

	//Vars
    let dateBox  : UIImageView;
    let img      : UIImage;
    var delegate : UIDateStampDelegate!;
    
    
    /********************************************************************************************************************************/
    /** @fcn        init(height:CGFloat)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    init(center : CGPoint) {

        //Init vars
        img = UIImage(named: "datestamp_nosel.png")!;
        
        let wI = img.size.width;
        let hI = img.size.height;
        
        dateBox = UIImageView(image: img);
        
        //Super
        super.init(frame: CGRect(x:0 , y:0, width:wI, height:hI));          /* dims & loc initialized below from image & center     */
        
        //Config dateBox
        dateBox.sizeToImage();

        //Add view
        self.addSubview(dateBox);

        //Config self
        self.center = center;

        let tap = UITapGestureRecognizer(target: self, action: #selector(tapResponse));
        self.addGestureRecognizer(tap);

        if(verbose) { print("UIDateStamp.init():  initialization complete"); }

        return;
    }


    /********************************************************************************************************************************/
    /** @fcn        myTapResponse()
     *  @brief      wrapper to perform delegate response to tap selection
     *  @details    x
     *
     *  @param      [in] (UIDateStampDelegate) delegate - tap responder set
     */
    /********************************************************************************************************************************/
    @objc func tapResponse() {
        delegate.tapResponse(i:1);
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        setDelegate(_ delegate : UIDateStampDelegate)
     *  @brief      set tap response delegate
     *  @details    x
     *
     *  @param      [in] (UIDateStampDelegate) delegate - tap responder set
     */
    /********************************************************************************************************************************/
    func setDelegate(_ delegate : UIDateStampDelegate) {
        self.delegate = delegate;
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

//Response Protocol
protocol UIDateStampDelegate {
   func tapResponse(i : Int);
}

