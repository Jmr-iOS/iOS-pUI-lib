/************************************************************************************************************************************/
/** @file		NewTableViewCell.swift
 *  @brief      x
 *  @details    x
 *
 *  @section    Opens
 *      add images for checkboxes as demo. post as demo to SE
 *
 *  @section    Notes
 *      Color changing is not exposed for the checkbox and the solution is instead to use pictures to apply color
 *
 *  @section    Legal Disclaimer
 *       All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 *       Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class NewTableViewCell : UICustomTableViewCell, UICheckBoxDelegate {
    
    //App
    var vc : ViewController;
    var mainView : UIView;
    var aNoteTable : ANoteTableView;
    
    //Row
    var cellSubView : ANoteCellSubview?;
    
    //Main UI
    var checkBox  : UICheckbox!;
    var mainField : UILabel!;
    var bodyField : UILabel!;
    var bottField : UILabel!;
    
    //Misc UI
    var dateView  : UIView!;
    var dateLabel : UILabel!;
    var type      : CellType!;
    var bellIcon  : UIImageView!;
    
    //State
    var isComplete : Bool;                                                  /* if the cell has been initialized                     */
    var tableIndex : Int;
    
    //Config
    let cell_fontName : String = cellFont;
    let numLines_main : Int = 2;                                            /* number of lines to apply to main text                */
    
    
    /********************************************************************************************************************************/
    /** @fcn        init(vc: ViewController, aNoteTable: ANoteTableView, index: Int, style: UITableViewCellStyle, reuseIdentifier: String?)
     *  @brief      x
     *  @details    x
     *
     *  @param      [in] (ViewController) vc - root view controller
     *  @param      [in] (ANoteTableView) aNoteTable - main table
     *  @param      [in] (Int) index - cell index into table
     *  @param      [in] (UITableViewCellStyle) style - style for cell
     *  @param      [in] (String?) reuseIdentifier - reuse id for cell
     *
     *  @note       mainView passed due to logical flow of initialization (not set yet in call flow)
     *
     *  @section    Opens
     *      make row border thinner & set to lighter color
     */
    /********************************************************************************************************************************/
    init(vc: ViewController, aNoteTable: ANoteTableView, index: Int, style: UITableViewCellStyle, reuseIdentifier: String?) {

        //Store
        self.vc = vc;
        self.mainView   = vc.view;
        self.aNoteTable = aNoteTable;
        self.tableIndex = index;
        
        //Init
        isComplete = false;
        
        //Super
        super.init(style:style, reuseIdentifier:reuseIdentifier);

        //Configure
        initialize();                                                           /* lay the cell out (move pre super()?              */

        //Dev setup
        setName("R\(index)");
        verbose = false;                                                        /* set cell verbose prints                          */

        //Dev-debug
        self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: cellHeight);
        
        if(verbose){ print("NewTableViewCell.init():            cell initialized"); }
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /* @fcn       initialize(indexPath : NSIndexPath, aNoteTable : aNoteTableView)                                                  */
    /* @details   initialize the cell, after creation                                                                               */
    /* @assum     already initialized when timeView not nil                                                                         */
    /********************************************************************************************************************************/
    func initialize() {
        
        //@pre  safety
        if(isComplete) {
            fatalError("cell was initialized but initialize() called again, aborting");
        }
        
        //Update height (oops)
        self.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: cellHeight);
        
        //Get Current Cell's Info
        let currRow = getRowValue();
        
        if(verbose) { print("aNoteTableViewCell.initialize():    adding: '\(currRow.main!)'"); }
   
        
        /****************************************************************************************************************************/
        /*                                                      Checkbox                                                            */
        /****************************************************************************************************************************/
        type = (tableIndex>0) ? .list : .todo;

        checkBox = UICheckbox(view:       self,
                              parentCell: self,
                              delegate:   self,
                              type:       type,
                              xCoord:     check_xOffs,
                              yCoord:     check_yOffs);
        
        self.addSubview(checkBox);

        
        /****************************************************************************************************************************/
        /*                                                        Main Text                                                         */
        /****************************************************************************************************************************/
        if(verbose) { print("ANoteTableViewCell.initialize():    grabbing \(tableIndex)"); }
        
        //Calc
        let rChunk_width = wS - tv_xOffs - tv_width;
        let font  = UIFont(name: cell_fontName, size: mt_size)!;
        let hMain = font.pointSize*CGFloat(numLines_main+1);
        let wMain = wS - cellXOffs - rChunk_width - tv_width;

        //Init
        mainField = UILabel(frame: CGRect(x: mt_xOffs, y: mt_yOffs, width:  wMain, height: hMain));
        mainField.font = font;
        mainField.text = currRow.main;
        mainField.textAlignment = NSTextAlignment.left;
        mainField.textColor = cellMainColor;
        
        //text-wrap
        mainField.numberOfLines = 0;                                            /* set to '0' for auto-wrap                         */
        mainField.lineBreakMode = .byWordWrapping;
        
        self.addSubview(mainField);
        
        
        /****************************************************************************************************************************/
        /*                                                  Description Text                                                        */
        /****************************************************************************************************************************/
        let wBody : CGFloat = wS - cellXOffs - rChunk_width;
        
        bodyField = UILabel(frame: CGRect(x: body_xOffs, y: body_yOffs, width: wBody, height: body_height));
        
        bodyField.text = currRow.body;
        
        bodyField.font = UIFont(name: cell_fontName, size: body_size);
        bodyField.textAlignment = NSTextAlignment.left;
        bodyField.textColor = body_color;
        
        self.addSubview(bodyField);
        
        
        /****************************************************************************************************************************/
        /*                                                      Bott Text                                                           */
        /****************************************************************************************************************************/
        let bottFieldWidth : CGFloat = wS - cellXOffs - rChunk_width;
        
        bottField = UILabel(frame: CGRect(x:bott_xOffs, y: bott_yOffs, width: bottFieldWidth, height:  bott_height));
        
        bottField.text = currRow.getDateString();
        
        bottField.font = UIFont(name: cell_fontName, size: bott_size);
        bottField.textAlignment = NSTextAlignment.left;
        bottField.textColor = bott_color;
        
        
        //load bell icon
        bellIcon  = UIImageView();
        bellIcon.frame = CGRect(x: bell_xOffs, y: bell_yOffs, width: bell_width, height: bell_height);
        bellIcon.image = UIImage(named:"bell");
        
        //add it
        self.addSubview(bottField);
        self.addSubview(bellIcon);
        
        
        /****************************************************************************************************************************/
        /*                                                      Time Label                                                          */
        /****************************************************************************************************************************/
        dateView = UIView(frame: CGRect(x:      tv_xOffs,
                                        y:      tv_yOffs,
                                        width:  tv_width,
                                        height: tv_height));
        
        dateView.layer.cornerRadius = tv_corner;
        
        
        //Setup
        dateLabel = UILabel(frame: CGRect(x: tl_xOffs, y: tl_yOffs, width: tl_width, height:  tl_height));
        dateLabel.font  =   UIFont(name: cell_fontName, size: tl_size);
        setTimeLabel(getRowValue().time);
        dateLabel.textColor     = UIColor.white;
        dateLabel.textAlignment = NSTextAlignment.left;
        
        //Add delegate
        let tap = UITapGestureRecognizer(target: self, action: #selector(timeView_tapResponse));
        dateView.addGestureRecognizer(tap);
        
        //Add it to view
        dateView.addSubview(dateLabel);
        addSubview(dateView);
   
        //Mark completion
        isComplete = true;                                                      /* mark completion                                  */
        
        if(verbose) { print("ANoteTableViewCell.initialize():    layout complete"); }

        return;
    }
    
    
    
    
    /********************************************************************************************************************************/
    /* @fcn       launchSubview()                                                                                                   */
    /* @details   launch the subview                                                                                                */
    /********************************************************************************************************************************/
    func launchSubview() {
        
        //@pre      Int
        if(cellSubView == nil) {
            cellSubView = ANoteCellSubview(mainView: self.mainView, parentCell: self);
            cellSubView!.frame = getCSFrame(onscreen: false);
            
            //Add
            mainView.addSubview(self.cellSubView!);
        }
        
        //Slide in View
        UIView.animate(withDuration: launch_dur_s, delay: launch_del_s, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            if(self.verbose) { print("ANoteTableViewCell.launchSubView(): sliding view in"); }
            self.cellSubView!.alpha = 1.0;
            self.cellSubView!.frame = getCSFrame(onscreen: true);
        }, completion: { (finished: Bool) -> Void in
            self.launchCompletion();
            if(self.verbose) { print("ANoteTableViewCell.launchSubView(): sliding view in completion"); }
            self.cellSubView!.frame = getCSFrame(onscreen: true);
            print("-->I am \(self.cellSubView!.frame.height) tall");
        });
        
        mainView.reloadInputViews();
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /* @fcn       launchCompletion()                                                                                                */
    /* @details   call on completion to launch                                                                                      */
    /********************************************************************************************************************************/
    func launchCompletion() {
        
        //fade in components
        UIView.animate(withDuration: 0.125, delay: 0.05, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            self.cellSubView!.setContentsAlpha(1);
            if(self.verbose) { print("ANoteTableViewCell.launchCompl():   fade in begin"); }
        }, completion: { (finished: Bool) -> Void in
            if(self.verbose) { print("ANoteTableViewCell.launchCompl():   fade in complete"); }
        });
        
    }
    

