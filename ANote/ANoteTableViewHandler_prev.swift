/************************************************************************************************************************************/
/** @file       ANoteTableViewHandler_prev.swift
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


class ANoteTableViewHandler_prev : UICustomTableViewHandler {
    
    var vc         : ViewController!;
    var mainView   : UIView!;
    var aNoteTable : ANoteTableView!;


    /********************************************************************************************************************************/
    /* @fcn       init()                                                                                                            */
    /* @details                                                                                                                     */
    /********************************************************************************************************************************/
    init(vc : ViewController, mainView : UIView, ANoteTable : ANoteTableView) {
        
        super.init(table: ANoteTable);
        
        self.rowHeight = cellHeight;
        self.vc = vc;
        self.mainView = mainView;
        self.aNoteTable = ANoteTable;
        print("1");
        if(verbose){ print("ANoteTableViewHandler.init():       initialized"); }
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /* @fcn       tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int                                      */
    /* @details   get how many rows in specified section                                                                            */
    /********************************************************************************************************************************/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if(verbose){ print("ANoteTableViewHandler.tableView():  The table will now have \(self.vc.rows.count), cause I just said so..."); }
        print("2");
        return self.vc.rows.count;
    }

    
    /********************************************************************************************************************************/
    /* @fcn       tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> ANoteTableViewCell             */
    /* @details   add a cell to the table                                                                                           */
    /********************************************************************************************************************************/
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let  cellId  :String = "Cell"+String(indexPath.row);
        
        var cell : ANoteTableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellId) as! ANoteTableViewCell?;
        
        if (cell == nil){
            cell = ANoteTableViewCell(vc: self.vc, mainView: self.mainView, style: .default, reuseIdentifier: cellId);
        }

        cell?.initialize(indexPath, aNoteTable: aNoteTable);

        print("3: \(cell!.getTitle())");

        return cell! as UITableViewCell;
    }


    
    /********************************************************************************************************************************/
    /* @fcn       tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)                                 */
    /* @details   handle cell tap                                                                                                   */
    /********************************************************************************************************************************/
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated:true);
        
        let cell : ANoteTableViewCell = self.getCell(indexPath);

        if(verbose){ print("ANoteTableViewHandler.tableView():  handling a cell tap of \(cell.tableIndex!)"); }

        //Launch the SubView
        cell.launchSubView();

        print("4");
        
        return;
    }


    /********************************************************************************************************************************/
    /* @fcn       getCell(indexPath: NSIndexPath) -> aNoteTableViewCell                                                             */
    /* @details   acquire a cell from the table                                                                                     */
    /********************************************************************************************************************************/
    func getCell(_ indexPath: IndexPath) -> ANoteTableViewCell {
        
        if(verbose){ print("ANoteTableViewHandler.getCell():    returning cell \(indexPath.item)"); }
        
        return aNoteTable.cellForRow(at: indexPath) as! ANoteTableViewCell!;
    }
}

