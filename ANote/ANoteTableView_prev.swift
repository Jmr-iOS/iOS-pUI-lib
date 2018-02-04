/************************************************************************************************************************************/
/** @file       ANoteTableView_prev.swift
 *  @brief      x
 *  @details    x
 *
 *  @section    Opens
 *      x
 *
 *  @section    Legal Disclaimer
 *       All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 *       Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class ANoteTableView_prev : UICustomTableView {
    
    
    /********************************************************************************************************************************/
    /** @fcn        init(frame: CGRect, style: UITableViewStyle, yOffs : CGFloat)
     *  @brief      init table with items contents
     *  @details    table sized to items.count & populated with items values
     *
     *  @param      [in] (CGRect) frame - view frame for insertion
     *  @param      [in] (UITableViewStyle) style - style to apply to table
     *  @param      [in] (CGFloat) yOffs - starting y address of table on main screen
     *
     *  @section    Opens
     *      x
     */
    /********************************************************************************************************************************/
    init(frame: CGRect, style: UITableViewStyle, yOffs : CGFloat) {
        
        print("ANoteTableView.init():              currently configured to UITableViewCell usage");

        //Calc frame
        let tFrame = CGRect(x: frame.origin.x,
                              y: frame.origin.y,
                              width:  UIScreen.main.bounds.width,
                              height: (UIScreen.main.bounds.height - yOffs - lower_bar_height));
        
        /****************************************************************************************************************************/
        /*                                                  UITableView                                                             */
        /****************************************************************************************************************************/
        super.init(frame: tFrame, style: style);
        register(ANoteTableViewCell.self, forCellReuseIdentifier: "cell");
        translatesAutoresizingMaskIntoConstraints = false;
        
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
    /** @fcn        required init?(coder aDecoder: NSCoder)
     *  @brief      x
     */
    /********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    
    
    /********************************************************************************************************************************/
    /** @fcn        func getItems(rows :[ANoteRow]) -> [String]
     *  @brief      x
     *
     *  @param  [in] ([Row]) row - rows for table
     *
     *  @return     ([String]) items - items to se in tableview initialization
     */
    /********************************************************************************************************************************/
    func getItems(rows :[ANoteRow]) -> [String]{
        
        var  items : [String] = [String]();
        
        for r in rows {
            items.append(r.main!);
        }
        
        return items;
    }
}