//**********************************************************************************************************************************//
//                                                        UI RESPONSE                                                               //
//**********************************************************************************************************************************//
    
    /********************************************************************************************************************************/
    /** @fcn        timeView_tapResponse()
     *  @details    respond to selection of the time view
     *
     *  @section     Opens
     *      make functional & validate
     *      generate slideup for custDate Selection
     *      generate response actions
     *      complete and store
     */
    /********************************************************************************************************************************/
    @objc func timeView_tapResponse() {

        //Launch time selection
        raiseTimePicker();

        if(verbose) { print("ANoteTableViewCell.tvResp():        tap response selected"); }
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        checkBoxResp(_ checked : Bool)
     *  @brief      respond to selection of the check box in cell
     *  @details    x
     *
     *  @param      [in] (Bool) checked - box was checked off
     */
    /********************************************************************************************************************************/
    func checkBoxResp(_ checked : Bool) {
        if(verbose) { print("ANoteTableViewCell.checkResp():     selection response complete for '\(checked)'"); }
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        raiseTimePicker()
     *  @brief      raise a picker to select a time value
     *  @details    x
     */
    /********************************************************************************************************************************/
    func raiseTimePicker() {
        
        //Grab
        let date = getRowValue().time;
        
        //Generate aNote TimePicker View to Slide Up
        let x : ANoteTimeSelect = ANoteTimeSelect(vc, self, date);
        
        //Give correct print()
        if(viewOpen) {
            x.show(vc);
            if(verbose) { print("ANoteTableViewCell.raiseTimePkr():  time selection picker was shown"); }
        } else {
            if(verbose) { print("ANoteTableViewCell.raiseTimePkr():  view not open, aborting load"); }
        }
        return;
    }
    
    
    
    
    
    
    /********************************************************************************************************************************/
    /** @fcn        updateSelection(selected : Bool)
     *  @brief      update selected state of cell
     *  @details    cross out main text and greyed when selected
     *
     *  @param      [in] (Bool) selected - if the cell is selected (check box checked off)
     */
    /********************************************************************************************************************************/
    func updateSelection(selected : Bool) {
        
        if(selected) {
            if(verbose) { print("ANoteTableViewCell.updateSel():     selected"); }
            
            //Main text field
            var attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: mainField.text!);
            
            attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle,
                                         value: NSUnderlineStyle.styleSingle.rawValue,
                                         range: NSMakeRange(0, mainField.text!.count));
            
            mainField.attributedText = attributeString;
            mainField.textColor = UIColor.gray;
            
            
            //Date field
            attributeString =  NSMutableAttributedString(string: bottField.text!);
            
            attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle,
                                         value: NSUnderlineStyle.styleSingle.rawValue,
                                         range: NSMakeRange(0, bottField.text!.count));
            
            bottField.attributedText = attributeString;
            bottField.textColor = UIColor.gray;
            
            
        } else {
            if(verbose) { print("ANoteTableViewCell.updateSel():     not selected"); }
            
            //Main text field
            var attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: mainField.text!);
            
            attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle,
                                         value: 0,
                                         range: NSMakeRange(0, attributeString.length));
            
            
            mainField.attributedText = attributeString;
            mainField.textColor = UIColor.black;
            
            
            //Date field
            attributeString =  NSMutableAttributedString(string: bottField.text!);
            
            attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle,
                                         value: 0,
                                         range: NSMakeRange(0, attributeString.length));
            
            bottField.attributedText = attributeString;
            bottField.textColor = UIColor.black;
        }
        
        return;
    }
    
    
