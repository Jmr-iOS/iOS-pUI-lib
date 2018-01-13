/************************************************************************************************************************************/
/** @file		CustomSubview.swift
 *  @project    x
 * 	@brief		x
 * 	@details	x
 *
 * 	@author		Justin Reina, Firmware Engineer, Jaostech
 * 	@created	11/5/17
 * 	@last rev	11/26/17
 *
 *
 * 	@notes		x
 *
 * 	@section	Opens
 * 		none current
 *
 *  @section 	Reference
 *		ref: http://stackoverflow.com/questions/24339145/how-do-i-write-a-custom-init-for-a-uiview-subclass-in-swift/37645346?no
 * 			 redirect=1#comment66816342_37645346
 *
 * 	@section	Legal Disclaimer
 * 			All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 * 			Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class CustomSubview : UIView {
    
    
    /********************************************************************************************************************************/
	/**	@fcn		init()
	 *  @brief		x
     */
	/********************************************************************************************************************************/
    init() {
        super.init(frame: UIScreen.main.bounds);
        
        let windowHeight : CGFloat = 150;
        let windowWidth  : CGFloat = 360;
        
        self.frame = CGRect(x: 0, y: 0, width: windowWidth, height: windowHeight);
        self.center = CGPoint(x: UIScreen.main.bounds.width/2, y: 375);

        //for debug validation
        self.backgroundColor = UIColor.gray;
        print("My Custom Init");
 
        return;
    }
 
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
}
