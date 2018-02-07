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
    var vc         : ViewController;
    var mainView   : UIView;
    
    //UI
    var cells : [ANoteTableViewCell];

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
        
        //Store
        self.vc = vc;                                               /* not sure on use                                              */
        self.mainView   = vc.view;
        
        //Init Cells
        cells = [ANoteTableViewCell]();
        
        //Calc frame
        let tFrame = CGRect(x: frame.origin.x,
                            y: frame.origin.y,
                            width:  wS,
                            height: (hS - yOffs - lower_bar_height));
        

        /****************************************************************************************************************************/
        /*                                                  UITableView                                                             */
        /****************************************************************************************************************************/
        super.init(frame: tFrame, style: style);
        register(ANoteTableViewCell.self, forCellReuseIdentifier: "cell");
        translatesAutoresizingMaskIntoConstraints = false;

        //Load cells
        for i in 0...(numRows-1) {
            let cell = ANoteTableViewCell(vc:vc, aNoteTable:self, index:i, style: UITableViewCellStyle.default, reuseIdentifier: "cell");
            cells.append(cell);
        }
        
        //Set background color
        self.backgroundColor = tableBakColor;
        
        //Allow for selection
        allowsSelection = true;
        
        if(verbose) { print("ANoteTableView.init():              currently configured to UITableViewCell usage"); }

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
        return cells.count;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        getCell(_ index: Int) -> ANoteTableViewCell
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    override func getCell(_ index: Int) -> ANoteTableViewCell {
        
        let cell : ANoteTableViewCell = cells[index];
        
        return cell;
    }


    /********************************************************************************************************************************/
    /** @fcn    updateCellTitles()
     *  @brief  dev tool to update all titles to display row contents
     */
    /********************************************************************************************************************************/
    func updateCellTitles() {
        
        //Grab count
        let n = self.vc.rows.count;
        
        //Load rows
        for i in 0...(n-1) {
            let name = vc.rows[i].main;
            
            cells[i].setName(name!);
        }
        
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        required init?(coder aDecoder: NSCoder)
     *  @brief      x
     */
    /********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

