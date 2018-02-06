/************************************************************************************************************************************/
/** @file       ANoteTimeSelect.swift
 *  @project    x
 *  @brief      x
 *  @details    x
 *
 *  @notes      x
 *
 *  @section    Opens
 *      responds to value changes to date
 *      change done button once value changes
 *      pass value on 'Done' selection          (and demo uses)
 *      pass notice on Cancel selection         (and demo uses)
 *
 *  @section    Legal Disclaimer
 *      All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 *      Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class ANoteTimeSelect : UIView, UITableViewDataSource, UITableViewDelegate {
    
    let startDate : Date;                                               /* date on init                                             */
    
    let width      : CGFloat = wS;
    let height     : CGFloat = 517;                                     /* full view height                                         */

    var rowHeights : [CGFloat] = [45, 92, 188, 49, 49, 48, 0];          /* height of each row in table                              */
    
    var isRaised   : Bool;
    
    //Parent
    var vc : ViewController;
    var parentCell : NewTableViewCell;
    
    //UI
    var tableView : UITableView!;
    var picker    : UIDatePicker!;
    var cancelButton : UIButton!;
    var doneButton  : UIButton!;

    //Constants
    let verbose : Bool = true;
    let buttonTextColor = UIColor(red:1.00, green:0.66, blue:0.00, alpha:1.0);      /* #ffa800                                      */

    
    /********************************************************************************************************************************/
    /** @fcn        init(_ vc : ViewController,_ parentCell : NewTableViewCell,_ date : Date?)
     *  @brief      x
     *  @details    x
     *
     *  @section    Opens
     *      View has correct height
     */
    /********************************************************************************************************************************/
    init(_ vc : ViewController,_ parentCell : NewTableViewCell,_ date : Date?) {

        //Init Constants
        //@pre (temp)
        let h = rowHeights.reduce(0, +);
        rowHeights[rowHeights.count-1] = rowHeights[rowHeights.count-1] + (height-h);

        if(date != nil) {
            startDate = date!;                              /* store value                                                          */
        } else {
            startDate = Date();                             /* equals current date                                                  */
        }
        
        //Init State
        self.vc = vc;
        self.parentCell = parentCell;
        
        
        if(verbose){ print("ANoteTimeSelect.init():             adding a standard table"); }
        
        //Init below screen
        let frame = CGRect(x: 0, y: hS, width: width, height: height);
        
        //Init Vars
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
     *  @brief      show the popup onscreen
     *  @details    x
     */
    /********************************************************************************************************************************/
    func show(_ vc : ViewController) {
        
        //slide up
        loadPopup(vc, dir: true, height: height);
        
        if(verbose){ print("ANoteTimeSelect.show():             shown"); }
        
        return;
    }


    /********************************************************************************************************************************/
    /** @fcn        dismiss()
     *  @brief      dismiss the popup onscreen
     *  @details    x
     */
    /********************************************************************************************************************************/
    func dismiss(_ vc : ViewController) {
        
        //@todo     slide down
        loadPopup(vc, dir: false, height: height);
        
        if(verbose){ print("ANoteTimeSelect.dismiss():          dismissed"); }
        
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
            
            //Add to view
            vc.view.addSubview(self);

            //Launch with animation
            UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                if(self.verbose){ print("ANoteTimeSelect.loadPopup():        sliding popup in"); }
                self.frame = CGRect(x: 0, y: hS-height, width: vc.view.frame.width, height: height);
                self.isRaised = false;
                viewOpen = false;
            }, completion: { (finished: Bool) -> Void in
                if(self.verbose){ print("ANoteTimeSelect.loadPopup():        sliding popup in completion"); }
                self.isRaised = true;
            });
        } else {
            
            if(verbose) { print("ANoteTimeSelect.loadPopup():        popup dismissed"); }
            
            //Remove from view
            UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                if(self.verbose){ print("ANoteTimeSelect.loadPopup():        sliding popup out"); }
                self.frame = CGRect(x: 0, y: hS, width: vc.view.frame.width, height: height);
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
        let labelFrame = CGRect(x: 0, y: 1, width: wS, height: ((cell?.frame.height)!));
        
        //UILabel  ("To-do Info")
        let label = UILabel();                                                      /* init                                         */
        label.textAlignment = .center;                                              /* x-alignment of text                          */
        label.font = UIFont(name: fnt.fontName+"-Medium", size: (fnt.pointSize));
        label.textColor = UIColor.black;
        label.frame = labelFrame;                                                   /* location in view                             */
        label.translatesAutoresizingMaskIntoConstraints = true;                     /* allow constraints                            */
        label.text = "To-do Info";                                                  /* set the displayed text                       */

        //UIButton ("Cancel") - enabled
        cancelButton = UIButton(type: UIButtonType.roundedRect);
        cancelButton.titleLabel?.font = UIFont(name: fnt.fontName, size: (fnt.pointSize-1));
        cancelButton.setTitleColor(buttonTextColor, for: .normal);
        cancelButton.translatesAutoresizingMaskIntoConstraints = true;
        cancelButton.setTitle("Cancel", for: .normal);
        cancelButton.sizeToFit();
        cancelButton.center = CGPoint(x: (cancelButton.frame.width/2+8), y: 26);
        cancelButton.contentHorizontalAlignment = .left;
        cancelButton.contentVerticalAlignment   = .top;
        cancelButton.addTarget(self, action: #selector(self.cancelPressed(_:)), for:  .touchUpInside);
        
        //UIButton ("Done") -> disabled
        doneButton = UIButton(type: UIButtonType.roundedRect);
        doneButton.titleLabel?.font = UIFont(name: fnt.fontName+"-Medium", size: (fnt.pointSize-1));
        doneButton.translatesAutoresizingMaskIntoConstraints = true;
        doneButton.setTitle("Done", for: .normal);
        doneButton.sizeToFit();
        updateDoneButton(false);                                                /* set to disabled                                  */
        
        let x : CGFloat = wS - 28;
        doneButton.center = CGPoint(x: x, y: 26);
        doneButton.contentHorizontalAlignment = .left;
        doneButton.contentVerticalAlignment   = .top;
        doneButton.addTarget(self, action: #selector(self.donePressed(_:)), for:  .touchUpInside);
        
        //Add upper board
        let upperBorder = UIView();
        upperBorder.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1.0);
        upperBorder.frame = CGRect(x: 0, y: 0, width: wS, height: 1);

        //Add to view
        cell?.addSubview(label);
        cell?.addSubview(cancelButton);
        cell?.addSubview(doneButton);
        cell?.addSubview(upperBorder);
        
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
        
        //Constants
        let wBtn  : CGFloat = 80;                                       /* width of button                                          */
        let xMid  : CGFloat = (wS/2)-(wBtn/2);  /* middle of screen                                         */
        let xBtn  : CGFloat = 88;                                       /* delta between row[1] buttons                             */
        let xOffs : CGFloat = 8;                                        /* offset of buttons in row                                 */

        //Acquire Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as UITableViewCell!;
    
        //Label
        let titleLabel = UILabel();
        titleLabel.textAlignment = .left;
        titleLabel.textColor = UIColor.darkGray;
        titleLabel.frame.origin.x = 25;
        titleLabel.frame.origin.y = 13;
        titleLabel.translatesAutoresizingMaskIntoConstraints = true;
        titleLabel.font = UIFont(name: ".SFUIText", size: 15.25);
        titleLabel.text = "Due Date";
        titleLabel.sizeToFit();
        
        //Switch
        let alarmSwitch = UISwitch();
        alarmSwitch.frame.origin = CGPoint(x: wS - 65, y: 8);
        alarmSwitch.onTintColor = UIColor(red:1.00, green:0.67, blue:0.00, alpha:1.0);
        alarmSwitch.addTarget(self, action: #selector(self.alarmPressed(_:)), for: UIControlEvents.valueChanged);
        
        //Three Buttons (Today, Tomorrow, Someday)  (-1 font, darkGray title) (with selection)
        let todayButton = UIButton(type: UIButtonType.roundedRect);
        todayButton.translatesAutoresizingMaskIntoConstraints = true;
        todayButton.setTitle("Today",      for: UIControlState());
        todayButton.titleLabel?.font = UIFont(descriptor: (todayButton.titleLabel?.font.fontDescriptor)!, size: (todayButton.titleLabel?.font.pointSize)!-1);
        todayButton.setTitleColor(UIColor.darkGray, for: .normal);
        todayButton.sizeToFit();
        todayButton.frame = CGRect(x: (xMid-xBtn+xOffs), y: 50, width: wBtn, height: 32);
        todayButton.setTitleColor(UIColor.black, for: .normal);
        todayButton.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0);
        todayButton.clipsToBounds = true;
        todayButton.layer.cornerRadius = 5;
        //!todayButton.addTarget(self, action: #selector(ViewController.secondPressed(_:)), for:  .touchUpInside);
        
        let tommButton = UIButton(type: UIButtonType.roundedRect);
        tommButton.translatesAutoresizingMaskIntoConstraints = true;
        tommButton.setTitle("Tomorrow",      for: UIControlState());
        tommButton.titleLabel?.font = UIFont(descriptor: (todayButton.titleLabel?.font.fontDescriptor)!, size: (todayButton.titleLabel?.font.pointSize)!-1);
        tommButton.setTitleColor(UIColor.darkGray, for: .normal);
        tommButton.sizeToFit();
        tommButton.frame = CGRect(x: (xMid+xOffs), y: 50, width: wBtn, height: 32);
        tommButton.setTitleColor(UIColor.black, for: .normal);
        tommButton.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0);
        tommButton.clipsToBounds = true;
        tommButton.layer.cornerRadius = 5;
        //!tommButton.addTarget(self, action: #selector(ViewController.secondPressed(_:)), for:  .touchUpInside);
        
        let someButton = UIButton(type: UIButtonType.roundedRect);
        someButton.translatesAutoresizingMaskIntoConstraints = true;
        someButton.setTitle("Someday",      for: UIControlState());
        someButton.titleLabel?.font = UIFont(descriptor: (todayButton.titleLabel?.font.fontDescriptor)!, size: (todayButton.titleLabel?.font.pointSize)!-1);
        someButton.setTitleColor(UIColor.darkGray, for: .normal);
        someButton.sizeToFit();
        someButton.frame = CGRect(x: (xMid+xBtn+xOffs), y: 50, width: wBtn, height: 32);
        someButton.setTitleColor(UIColor.black, for: .normal);
        someButton.backgroundColor = UIColor(red:0.90, green:0.90, blue:0.90, alpha:1.0);
        someButton.clipsToBounds = true;
        someButton.layer.cornerRadius = 5;
        //!someButton.addTarget(self, action: #selector(ViewController.secondPressed(_:)), for:  .touchUpInside);
        
        //Add to view
        cell?.addSubview(titleLabel);
        cell?.addSubview(alarmSwitch);
        cell?.addSubview(todayButton);
        cell?.addSubview(tommButton);
        cell?.addSubview(someButton);
        
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
        
        //Label
        let titleLabel = UILabel();
        titleLabel.textAlignment = .left;
        titleLabel.textColor = UIColor.darkGray;
        titleLabel.frame.origin.x = 25;
        titleLabel.frame.origin.y = 13;
        titleLabel.translatesAutoresizingMaskIntoConstraints = true;
        titleLabel.font = UIFont(name: ".SFUIText", size: 15.25);
        titleLabel.text = "All Day";
        titleLabel.sizeToFit();
        
        //Switch
        let allDaySwitch = UISwitch();
        allDaySwitch.frame.origin = CGPoint(x: wS - 65, y: 8);
        allDaySwitch.onTintColor = UIColor(red:1.00, green:0.67, blue:0.00, alpha:1.0);
        //!allDaySwitch.addTarget(self, action: #selector(self.allDayPressed(_:)), for: UIControlEvents.valueChanged);
        
        //Time Selector
        addPicker_aNote(cell!);
        
        //Add to view
        cell?.addSubview(titleLabel);
        cell?.addSubview(allDaySwitch);
        
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
        
        var x : CGFloat;                                        /* used for calcs                                                   */
        
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
        x = wS - (valueLabel.frame.width+35);
        valueLabel.frame = CGRect(x: x, y: 13.5, width: (valueLabel.frame.width), height: (valueLabel.frame.height));
        
        //Init Button
        x = (wS - 23);
        let button : UIButton = UIButton(frame:CGRect(x: x, y: 15, width: 10, height: 16));
        button.setBackgroundImage(UIImage(named:"TimeSelectArrow"), for: UIControlState());
        button.addTarget(self, action: #selector(self.rowArrowPressed(_:)), for:  .touchUpInside);

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
        
        var x : CGFloat;                                        /* used for calcs                                                   */
        
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
        x = wS - (valueLabel.frame.width+35);
        valueLabel.frame = CGRect(x: x, y: 13.5, width: (valueLabel.frame.width), height: (valueLabel.frame.height));
        
        //Init Button
        x = (wS - 23);
        let button : UIButton = UIButton(frame:CGRect(x: x, y: 15, width: 10, height: 16));
        button.setBackgroundImage(UIImage(named:"TimeSelectArrow"), for: UIControlState());
        button.addTarget(self, action: #selector(self.rowArrowPressed(_:)), for:  .touchUpInside);
        
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
        
        var x : CGFloat;                                        /* used for calcs                                                   */
        
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
        x = wS - (valueLabel.frame.width+35);
        valueLabel.frame = CGRect(x: x, y: 13.5, width: (valueLabel.frame.width), height: (valueLabel.frame.height));
        
        //Init Button
        x = (wS - 23);
        let button : UIButton = UIButton(frame:CGRect(x: x, y: 15, width: 10, height: 16));
        button.setBackgroundImage(UIImage(named:"TimeSelectArrow"), for: UIControlState());
        button.addTarget(self, action: #selector(self.rowArrowPressed(_:)), for:  .touchUpInside);

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
        
        //Gen fullsize frame (cell not sized yet)
        let f = cell?.frame;
        let bFrame = CGRect(x: (f?.origin.x)!, y: (f?.origin.y)!, width: wS, height: (f?.height)!);
        
        //Init Button
        let button : UIButton = UIButton(frame:bFrame);
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

    
//**********************************************************************************************************************************//
//                                              BUTTON RESPONSES                                                                    //
//**********************************************************************************************************************************//
    
    /********************************************************************************************************************************/
    /** @fcn        addPicker_aNote(_ view:UIView)
     *  @brief      add the date picker in the view
     *  @details    x
     */
    /********************************************************************************************************************************/
    func addPicker_aNote(_ view:UIView) {
        
        let dateFrame = CGRect(x: (wS/2-160), y: 35, width: 330, height: 150);
        
        //Init
        picker = UIDatePicker(frame: dateFrame);
        picker.datePickerMode = UIDatePickerMode.dateAndTime;
        picker.timeZone =  TimeZone.init(abbreviation: "PST");
        
        picker.date = startDate;                                        /* set to passed value on load                              */
        
        //Add Handle
        picker.addTarget(self, action: #selector(dateValueChange), for: UIControlEvents.valueChanged);
        
        //Add
        view.addSubview(picker);
        
        //Print the date
        let dateFormatter = getStandardFormatter();

        if(self.verbose){ print("ANoteTimeSelect.load_row2():        picker added for date: \(dateFormatter.string(from: picker.date))"); }
        
        return;
    }
    

    /********************************************************************************************************************************/
    /** @fcn        updateFromPicker(sender: UIDatePicker)
     *  @brief      respond to date selection
     *  @details    enable done on first value change
     */
    /********************************************************************************************************************************/
    @objc func dateValueChange(sender: UIDatePicker) {

        //Enable button
        updateDoneButton(true);
        
        if(verbose) { print("ANoteTimeSelect.dateValueChange():  date change response complete"); }
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        updateDoneButton(_ enable : Bool)
     *  @brief      update button state based on enabled
     *  @details    colored if enabled else gray
     */
    /********************************************************************************************************************************/
    func updateDoneButton(_ enable : Bool) {

        let doneColor = (enable) ? buttonTextColor : (UIColor.lightGray);       /* on:color, off:gray                               */
        
        doneButton.setTitleColor(doneColor, for: .normal);
        doneButton.isEnabled = enable;
        
        return;
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
        dismiss(vc);
        
        if(self.verbose){ print("ANoteTimeSelect.cancelPressed():    '\(sender.titleLabel!.text!)' was pressed"); }
        
        return;
    }
    
    
    
    /********************************************************************************************************************************/
    /** @fcn        donePressed(_ sender: UIButton!)
     *  @brief      x
     *  @details    x
     *
     *  @section    Observed Responses
     *  2/2 @ 2:02 AM - 2/2 @ 10:02
     *  2/3 @ 3:03 AM - 2/3 @ 11:03
     *  2/3 @ 3:03 PM - 2/3 @ 23:03     (+12)   <- Time zone UTC!
     */
    /********************************************************************************************************************************/
    @objc func donePressed(_ sender: UIButton!) {

        //Store date
        parentCell.updateDate(picker.date);
        
        //Dismiss view
        dismiss(vc);

        if(verbose){ print("ANoteTimeSelect.donePressed():      '\(sender.titleLabel!.text!)' was pressed"); }
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        rowArrowPressed(_: (UIButton?))
     *  @brief      handle the search button selection
     *  @details    x
     *  @note       @objc exposed to enable assignment for button response, not sure why
     */
    /********************************************************************************************************************************/
    @objc func rowArrowPressed(_ sender : (UIButton!)) {
        if(self.verbose){ print("ANoteTimeSelect.rowArrowPressed():  row arrow button was pressed"); }
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        func removePressed(_: (UIButton?))
     *  @brief      handle the switch selection
     *  @details    x
     *  @note       @objc exposed to enable assignment for button response, not sure why
     */
    /********************************************************************************************************************************/
    @objc func removePressed(_ sender : (UIButton!)) {
        
        //Remove the date from cell
        parentCell.updateDate(nil);                                 /* remove date from cell                                        */
        
        //Dismiss view
        dismiss(vc);
        
        if(self.verbose){ print("ANoteTimeSelect.removePressed():    switch was pressed"); }
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        func alarmPressed(_: (UIButton?))
     *  @brief      handle the switch selection
     *  @details    x
     *  @note       @objc exposed to enable assignment for button response, not sure why
     */
    /********************************************************************************************************************************/
    @objc func alarmPressed(_ sender : (UIButton!)) {
        if(self.verbose){ print("ANoteTimeSelect.alarmPressed():     switch was pressed"); }
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
        
        if(verbose){ print("ANoteTimeSelect.tableView(DSR):      hello standard cell at index \(indexPath)- '\("currCell.textLabel!.text")'"); }
        
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
    /** @fcn        getStandardFormatter() -> DateFormatter
     *  @brief      get the standard date formatter for use
     *  @details    code snippet repeated often, encapsulated for cleanliness
     */
    /********************************************************************************************************************************/
    func getStandardFormatter() -> DateFormatter {
        
        let dateFormatter = DateFormatter();
        
        dateFormatter.locale = Locale(identifier: "en_US");
        dateFormatter.timeZone = TimeZone(identifier: "PST");
        dateFormatter.dateStyle = .medium;
        dateFormatter.timeStyle = .none;
        dateFormatter.amSymbol = "AM";
        dateFormatter.pmSymbol = "PM";
        
        return dateFormatter;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        getDate() -> Date
     *  @brief      get date for view selection
     *  @details    x
     */
    /********************************************************************************************************************************/
    func getDate() -> Date {
        return picker.date;                                             /* it is just the active date value                         */
    }
    
    
    /********************************************************************************************************************************/
    /* @fcn        required init?(coder aDecoder: NSCoder)                                                                          */
    /********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }

}

