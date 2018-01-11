/************************************************************************************************************************************/
/** @file       ANoteTableView.swift
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


class ANoteTableView : UICustomTableView {
    
    
    /********************************************************************************************************************************/
    /** @fcn        init(frame: CGRect, style: UITableViewStyle, items: [String])
     *  @brief      init table with items contents
     *  @details    table sized to items.count & populated with items values
     *
     *  @param      [in] (CGRect) frame - view frame for insertion
     *  @param      [in] (UITableViewStyle) style - style to apply to table
     *
     *  @section    Opens
     *      x
     */
    /********************************************************************************************************************************/
    init(frame: CGRect, style: UITableViewStyle, i : Int) {
        
        print("ANoteTableView.init():              currently configured to UITableViewCell usage");

        
        /****************************************************************************************************************************/
        /*                                                  UITableView                                                             */
        /****************************************************************************************************************************/
        super.init(frame: frame, style: style);
        
        self.register(ANoteTableViewCell.self, forCellReuseIdentifier: "cell");
        self.translatesAutoresizingMaskIntoConstraints = false;
                
        /****************************************************************************************************************************/
        /*                                              aNote cell-styles                                                           */
        /****************************************************************************************************************************/
        self.separatorColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0);      /* #e6e6e6                                  */
        self.separatorStyle = .singleLine;
        self.separatorInset = UIEdgeInsetsMake(0, 43, 0, 0);

        //Set the row height
        self.rowHeight = (row_height);
        
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
    /** @fcn        func getItems(rows :[Row]) -> [String]
     *  @brief      x
     *
     *  @param  [in] ([Row]) row - rows for table
     *
     *  @return     ([String]) items - items to se in tableview initialization
     */
    /********************************************************************************************************************************/
    func getItems(rows :[Row]) -> [String]{
        
        var  items : [String] = [String]();
        
        for r in rows {
            items.append(r.main!);
        }
        
        return items;
    }
}

