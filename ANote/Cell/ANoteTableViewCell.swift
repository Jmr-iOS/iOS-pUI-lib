/************************************************************************************************************************************/
/** @file		ANoteTableViewCell.swift
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


class ANoteTableViewCell : UITableViewCell {
    
    let verbose : Bool = false;
    
    let cellSelectionFade : Bool = false;

    /********************************************************************************************************************************/
	/**	@fcn		override init(style: UITableViewCellStyle, reuseIdentifier: String?)
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier:reuseIdentifier);

        if(cellSelectionFade == true) {
            selectionStyle = UITableViewCellSelectionStyle.gray;                /* Options are 'Gray/Blue/Default/None'             */
        } else {
            selectionStyle = UITableViewCellSelectionStyle.none;
        }
        
        if(verbose){ print("CustomTableViewCell.init():         the CustomTableViewCell was initialized"); }
        
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

