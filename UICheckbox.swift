/************************************************************************************************************************************/
/** @file       UICheckBox.swift
 *  @brief      x
 *  @details    x
 *
 *  @section    Opens
 *      x
 *
 *  @section    Reference
 *      http://stackoverflow.com/questions/2599451/cabasicanimation-delegate-for-animationdidstop
 *
 *  @section    Legal Disclaimer
 *       All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 *       Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit

//@todo     ...
protocol UICheckBoxDelegate {
    func checkBoxResp(_ checked : Bool);
}


class UICheckbox: UIView {
    
    //state
    var checkBoxImg : UIImageView!;
    var parentCell  : ANoteTableViewCell!;
    var delegate    : UICheckBoxDelegate!;
    var state       : Bool = false;

    //images
    var uncheckedImage  :UIImage;
    var checkedImage    :UIImage;
    
    var loadThread : Timer!;
    var fadeThread : Timer!;
    
    //Config
    private let verbose : Bool;                                     /* for this class                                               */


    /********************************************************************************************************************************/
    /* @fcn       init(view: UIView, parentCell: ANoteTableViewCell, type: CellType, xCoord: CGFloat, yCoord: CGFloat)              */
    /* @brief                                                                                                                       */
    /*                                                                                                                              */
    /*  @param      [in] (UIView) view - view box is added to                                                                       */
    /*  @param      [in] (ANoteTableViewCell) parentCell - cell box is added to                                                     */
    /*  @param      [in] (CellType) type - type of checkbox to display                                                              */
    /*  @param      [in] (CGFloat) xCoord - x coordinates of box                                                                    */
    /*  @param      [in] (CGFloat) yCoord - y coordinates of box                                                                    */
    /*                                                                                                                              */
    /********************************************************************************************************************************/
    init(view: UIView, parentCell: ANoteTableViewCell, delegate: UICheckBoxDelegate, type: CellType, xCoord: CGFloat, yCoord: CGFloat) {

        //Store
        self.parentCell = parentCell;
        self.delegate   = delegate;
        
        //Init Vars
        verbose = false;
        
        //Init Image
        switch(type) {
            case .list:
                uncheckedImage = UIImage(named:"list_box")!;
                checkedImage   = UIImage(named:"list_box")!;
                break;
            case .todo:
                uncheckedImage = UIImage(named:"anote_unchecked")!;
                checkedImage   = UIImage(named:"anote_checked")!;
                break;
        }
        
        checkBoxImg       = UIImageView(image: uncheckedImage);
        checkBoxImg.frame = CGRect(x: xCoord, y: yCoord, width: check_dim, height: check_dim);

        //Super
        super.init(frame:CGRect(x: 0, y: 0, width: cell_xOffs, height: row_height));  //make it to the tap size you want
        
        //handle taps
        addTapRecognizer();
        
        //uiview setup: me<-image then main<-main
        addSubview(checkBoxImg);
        view.addSubview(self);       
        
        if(verbose){print("UICheckbox.init():                  complete");}
        
        return;
    }

    
    /********************************************************************************************************************************/
    /* @fcn       addTapRecognizer()                                                                                                */
    /* @details   handle taps, img change and fade                                                                                  */
    /********************************************************************************************************************************/
    func addTapRecognizer() {
        
        //Base Handle
        let tapRecognizer : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UICheckbox.handleTap(_:)));

        //Tap Config
        tapRecognizer.numberOfTapsRequired    = 1;
        tapRecognizer.numberOfTouchesRequired = 1;
        
        //Gesture Config
        self.addGestureRecognizer(tapRecognizer);
        self.isUserInteractionEnabled = true;
        
        return;
    }
    

    /********************************************************************************************************************************/
    /* @fcn       handleTap(recognizer:UITapGestureRecognizer)                                                                      */
    /* @details   the self->UITapGestureRecognizer is set to call this on a tap                                                     */
    /* @note      @objc exposed to enabled handleTap() access, not sure why                                                         */
    /********************************************************************************************************************************/
    @objc func handleTap(_ recognizer:UITapGestureRecognizer) {
        
        if(verbose) { print("UICheckbox.handleTap():             handling tap response"); }
        
        //Get state
        let prevState : Bool =  (self.checkBoxImg.image == checkedImage);           /* was previously selected?                     */
        let newState  : Bool = !prevState;                                          /* inverted on selection                        */
        
        //Swap w/Fade
        let fadeAnim:CABasicAnimation = CABasicAnimation(keyPath: "contents");
        
        fadeAnim.fromValue = (prevState) ? checkedImage:uncheckedImage;
        fadeAnim.toValue   = (prevState) ? uncheckedImage:checkedImage;
        
        fadeAnim.duration = check_dur_s.magnitude;
        
        fadeAnim.delegate = self as? CAAnimationDelegate;
        
        
        //Update ImageView & State
        state = (prevState) ? false : true;                                      /* if it was unchecked, now it's checked, true!    */

        checkBoxImg.image = (prevState) ? uncheckedImage:checkedImage;

        checkBoxImg.layer.add(fadeAnim, forKey: "contents");

        //Update text
        parentCell.updateSelection(selected: newState);
        
        //Handle Parent Response
        delegate.checkBoxResp(newState);
        
        return;
    }
    

    /********************************************************************************************************************************/
    /* @fcn       required init?(coder aDecoder: NSCoder)                                                                     		*/
    /* @details   init from backup                                                    												*/
    /********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) {
        
        uncheckedImage = UIImage();
        checkedImage   = UIImage();
        verbose        = false;
        
        super.init(coder:aDecoder);
        
        return;
    }
}

