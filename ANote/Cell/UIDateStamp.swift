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


class UIDateStamp : UIView {

	//Vars
    let dateBox  : UIImageView;
    let img      : UIImage;
    var delegate : UIDateStampDelegate!;
    
    //Constants
    let verbose  : Bool = false;
    
    
    /********************************************************************************************************************************/
    /** @fcn        init(y0 : CGFloat)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    init(y0 : CGFloat) {

        //Vars
        var wS, hI : CGFloat;
        
        //Init vars
        img = UIImage(named: "datestamp_nosel.png")!;
        wS  = UIScreen.main.bounds.width;
        hI  = (img.size.height/2);                                             /* 2x scale                                         */
        
        //Init UI
        dateBox = UIImageView(image: img);
        
        //Super
        super.init(frame: CGRect(x:0 , y:y0, width:wS, height:hI));             /* dims & loc initialized below from image & center */
        
        //Config dateBox
        dateBox.sizeToImage();
        dateBox.center = CGPoint(x: wS/2, y: hI/2);

        //Add view
        self.addSubview(dateBox);

        //Config delegate
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapResponse));
        self.addGestureRecognizer(tap);

        if(verbose) { print("UIDateStamp.init():  initialization complete"); }

        return;
    }


    /********************************************************************************************************************************/
    /** @fcn        setStamp(_ tempSel : Int)
     *  @brief      x
     *  @details    x
     *
     *  @param      [in] (Int) tempSel - selection 0-2
     */
    /********************************************************************************************************************************/
    func setStamp(_ tempSel : Int) {
        
        //Vars
        var img : UIImage?;
        var wS, hI : CGFloat;
        
        //Select image
        switch(tempSel) {
            case 0:
                img = UIImage(named: "datestamp_nosel.png")!;
                break;
            case 1:
                img = UIImage(named: "datestamp_sel.png")!;
                break;
            case 2:
                img = nil;
                break;
        default:
            fatalError("Invalid selection");
        }
        
        //Update image
        dateBox.image = img;

        //Resize to fill
        if(tempSel != 2) {
            //Calc vars
            wS  = UIScreen.main.bounds.width;
            hI  = (img!.size.height/2);                                             /* 2x scale                                         */

            //Apply dims
            dateBox.sizeToImage();
            dateBox.center = CGPoint(x: wS/2, y: hI/2);
        }
        
        print("A\(tempSel)");
        
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

