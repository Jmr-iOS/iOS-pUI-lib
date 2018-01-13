/************************************************************************************************************************************/
/** @file       ANoteTimeSelect.swift
 *  @project    x
 *  @brief      x
 *  @details    x
 *
 *  @notes      x
 *
 *  @section    Opens
 *      none listed
 *
 *  @section    Legal Disclaimer
 *      All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 *      Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class ANoteTimeSelect : UIView, UITableViewDataSource, UITableViewDelegate {
    
    let width     : CGFloat = UIScreen.main.bounds.width;
    let height    : CGFloat = 517;                                      /* full view height                                         */

    var rowHeights : [CGFloat] = [45, 92, 188, 49, 49, 48, 0];          /* height of each row in table                              */
    
    var isRaised   : Bool;
    
    var vc : ViewController;
    
    //UI
    var tableView : UITableView!;
    
    //Constants
    let verbose : Bool = true;
    
    
    /********************************************************************************************************************************/
    /** @fcn        init()
     *  @brief      x
     *  @details    x
     *
     *  @section    Opens
     *      View has correct height
     */
    /********************************************************************************************************************************/
    init(_ vc : ViewController) {

        //Init Constants
        //@pre (temp)
        let h = rowHeights.reduce(0, +);
        rowHeights[rowHeights.count-1] = rowHeights[rowHeights.count-1] + (height-h);
        
        if(verbose){ print("ANoteTimeSelect.init():             adding a standard table"); }
        
        //Init below screen
        let frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: width, height: height);
        
        //Init Vars
        self.vc = vc;
        isRaised   = false;

        //Super
        super.init(frame: frame);
        
        //Init UI
        tableView = UITableView(frame:CGRect(x: 0, y: 0, width: frame.width, height: frame.height));
        
        tableView.delegate = self;                                                  /* Set both to handle clicks & provide data     */
        tableView.dataSource = self;
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell");   /* I have no idea why we do this                */
        tableView.translatesAutoresizingMaskIntoConstraints = false;                /* Std                                          */
        
        tableView.separatorColor = UIColor.gray;
        tableView.separatorStyle = .singleLine;
        
        //Safety
        tableView.backgroundColor = UIColor.black;
        
        //Disable scrolling & selection
        tableView.allowsSelection = false;
        tableView.isScrollEnabled = false;
        
        if(verbose){ print("ANoteTimeSelect.show():             table initialization complete"); }
        
        //Add it!
        self.addSubview(tableView);
        
        if(verbose){ print("ANoteTimeSelect.show():             initialization complete"); }
        
        return;
    }


    /********************************************************************************************************************************/
    /** @fcn        show()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func show(_ vc : ViewController) {
        
        //@todo     slide up
        loadPopup(vc, dir: true, height: height);
        
        if(verbose){ print("ANoteTimeSelect.show():             shown"); }
        
        return;
    }


    /********************************************************************************************************************************/
    /** @fcn        loadPopup(_ dir : Bool)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func loadPopup(_ vc : ViewController, dir : Bool, height : CGFloat) {
        
        if(dir == true) {
            
            //@pre  Safety
            if(!viewOpen) {
                fatalError("View not open for display over, aborting");
            }
            
            vc.view.addSubview(self);

            UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                if(self.verbose){ print("ANoteTimeSelect.loadPopup():        sliding popup in!"); }
                self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height-height, width: vc.view.frame.width, height: height);
                self.isRaised = false;
                viewOpen = false;
            }, completion: { (finished: Bool) -> Void in
                if(self.verbose){ print("ANoteTimeSelect.loadPopup():        sliding popup in completion!"); }
                self.isRaised = true;
            });
        } else {
            print("ANoteTimeSelect.loadPopup():        off!");
            UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                if(self.verbose){ print("ANoteTimeSelect.loadPopup():        sliding popup out"); }
                self.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: vc.view.frame.width, height: height);
                self.isRaised = true;
            }, completion: { (finished: Bool) -> Void in
                if(self.verbose){ print("ANoteTimeSelect.loadPopup():        sliding popup out completion"); }
                self.isRaised = false;
                viewOpen = true;
            });
        }
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        load_row0() -> UITableViewCell
     *  @brief
     *  @details    x
     */
    /********************************************************************************************************************************/
    func load_row0() -> UITableViewCell {
        
        //helpers
        let fnt : UIFont = (UIButton().titleLabel?.font)!;                          /* standard UIButton font                       */

        //Acquire Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!;
        
        //Constants
        let labelFrame = CGRect(x: 0,
                                y: 1,
                                width: UIScreen.main.bounds.width,
                                height: ((cell?.frame.height)!));
        
        //UILabel  ("To-do Info")
        let myFirstLabel = UILabel();                                               /* init                                         */
        myFirstLabel.textAlignment = .center;                                       /* x-alignment of text                          */
        myFirstLabel.font = UIFont(name: fnt.fontName+"-Medium", size: (fnt.pointSize));
        myFirstLabel.textColor = UIColor.black;
        myFirstLabel.frame = labelFrame;                                            /* location in view                             */
        myFirstLabel.translatesAutoresizingMaskIntoConstraints = true;              /* allow constraints                            */
        myFirstLabel.text = "To-do Info";                                           /* set the displayed text                       */
        cell?.addSubview(myFirstLabel);                                             /* add to view                                  */

        //UIButton ("Cancel") - enabled
        let cancelButton = UIButton(type: UIButtonType.roundedRect);
        cancelButton.titleLabel?.font = UIFont(name: fnt.fontName, size: (fnt.pointSize-1));
        cancelButton.setTitleColor(UIColor.orange, for: .normal);
        cancelButton.translatesAutoresizingMaskIntoConstraints = true;
        cancelButton.setTitle("Cancel", for: .normal);
        cancelButton.sizeToFit();
        cancelButton.center = CGPoint(x: (cancelButton.frame.width/2+8), y: 26);
        cancelButton.contentHorizontalAlignment = .left;
        cancelButton.contentVerticalAlignment   = .top;
        cancelButton.addTarget(self, action: #selector(self.cancelPressed(_:)), for:  .touchUpInside);
        cell?.addSubview(cancelButton);
        
        //UIButton ("Done") -> disabled
        let doneButton = UIButton(type: UIButtonType.roundedRect);
        doneButton.titleLabel?.font = UIFont(name: fnt.fontName+"-Medium", size: (fnt.pointSize-1));
        doneButton.setTitleColor(UIColor.gray, for: .normal);
        doneButton.translatesAutoresizingMaskIntoConstraints = true;
        doneButton.setTitle("Done", for: .normal);
        doneButton.sizeToFit();
        doneButton.isEnabled = false;                                           /* set to disabled                                  */
        
        let x : CGFloat = UIScreen.main.bounds.width - 28;
        doneButton.center = CGPoint(x: x, y: 26);
        doneButton.contentHorizontalAlignment = .left;
        doneButton.contentVerticalAlignment   = .top;
        doneButton.addTarget(self, action: #selector(self.donePressed(_:)), for:  .touchUpInside);
        cell?.addSubview(doneButton);

        
        if(self.verbose){ print("ANoteTimeSelect.load_row0():        row 0 load complete"); }
        
        return cell!;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        load_row1() -> UITableViewCell
     *  @brief
     *  @details    x
     */
    /********************************************************************************************************************************/
    func load_row1() -> UITableViewCell {
        
        //Acquire Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!;
    
        if(self.verbose){ print("ANoteTimeSelect.load_row1():        row 1 load complete"); }
        
        return cell!;
    }
    
    
    
    
    /********************************************************************************************************************************/
    /** @fcn        load_row2() -> UITableViewCell
     *  @brief
     *  @details    x
     */
    /********************************************************************************************************************************/
    func load_row2() -> UITableViewCell {
        
        //Acquire Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!;
        
        if(self.verbose){ print("ANoteTimeSelect.load_row2():        row 2 load complete"); }
        
        return cell!;
    }
    
    
    
    /********************************************************************************************************************************/
    /** @fcn        load_row3() -> UITableViewCell
     *  @brief      Alarm and 'At time of event'
     *  @details    x
     */
    /********************************************************************************************************************************/
    func load_row3() -> UITableViewCell {
        
        //Acquire Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!;
        
        //Init Title Label
        let titleLabel = UILabel();
        titleLabel.textAlignment = .left;
        titleLabel.textColor = UIColor.darkGray;
        titleLabel.frame.origin.x = 25;
        titleLabel.frame.origin.y = 13;
        titleLabel.translatesAutoresizingMaskIntoConstraints = true;
        titleLabel.font = UIFont(name: ".SFUIText", size: 15.25);
        titleLabel.text = "Alarm";
        titleLabel.sizeToFit();
        
        //Init Value Label
        let valueLabel = UILabel();
        valueLabel.textColor = UIColor.gray;
        valueLabel.translatesAutoresizingMaskIntoConstraints = true;
        valueLabel.font = UIFont(name: ".SFUIText", size: 15.25);
        valueLabel.text = "At time of event";
        valueLabel.sizeToFit();
        let x = UIScreen.main.bounds.width - (valueLabel.frame.width+35);
        valueLabel.frame = CGRect(x: x, y: 13.5, width: (valueLabel.frame.width), height: (valueLabel.frame.height));
        
        //Init Button
        let button : UIButton = UIButton(frame:CGRect(x: 297, y: 15, width: 10, height: 16));
        button.setBackgroundImage(UIImage(named:"TimeSelectArrow"), for: UIControlState());
        button.addTarget(self, action: #selector(self.removePressed(_:)), for:  .touchUpInside);
        
        //Add to view
        cell?.addSubview(titleLabel);
        cell?.addSubview(valueLabel);
        cell?.addSubview(button);
        
        if(self.verbose){ print("ANoteTimeSelect.load_row3():        row 3 load complete"); }

        return cell!;
    }
    
    
    
    /********************************************************************************************************************************/
    /** @fcn        load_row4() -> UITableViewCell
     *  @brief      Repeat and Never
     *  @details    x
     */
    /********************************************************************************************************************************/
    func load_row4() -> UITableViewCell {
        
        //Acquire Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!;
        
        //Init Title Label
        let titleLabel = UILabel();
        titleLabel.textAlignment = .left;
        titleLabel.textColor = UIColor.darkGray;
        titleLabel.frame.origin.x = 25;
        titleLabel.frame.origin.y = 13;
        titleLabel.translatesAutoresizingMaskIntoConstraints = true;
        titleLabel.font = UIFont(name: ".SFUIText", size: 15.25);
        titleLabel.text = "Repeat";
        titleLabel.sizeToFit();
        
        //Init Value Label
        let valueLabel = UILabel();
        valueLabel.textColor = UIColor.gray;
        valueLabel.translatesAutoresizingMaskIntoConstraints = true;
        valueLabel.font = UIFont(name: ".SFUIText", size: 15.25);
        valueLabel.text = "Never";
        valueLabel.sizeToFit();
        let x = UIScreen.main.bounds.width - (valueLabel.frame.width+35);
        valueLabel.frame = CGRect(x: x, y: 13.5, width: (valueLabel.frame.width), height: (valueLabel.frame.height));
        
        //Init Button
        let button : UIButton = UIButton(frame:CGRect(x: 297, y: 15, width: 10, height: 16));
        button.setBackgroundImage(UIImage(named:"TimeSelectArrow"), for: UIControlState());
        button.addTarget(self, action: #selector(self.removePressed(_:)), for:  .touchUpInside);
        
        //Add to view
        cell?.addSubview(titleLabel);
        cell?.addSubview(valueLabel);
        cell?.addSubview(button);
        
        if(self.verbose){ print("ANoteTimeSelect.load_row4():        row 4 load complete"); }
        
        return cell!;
    }
    
    
    
    
    /********************************************************************************************************************************/
    /** @fcn        load_row5() -> UITableViewCell
     *  @brief      Status and None
     *  @details    x
     */
    /********************************************************************************************************************************/
    func load_row5() -> UITableViewCell {
        
        //Acquire Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!;
        
        //Init Title Label
        let titleLabel = UILabel();
        titleLabel.textAlignment = .left;
        titleLabel.textColor = UIColor.darkGray;
        titleLabel.frame.origin.x = 25;
        titleLabel.frame.origin.y = 13;
        titleLabel.translatesAutoresizingMaskIntoConstraints = true;
        titleLabel.font = UIFont(name: ".SFUIText", size: 15.25);
        titleLabel.text = "Status";
        titleLabel.sizeToFit();

        //Init Value Label
        let valueLabel = UILabel();
        valueLabel.textColor = UIColor.gray;
        valueLabel.translatesAutoresizingMaskIntoConstraints = true;
        valueLabel.font = UIFont(name: ".SFUIText", size: 15.25);
        valueLabel.text = "None";
        valueLabel.sizeToFit();
        let x = UIScreen.main.bounds.width - (valueLabel.frame.width+35);
        valueLabel.frame = CGRect(x: x, y: 13.5, width: (valueLabel.frame.width), height: (valueLabel.frame.height));
        
        //Init Button
        let button : UIButton = UIButton(frame:CGRect(x: 297, y: 15, width: 10, height: 16));
        button.setBackgroundImage(UIImage(named:"TimeSelectArrow"), for: UIControlState());
        button.addTarget(self, action: #selector(self.removePressed(_:)), for:  .touchUpInside);

        //Add to view
        cell?.addSubview(titleLabel);
        cell?.addSubview(valueLabel);
        cell?.addSubview(button);
        
        if(self.verbose){ print("ANoteTimeSelect.load_row5():        row 5 load complete"); }
        
        return cell!;
    }
    
    
    
    /********************************************************************************************************************************/
    /** @fcn        load_row6() -> UITableViewCell
     *  @brief      add 'Remove To-do Info' button in red
     *  @details    x
     */
    /********************************************************************************************************************************/
    func load_row6() -> UITableViewCell {
        
        //Acquire Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!;
        
        //Init Button
        let button : UIButton = UIButton(frame:(cell?.frame)!);
        button.setTitle("Remove To-do Info", for: .normal);
        button.titleLabel?.font = UIFont(descriptor: (button.titleLabel?.font.fontDescriptor)!,
                                         size:       ((button.titleLabel?.font.pointSize)!-2));
        button.setTitleColor(UIColor.red, for: .normal);
        button.addTarget(self, action: #selector(self.removePressed(_:)), for:  .touchUpInside);
        
        //Add
        cell?.addSubview(button);
        
        if(self.verbose){ print("ANoteTimeSelect.load_row6():        row 6 load complete, remove button inserted"); }
        
        return cell!;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        cancelPressed(_ sender: UIButton!)
     *  @brief      dismiss the view
     *  @details    x
     *  @open       respond to cancel event
     */
    /********************************************************************************************************************************/
    @objc func cancelPressed(_ sender: UIButton!) {
        
        //Dismiss view
        loadPopup(vc, dir: false, height: height);

        if(self.verbose){ print("ANoteTimeSelect.cancelPressed():    '\(sender.titleLabel!.text!)' was pressed"); }
        
        return;
    }
    
    
    
    /********************************************************************************************************************************/
    /** @fcn        donePressed(_ sender: UIButton!)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    @objc func donePressed(_ sender: UIButton!) {

        //Dismiss view
        loadPopup(vc, dir: false, height: height);

        if(self.verbose){ print("ANoteTimeSelect.donePressed():      '\(sender.titleLabel!.text!)' was pressed"); }
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        func removePressed(_: (UIButton?))
     *  @brief      handle the search button selection
     *  @details    x
     *  @note       @objc exposed to enable assignment for button response, not sure why
     */
    /********************************************************************************************************************************/
    @objc func removePressed(_ sender : (UIButton!)) {
        if(self.verbose){ print("ANoteTimeSelect.removePressed():    '\(sender.titleLabel!.text!)' was pressed"); }
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        getNumRows() -> Int
     *  @brief      get number of rows in table
     *  @details    x
     */
    /********************************************************************************************************************************/
    func getNumRows() -> Int {
        return rowHeights.count;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        getTableHeight() -> CGFloat
     *  @brief      get height of all rows
     *  @details    x
     */
    /********************************************************************************************************************************/
    func getTableHeight() -> CGFloat {
        return rowHeights.reduce(0, +);
    }
    
    
/************************************************************************************************************************************/
/*                                    UITableViewDataSource, UITableViewDelegate Interfaces                                         */
/************************************************************************************************************************************/
    
    /********************************************************************************************************************************/
    /** @fcn        tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        if(verbose){ print("ViewController.tableView(NRS):      the table will now have \(getNumRows()), cause I just said so..."); }
        
        return getNumRows();                                                /* return how many rows you want printed....!           */
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(verbose){ print("ANoteTimeSelect.tableView(cFR):     adding a cell"); }
        
        //Grab
        let cell : UITableViewCell?;

        switch(indexPath.item) {
            case 0:
                cell = load_row0();
                break;
            case 1:
                cell = load_row1();
                break;
            case 2:
                cell = load_row2();
                break;
            case 3:
                cell = load_row3();
                break;
            case 4:
                cell = load_row4();
                break;
            case 5:
                cell = load_row5();
                break;
            case 6:
                cell = load_row6();
                break;
            default:
                fatalError("Bad cell returned, aborting");
        }
        
        
        //Config
        cell?.textLabel?.text = "";                                                             /* text                             */
        cell?.textLabel?.font = UIFont(name: (cell?.textLabel!.font.fontName)!, size: 20);      /* font                             */
        cell?.textLabel?.textAlignment = NSTextAlignment.center;                                /* alignment                        */
        cell?.selectionStyle = UITableViewCellSelectionStyle.none;                              /* tap ui response                  */

        if(verbose){ print("ANoteTimeSelect.tableView(cFR):     adding a cell complete"); }
        
        return cell!;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(verbose){ print("ANoteTimeSelect.tableView(DSR):      handling a cell tap of \((indexPath as NSIndexPath).item)"); }
        
        tableView.deselectRow(at: indexPath, animated:true);
        
        let _/*currCell*/ : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!;
        
        if(verbose){ print("ANoteTimeSelect.tableView(DSR):      hello standard cell at index \(indexPath)- '\("currCell.textLabel!.text!")'"); }
        
        return;
    }


    /********************************************************************************************************************************/
    /** @fcn        tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
   
        if(verbose){ print("ANoteTimeSelect.tableView(MRA):       called"); }
        
        tableView.setEditing(false, animated: true);
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if(verbose){ print("ANoteTimeSelect.tableView(CER):     called"); }
        return true;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if(verbose){ print("ANoteTimeSelect.tableView(ESR):       called"); }
        return UITableViewCellEditingStyle.none;
    }
    

    /********************************************************************************************************************************/
    /** @fcn        tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(verbose){ print("ANoteTimeSelect.tableView(HFR):     called"); }
        return rowHeights[indexPath.item];
    }

    
    /********************************************************************************************************************************/
    /* @fcn        required init?(coder aDecoder: NSCoder)                                                                          */
    /********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }

}

