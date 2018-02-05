/************************************************************************************************************************************/
/** @file		NewTableViewCell.swift
 *  @project    x
 * 	@brief		x
 * 	@details	x
 *
 * 	@notes		x
 *
 * 	@section	Opens
 * 			none current
 *
 * 	@section	Legal Disclaimer
 * 			All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 * 			Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class NewTableViewCell : UICustomTableViewCell {
    

    /********************************************************************************************************************************/
	/**	@fcn		init(vc: ViewController, mainView: UIView, style: UITableViewCellStyle, reuseIdentifier: String?)
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
    init(vc: ViewController, mainView: UIView, style: UITableViewCellStyle, reuseIdentifier: String?) {

        super.init(style:style, reuseIdentifier:reuseIdentifier);

        if(verbose){ print("NewTableViewCell.init():            the NewTableViewCell was initialized"); }
        
        return;
    }
   
    
    /********************************************************************************************************************************/
	/**	@fcn		init?(coder aDecoder: NSCoder)
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

