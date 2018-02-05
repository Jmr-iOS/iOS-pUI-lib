/************************************************************************************************************************************/
/** @file		ANoteTableView.swift
 *  @project    x
 * 	@brief		x
 * 	@details	x
 *
 * 	@author		Justin Reina, Firmware Engineer, Jaostech
 *  @created    ?
 *  @last rev   ?
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


class ANoteTableView : UITableView {
    
    let verbose : Bool = false;

    var vc : ViewController;
    
    var myCustomCells : [NewTableViewCell];
    
    
    /********************************************************************************************************************************/
	/**	@fcn		init(vc: ViewController, frame: CGRect, style: UITableViewStyle)
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
    init(vc: ViewController, frame: CGRect, style: UITableViewStyle) {

        //Init
        self.vc = vc;
        self.myCustomCells = [NewTableViewCell]();
        
        //Super
        super.init(frame:frame, style:style);
        
        //Load
        for i in 0...(numRows-1) {
            let cell : NewTableViewCell = NewTableViewCell(vc: self.vc,
                                                           aNoteTable: self,
                                                           index : i,
                                                           style: UITableViewCellStyle.default,
                                                           reuseIdentifier: "nbd");
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
    
    
    //@todo     header
    //@note     temp debug
    func updateCellTitles() {
        
        let n = self.vc.rows.count;
        
        for i in 0...(n-1) {
            
            let name = vc.rows[i].main;
            
            myCustomCells[i].setName(name!);
            
            print("-->\(name!)");
        }
        
        print("done");
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
    /** @fcn        refreshTable()
     *  @brief      refresh table contents for display
     *  @details    x
     */
    /********************************************************************************************************************************/
    func refreshTable() {
        
        let n = getCellCount();
        
        let vc = self.vc;
        let rows = vc.rows;
        let table = vc.aNoteTable;


        print("n: \(n)");

        for i in 0...(n-1) {
            let cell = rows[i];
            print("[\(i)]: '\(cell.main!)', '\(table!.myCustomCells[i].textLabel!.text!)'");
        }
        
        //refresh table
        self.reloadRows(at: [IndexPath(row:0, section:0)], with: .none);
        self.reloadRows(at: [IndexPath(row:1, section:0)], with: .none);
        self.reloadRows(at: [IndexPath(row:2, section:0)], with: .none);
        self.reloadRows(at: [IndexPath(row:3, section:0)], with: .none);
        
        self.reloadData();
        
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

