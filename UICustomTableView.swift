/************************************************************************************************************************************/
/** @file		UICustomTableView.swift
 *  @project    x
 * 	@brief		x
 * 	@details	x
 *
 * 	@author		Justin Reina, Firmware Engineer, Jaostech
 *  @created    11/5/17
 *  @last rev   1/2/18
 *
 *
 * 	@notes		x
 *
 * 	@section	Opens
 * 			none current
 *
 *  @section    Reference
 *      (awesome) http://code.tutsplus.com/tutorials/ios-sdk-crafting-custom-uitableview-cells--mobile-15702
 *
 * 	@section	Legal Disclaimer
 * 			All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 * 			Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class UICustomTableView : UITableView {
    
    let verbose : Bool = false;

	var myCustomCells : [UICustomTableViewCell] = [UICustomTableViewCell]();

    
    /********************************************************************************************************************************/
	/**	@fcn		init(frame: CGRect, style: UITableViewStyle)
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
	override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame:frame, style:style);
        
        for i in 0...100 {
            let cell : UICustomTableViewCell = UICustomTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "nbd");
            
            cell.textLabel?.text = "Table Row \(i)";
            
            myCustomCells.append(cell);
        }
        
        //Configure scrolling & selection
        self.allowsSelection = false;
        self.isScrollEnabled = true;
        
        register(UICustomTableViewCell.self, forCellReuseIdentifier: "cell");               /* I have no idea why we do this        */
        
        translatesAutoresizingMaskIntoConstraints = false;                                  /* Std                                  */
        
        if(verbose){ print("CustomTableView.init():             the CustomTableView was initialized"); }

        return;
    }
    
    
    /********************************************************************************************************************************/
	/**	@fcn		addNewCell(_ cellString : String)
	 *  @brief		x
	 *  @details	x
     *
	 *  @param		[in] (String) cellString - text to display in cell
     *
	 */
	/********************************************************************************************************************************/
	func addNewCell(_ cellString : String) {
            
        let newCell : UICustomTableViewCell = UICustomTableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "eww?");
        
        myCustomCells.append(newCell);
        
        reloadData();
        
        if(verbose){ print("CustomTableView.addCell():          a new cell was added"); }

        return;
    }
    
    
    /********************************************************************************************************************************/
	/**	@fcn		removeCell(_ index : Int)
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
	func removeCell(_ index : Int) {
        
        myCustomCells.remove(at: index);
        
        reloadData();
        
        sizeToFit();
        
        //turn mode off (just cause, for demo's sake)
        setEditing(false, animated: true);

        print("CustomTableView.removeCell():        cell removed");
        
        return;
    }
    
    
    /********************************************************************************************************************************/
	/**	@fcn		getCell(_ index: Int) -> UICustomTableViewCell
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
	func getCell(_ index: Int) -> UICustomTableViewCell {
    
        let cell : UICustomTableViewCell = myCustomCells[index];

        return cell;
    }
    
    
    /********************************************************************************************************************************/
	/**	@fcn		getCellCount() -> Int
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
	func getCellCount() -> Int {
        return myCustomCells.count;
    }


    /********************************************************************************************************************************/
    /** @fcn        required init?(coder aDecoder: NSCoder)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
	required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

