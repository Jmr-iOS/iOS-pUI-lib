/************************************************************************************************************************************/
/** @file		CustomView.swift
 *  @project    x
 * 	@brief		x
 * 	@details	x
 *
 * 	@author		Justin Reina, Firmware Engineer, Jaostech
 *  @created    11/5/17
 *  @last rev   11/26/17
 *
 *
 * 	@notes		x
 *
 * 	@section	Opens
 * 	    none current
 *
 *  @section    Reference
 *      http://stackoverflow.com/questions/24339145/how-do-i-write-a-custom-init-for-a-uiview-subclass-in-swift/37645346?noredirect=
 *      1#comment66816342_37645346
 *
 * 	@section	Legal Disclaimer
 * 		All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 * 		Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
// ref:

import UIKit

class CustomView : UIView {
    
    
    /********************************************************************************************************************************/
	/**	@fcn		init()
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
    init() {
        super.init(frame: UIScreen.main.bounds);
        
        //for debug validation
        self.backgroundColor = UIColor.blue;
        print("My Custom Init");
        
        return;
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
}
