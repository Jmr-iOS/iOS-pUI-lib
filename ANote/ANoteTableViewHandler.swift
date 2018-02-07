/************************************************************************************************************************************/
/** @file		ANoteTableViewHandler.swift
 *  @project    x
 * 	@brief		x
 * 	@details	x
 *
 * 	@author		Justin Reina, Firmware Engineer, Jaostech
 *  @created    ?
 *  @last rev   ?
 *
 * 	@note you need to create a custom handler to ensure the cell's are CREATED and ACCESSED differently in this example code
 *        differently than the standard table example. It's not that a seperate class is REQUIRED, it's just dramatically cleaner and
 *        safer for longterm retention!
 *
 * 	@section	Opens
 * 			full review & completion
 *
 * 	@section	Legal Disclaimer
 * 			All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 * 			Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class ANoteTableViewHandler : NSObject, UITableViewDataSource, UITableViewDelegate {
   
    let verbose : Bool = false;
    
    //Vars
	var table     : ANoteTableView!;                            /* table for handler to control                                     */
    var rowHeight : CGFloat;                                    /* uniform height for all rows                                      */

    
    /********************************************************************************************************************************/
    /** @fcn        init(table : UICustomTableView)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    init(table : ANoteTableView) {

        //Store
        self.table = table;
        
        //Init
        self.rowHeight = cellHeight;                            /* std. val                                                         */
        
        //Super
        super.init();

        if(verbose){ print("ANoteTableViewHandler.init():       the CustomTableViewHandler was initialized"); }

        return;
    }

    
/************************************************************************************************************************************/
/*                                  UITableViewDataSource, UITableViewDelegate Interfaces                                        	*/
/************************************************************************************************************************************/


    /********************************************************************************************************************************/
	/**	@fcn		tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(verbose){ print("Handler.tableView():                (numberOfRowsInSection) The table will now have \(self.table.getCellCount()), cause I just said so..."); }
        
        return table.getCellCount();                                            /* return how many rows you want printed....!       */
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
     *  @brief      set row height of each row in table
     *  @details    x
     */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight;
    }

    
    /********************************************************************************************************************************/
	/**	@fcn		tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell : ANoteTableViewCell = table.cells[(indexPath as NSIndexPath).item];
        
        return cell;
    }
    
    
    /********************************************************************************************************************************/
	/**	@fcn		tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        //Grab
        let n = indexPath.item;
        
        if(verbose){ print("ANoteTableViewHandler.tableView():     handling a cell tap of \((indexPath as NSIndexPath).item)"); }

        //Display selection
        table.deselectRow(at: indexPath, animated:true);

        //Launch subview
        table.getCell(n).launchSubview();

        if(verbose){ print("Handler.tableView():                (didSelectRowAt) We have cell '\(n)...'"); }
        
        return;
    }
    
    
    /********************************************************************************************************************************/
	/**	@fcn		tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
	 *  @brief		x
	 *  @details	x
	 *
	 *  @section	Source
	 *		http://stackoverflow.com/questions/24103069/swift-add-swipe-to-delete-tableviewcell
	 */
	/********************************************************************************************************************************/
	func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true;
    }
    
    
    /********************************************************************************************************************************/
	/**	@fcn		tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
	func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if(table.cells.count > 0) {
            table.removeCell(indexPath.item);                                       /* handle delete (by removing the data from     */
        }                                                                           /* your array and updating the tableview)       */
        
        return;
    }
}
