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
        self.rowHeight = 50;                                    /* std. val                                                         */
        //Super
        super.init();
        
        if(verbose){ print("CustomTableViewHandler.init():      the CustomTableViewHandler was initialized"); }

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
        
        let height : CGFloat = rowHeight;
        
        let isSecondRow = (indexPath.item == 2);
        
        if(isSecondRow) {
            //cellHeight = 75;                                          /* make smaller for visible example if wanted               */
        }
        
        return height;
    }

    
    /********************************************************************************************************************************/
	/**	@fcn		tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell : ANoteTableViewCell = table.myCustomCells[(indexPath as NSIndexPath).item];
        
        return cell;
    }
    
    
    /********************************************************************************************************************************/
	/**	@fcn		tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if(true){ print("CustomTableViewHandler.tableView(): handling a cell tap of \((indexPath as NSIndexPath).item)"); }

        //CUSTOM
        table.deselectRow(at: indexPath, animated:true);
        
        //eww... the traditional access method...
        //let currCell : UICustomTableViewCell = customTable.dequeueReusableCellWithIdentifier("cell") as! UICustomTableViewCell;
        
        let cell : ANoteTableViewCell = table.getCell((indexPath as NSIndexPath).item) as! ANoteTableViewCell;

        print("Handler.tableView():                (didSelectRowAt) We have cell '\((cell.textLabel?.text)!)...'");

        /****************************************************************************************************************************/
        /* scroll to the top or change the bar color                                                                                */
        /****************************************************************************************************************************/
        switch((indexPath as NSIndexPath).row) {
        case (0):
            print("Handler.tableView():                (didSelectRowAt) top selected. Scrolling to the bottom");
            table.scrollToRow(at: IndexPath(row: self.table.getCellCount()-1, section: 0), at: UITableViewScrollPosition.bottom, animated: true);
            break;
        case (1):
            table.addNewCell("Woot Woot!");
            print("Handler.tableView():                (didSelectRowAt) added a cell?");
            break;
        case (2):
            table.setEditing(true, animated: true);
            print("Handler.tableView():                (didSelectRowAt) editing is enabled");
            break;
        case (table.getCellCount()-4):
            print("Handler.tableView():                (didSelectRowAt) swapped the seperator color to blue");
            table.separatorColor = UIColor.blue;
            break;
        case (table.getCellCount()-3):
            print("Handler.tableView():                (didSelectRowAt) scrolling to the top with a Rect and fade");
            table.scrollRectToVisible(CGRect(x: 0,y: 0,width: 1,height: 1), animated:true);           //slow scroll to top
            break;
        case (table.getCellCount()-2):
            print("Handler.tableView():                (didSelectRowAt) scrolling to the top with a Rect and no fade");
            table.scrollRectToVisible(CGRect(x: 0,y: 0,width: 1,height: 1), animated:false);          //immediate scroll to top
            break;
        case (table.getCellCount()-1):
            print("Handler.tableView():                (didSelectRowAt) scrolling to the top with scrollToRowAtIndexPath");
            table.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: true);
            break;
        default:
            print("Handler.tableView():                (didSelectRowAt) I didn't program a reaction for this case. I was lazy...");
            break;
        }
        
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
        
        if(table.myCustomCells.count > 0) {
            table.removeCell((indexPath as NSIndexPath).item);                      /* handle delete (by removing the data from     */
        }                                                                           /* your array and updating the tableview)       */
        
        return;
    }

    
/************************************************************************************************************************************/
/*                                                        Helpers                                                                   */
/************************************************************************************************************************************/
    
    /********************************************************************************************************************************/
	/**	@fcn		getCharName(_ i : Int) -> String
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
	func getCharName(_ i : Int) -> String {
        return String(describing: UnicodeScalar(i + Int(("A" as UnicodeScalar).value)));
    }
    
    
    /********************************************************************************************************************************/
	/**	@fcn		getRowLabel(_ charName : String, index: Int) -> String
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
	func getRowLabel(_ charName : String, index: Int) -> String {
        return String(format: "Item '%@' (%d)", charName, index);
    }
    
    
    /********************************************************************************************************************************/
	/**	@fcn		addNewRow()
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
	func addNewRow() {
        
        let charName : String = getCharName(self.table.getCellCount());
        
        let newLabel : String = getRowLabel(charName, index: table.getCellCount());
  
        table.addNewCell(newLabel);
        
        table.reloadData();
        
        print("Handler.tableView():                new row was added '\(newLabel)'");
        
        return;
    }
    
}