//**********************************************************************************************************************************//
//                                                          HELPERS                                                                 //
//**********************************************************************************************************************************//
  
    /********************************************************************************************************************************/
    /** @fcn        getRowValue() -> ANoteRow
     *  @brief      get current cell's row contents
     *  @details    x
     *
     *  @return     (ANoteRow) current cell's row contents
     */
    /********************************************************************************************************************************/
    func getRowValue() -> ANoteRow {
        return vc.rows[tableIndex];
    }


    /********************************************************************************************************************************/
    /** @fcn        setRowValue(row: ANoteRow)
     *  @brief      set current cell's row contents
     *  @details    x
     *
     *  @return     (ANoteRow) current cell's row contents
     */
    /********************************************************************************************************************************/
    func setRowValue(row: ANoteRow) {
        vc.rows[tableIndex] = row;
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        getIndex() -> Int
     *  @brief      get table index
     *  @details    x
     *
     *  @return     (Int) index of active cell (e.g. '1' for Item #2)
     */
    /********************************************************************************************************************************/
    func getIndex() -> Int {
        return (tableIndex);
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        getCellNumber() -> Int
     *  @brief      get cell number
     *  @details    number is (index+1) for display
     *
     *  @return     (Int) number of active cell (e.g. '2' for Item #2)
     */
    /********************************************************************************************************************************/
    func getCellNumber() -> Int {
        return (tableIndex+1);
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        setDateLabel(_ date: Date?)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func setDateLabel(_ date: Date?) {
        
        //Handle unset cell
        if(date == nil) {
            bottField.text = "";                                        /* string is empty when date unset                          */
            bellIcon.image = nil;                                       /* turn off bell icon                                       */
            return;
        }
        
        //Update bell icon (in case empty reload)
        bellIcon.image = UIImage(named:"bell");
        
        //Update date string
        bottField.text = getRowValue().getDateString();
        
        return;
    }


    /********************************************************************************************************************************/
    /** @fcn        setTimeLabel(_ date : Date?)
     *  @brief      set cell's time label contents to match date
     *  @details    x
     */
    /********************************************************************************************************************************/
    func setTimeLabel(_ date : Date?) {
        
        //Vars
        let isSet : Bool;                                               /* don't operate on timeView when date not set              */
        let isWithinHour : Bool;
        
        //Init
        isSet = (date != nil);
        
        //@pre
        if(!isSet) {
            dateLabel.text = "";
            dateView.backgroundColor = nil;                             /* hidden                                                   */
            return;
        } else {
            isWithinHour = (date!.timeIntervalSince(DateUtils.getToday()) < (60*60));
        }
        
        //Get time components
        var hr  = Calendar.current.component(.hour, from: date!);
        let min = Calendar.current.component(.minute, from: date!);
        var mer = "AM";
        
        //Handle meridian
        if(hr>11) { mer = "PM"; }
        if(hr>12) { hr = (hr-12); }
        
        //Gen strings
        let hrStr  = "\(hr)";                                           /* num chars std                                            */
        let minStr = String(format: "%02d", min);                       /* num chars 2                                              */
        
        //Apply text
        dateLabel.text  =   "\(hrStr):\(minStr) \(mer)";
        
        //Apply color
        if(isWithinHour) {
            dateView.backgroundColor = stdTimeColor;
        } else {
            dateView.backgroundColor = normTimeColor;
        }
        
        if(verbose) { print("ANoteTableViewCell.setTimeLabel():  time label value changed"); }
        
        return;
    }


    /********************************************************************************************************************************/
    /** @fcn        updateDate(_ date : Date?)
     *  @brief      update stored date value & cell displayed time
     *  @details    x
     */
    /********************************************************************************************************************************/
    func updateDate(_ date : Date?) {
        
        //Store value
        vc.rows[tableIndex].time = date;
        
        //Update UI
        setDateLabel(date);
        setTimeLabel(date);
        
        //Grab date
        var respStr = "nil";
        if(date != nil) {
            respStr = "\(DateUtils.getDateString(date!))";              /* only print if passed                                     */
        }
        
        if(verbose) { print("ANoteTableViewCell.updateDate():    date was updated to '\(respStr)'"); }
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        setName(_ name: String)
     *  @brief      set name uniformally for debug
     *  @details    x
     */
    /********************************************************************************************************************************/
    func setName(_ name: String) {

        //Data store
        vc.rows[tableIndex].main = name;
        
        //UI update
        mainField.text = name;
        
        return;
    }


    /********************************************************************************************************************************/
    /** @fcn        setBody(_ body: String)
     *  @brief      set body uniformally for debug
     *  @details    x
     */
    /********************************************************************************************************************************/
    func setBody(_ body: String) {

        //Data store
        vc.rows[tableIndex].body = body;

        //UI update
        bodyField.text = body;

        return;
    }


    /********************************************************************************************************************************/
    /** @fcn        getName() -> String?
     *  @brief      get name value
     *  @details    x
     */
    /********************************************************************************************************************************/
    func getName() -> String? {
        return vc.rows[tableIndex].main;
    }
    
    
    
//**********************************************************************************************************************************//
//                                                          UNKNOWN                                                                 //
//**********************************************************************************************************************************//
    
    /********************************************************************************************************************************/
	/**	@fcn		init?(coder aDecoder: NSCoder)
	 *  @brief		x
	 *  @details	x
	 */
	/********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

