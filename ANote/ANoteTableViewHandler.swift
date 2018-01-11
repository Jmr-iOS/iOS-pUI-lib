/************************************************************************************************************************************/
/** @file       ANoteTableViewHandler.swift
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


class ANoteTableViewHandler : UICustomTableViewHandler {
    
    var vc         : ViewController!;
    var mainView   : UIView!;
    var aNoteTable : ANoteTableView!;
    
    let nearColor:UIColor = UIColor(red: 255/255, green:  60/255, blue:  60/255, alpha: 1);
    let farColor :UIColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1);


    /********************************************************************************************************************************/
    /* @fcn       init()                                                                                                            */
    /* @details                                                                                                                     */
    /********************************************************************************************************************************/
    init(vc : ViewController, mainView : UIView, ANoteTable : ANoteTableView) {
        
        super.init(table: ANoteTable);
        
        self.vc = vc;
        self.mainView = mainView;
        self.aNoteTable = ANoteTable;
        
        if(verbose){ print("ANoteTableViewHandler.init():       initialized"); }
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /* @fcn       tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int                                      */
    /* @details   get how many rows in specified section                                                                            */
    /********************************************************************************************************************************/
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if(verbose){ print("ANoteTableViewHandler.tableView():  The table will now have \(self.vc.rows.count), cause I just said so..."); }

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

