/************************************************************************************************************************************/
/** @file		ANoteTableView.swift
 *  @project    x
 * 	@brief		x
 * 	@details	x
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


class ANoteTableView : UICustomTableView {

    //Root
    var vc : ViewController;
    
    //UI
    var myCustomCells2 : [NewTableViewCell];

    /********************************************************************************************************************************/
    /** @fcn        init(frame: CGRect, style: UITableViewStyle, vc: ViewController, yOffs : CGFloat)
     *  @brief      init table with items contents
     *  @details    table sized to items.count & populated with items values
     *
     *  @param      [in] (CGRect) frame - view frame for insertion
     *  @param      [in] (UITableViewStyle) style - style to apply to table
     *  @param      [in] (ViewController) vc - root view controller
     *  @param      [in] (CGFloat) yOffs - starting y address of table on main screen
     *
     *  @section    Opens
     *      x
     */
    /********************************************************************************************************************************/
    init(frame: CGRect, style: UITableViewStyle, vc: ViewController, yOffs : CGFloat) {
        
        self.vc = vc;                                               /* not sure on use                                              */
        
        //Init Cells
        myCustomCells2 = [NewTableViewCell]();
        
        //Calc frame
        let tFrame = CGRect(x: frame.origin.x,
                            y: frame.origin.y,
                            width:  UIScreen.main.bounds.width,
                            height: (UIScreen.main.bounds.height - yOffs - lower_bar_height));
        
        print("ANoteTableView.init():              currently configured to UITableViewCell usage");

        /****************************************************************************************************************************/
        /*                                                  UITableView                                                             */
        /****************************************************************************************************************************/
        super.init(frame: tFrame, style: style);
        register(NewTableViewCell.self, forCellReuseIdentifier: "cell");
        translatesAutoresizingMaskIntoConstraints = false;

        //Load cells
        for i in 0...(numRows-1) {
            let cell = NewTableViewCell(vc:vc, aNoteTable:self, index:i, style: UITableViewCellStyle.default, reuseIdentifier: "cell");
            myCustomCells2.append(cell);
        }
        
        //Set background color
        self.backgroundColor = tableBakColor;
        
        //Set the row height
        rowHeight = (rowHeight);
        
        //Allow for selection
        allowsSelection = true;
        
        
        /****************************************************************************************************************************/
        /*                                              aNote cell-styles                                                           */
        /****************************************************************************************************************************/
        separatorColor = tableSepColor;
        separatorStyle = .singleLine;
        separatorInset = UIEdgeInsetsMake(0, 43, 0, 0);
        
        //Disable the empty cell borders
        self.tableFooterView = UIView();
        
        //Exit
        if(verbose){print("ANoteTableView.init():              initialized"); }
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        getCellCount() -> Int
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    override func getCellCount() -> Int {
        return myCustomCells2.count;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        getCell(_ index: Int) -> NewTableViewCell
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    override func getCell(_ index: Int) -> NewTableViewCell {
        
        let cell : NewTableViewCell = myCustomCells2[index];
        
        return cell;
    }

    /********************************************************************************************************************************/
    /** @fcn        refreshTable()
     *  @brief      refresh table contents for display
     *  @details    x
     *
     *  @section    Opens
     *      port to library
     */
    /********************************************************************************************************************************/
    func refreshTable() {
        
        let vc = self.vc;
        let rows = vc.rows;
        let table = vc.aNoteTable;
        
        
        print("n: \(numRows)");
        
        for i in 0...(numRows-1) {
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
    /** @fcn    updateCellTitles()
     *  @brief  dev tool to update all titles to display row contents
     */
    /********************************************************************************************************************************/
    func updateCellTitles() {
        
        let n = self.vc.rows.count;
        
        for i in 0...(n-1) {
            
            let name = vc.rows[i].main;
            
            myCustomCells2[i].setName(name!);
            
            print("-->\(name!)");
        }
        
        print("done");
    }

    
    /********************************************************************************************************************************/
    /** @fcn        required init?(coder aDecoder: NSCoder)
     *  @brief      x
     */
    /********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

