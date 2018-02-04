/************************************************************************************************************************************/
/** @file       ANoteTableViewCell.swift
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


class ANoteTableViewCell : UICustomTableViewCell, UICheckBoxDelegate {
    
    //Parent
    var vc : ViewController!;
    
    //State
    var tableIndex   : Int!;
    let numLines     : Int = 2;
    
    //Cell Values
    var date         : Date?;                                   /* date selection for cell (no date if nil)                         */
    

    //Main UI
    var checkBox     : UICheckbox!;
    var subjectField : UILabel!;
    var descripField : UILabel!;
    var bottField    : UILabel!;
    
    //Misc UI
    var timeView  : UIView!;
    var timeLabel : UILabel!;
    var type      : CellType!;
    var bellIcon  : UIImageView!;

    //Locals
    var mainView    : UIView!;
    var cellSubView : ANoteCellSubview!;
    
    //Config
    let cell_fontName : String = cellFont;
    let myVerbose     : Bool = true;                        /* unknown class collisions mitigation                                  */


    /********************************************************************************************************************************/
    /** @fcn        init(style: UITableViewCellStyle, reuseIdentifier: String?)
     *  @brief      x
     *  @details    x
     *
     *  @param      [in] (ViewController) vc - x
     *  @param      [in] (UIView) mainView - x
     *  @param      [in] (UITableViewCellStyle) style - x
     *  @param      [in] (String?) reuseIdentifier - x
     *
     *  @section    Opens
     *      make row border thinner & set to lighter color
     */
    /********************************************************************************************************************************/
    init(vc : ViewController, mainView : UIView, style: UITableViewCellStyle, reuseIdentifier: String?) {

        //Store Vars
        self.mainView = mainView;
        self.vc = vc;
        
        //Init Vars
        date = nil;                                                 /* init to nil                                                  */
        
        //Super
        super.init(style:style, reuseIdentifier:reuseIdentifier);
    
        if(myVerbose){ print("aNoteTableViewCell.init():          cell was initialized"); }
    
        return;
    }
    
    
    /********************************************************************************************************************************/
    /* @fcn       initialize(indexPath : NSIndexPath, aNoteTable : aNoteTableView)                                                  */
    /* @details   initialize the cell, after creation                                                                               */
    /* @assum     already initialized when timeView not nil                                                                         */
    /********************************************************************************************************************************/
    func initialize(_ indexPath : IndexPath, aNoteTable : ANoteTableView) {

        //@pre  check if already initialized
        if(timeView != nil) {
            return;                                                 /* don't re-initialize, called by Handler on scroll             */
        }

        self.tableIndex = indexPath.item;
        
        self.cellSubView = ANoteCellSubview(mainView: self.mainView, parentCell: self);
        
        self.mainView.addSubview(self.cellSubView);

        //Get Current Cell's Info
        let currRow = getRowValue();
        
        if(myVerbose){print("aNoteTableViewCell.initialize():    adding: '\(currRow.main!)'");}

        /****************************************************************************************************************************/
        /*                                                      Checkbox                                                            */
        /****************************************************************************************************************************/
        type = (indexPath.row>0) ? .list : .todo;
        
        checkBox = UICheckbox(view:       self,
                              parentCell: self,
                              delegate:   self,
                              type:       type,
                              xCoord:     check_xOffs,
                              yCoord:     check_yOffs);
  
        self.addSubview(checkBox);

        
        /****************************************************************************************************************************/
        /*                                                  Main(Subject) Text                                                      */
        /****************************************************************************************************************************/
        let rChunk_width = UIScreen.main.bounds.width - tv_xOffs - tv_width;
        
        let subjFieldWidth : CGFloat = UIScreen.main.bounds.width - cellXOffs - rChunk_width - tv_width;
        
        if(myVerbose) { print("ANoteTableViewCell.initialize():    grabbing \(indexPath.item)"); }
        
        let font : UIFont = UIFont(name: cell_fontName, size: mt_size)!;
        
        subjectField = UILabel(frame:  CGRect(x:      mt_xOffs,
                                              y:      mt_yOffs,
                                              width:  subjFieldWidth,
                                              height: font.pointSize*CGFloat(self.numLines+1)));
        subjectField.font = font;
        subjectField.text = currRow.main;
        subjectField.textAlignment = NSTextAlignment.left;
        subjectField.textColor = UIColor(red:0.31, green:0.31, blue:0.31, alpha:1.0);               /* #4e4e4e                      */
        
        //text-wrap
        subjectField.numberOfLines = 0;                                         /* set to 0 for auto-wrap                           */
        subjectField.lineBreakMode = .byWordWrapping;
        
        self.addSubview(subjectField);
        
        
        /****************************************************************************************************************************/
        /*                                                  Description Text                                                        */
        /****************************************************************************************************************************/
        let descrFieldWidth : CGFloat = UIScreen.main.bounds.width - cellXOffs - rChunk_width;
        
        descripField = UILabel(frame: CGRect(x: descr_xOffs,
                                             y: descr_yOffs,
                                             width: descrFieldWidth,
                                             height: descr_height));
        
        descripField.text = currRow.body;

        descripField.font = UIFont(name: cell_fontName, size: descr_size);
        descripField.textAlignment = NSTextAlignment.left;
        descripField.textColor = descr_color;
        
        self.addSubview(descripField);
        
        
        /****************************************************************************************************************************/
        /*                                                      Bott Text                                                           */
        /****************************************************************************************************************************/
        let bottFieldWidth : CGFloat = UIScreen.main.bounds.width - cellXOffs - rChunk_width;
        
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
        timeView = UIView(frame: CGRect(x:      tv_xOffs,
                                        y:      tv_yOffs,
                                        width:  tv_width,
                                        height: tv_height));
        
        timeView.layer.cornerRadius = tv_corner;
        
        
        //Setup
        timeLabel = UILabel(frame: CGRect(x: tl_xOffs, y: tl_yOffs, width: tl_width, height:  tl_height));
        timeLabel.font  =   UIFont(name: cell_fontName, size: tl_size);
        setTimeLabel(getRowValue().time);
        timeLabel.textColor     = UIColor.white;
        timeLabel.textAlignment = NSTextAlignment.left;

        //Add delegate
        let tap = UITapGestureRecognizer(target: self, action: #selector(timeView_tapResponse));
        timeView.addGestureRecognizer(tap);
        
        //Add it to view
        timeView.addSubview(timeLabel);
        addSubview(timeView);
        
        return;
    }

    
    //@todo     header
    //@todo     implement uniformly, cleanly
    func getTitle() -> String {
        print("I am Bob");
        return getRowValue().main!;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        setDateLabel(_ date : Date?)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func setDateLabel(_ date : Date?) {
        
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
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func setTimeLabel(_ date : Date?) {

        let isSet : Bool;                                               /* don't operate on timeView when date not set              */
        let isWithinHour : Bool;
        
        //Init
        isSet = (date != nil);

        //@pre
        if(!isSet) {
            timeLabel.text = "";
            timeView.backgroundColor = nil;                             /* hidden                                                   */
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
        timeLabel.text  =   "\(hrStr):\(minStr) \(mer)";

        //Apply color
        if(isWithinHour) {
            timeView.backgroundColor = stdTimeColor;
        } else {
            timeView.backgroundColor = normTimeColor;
        }

        if(myVerbose) { print("ANoteTableViewCell.setTimeLabel():  time label value changed"); }

        return;
    }
    
    
    /********************************************************************************************************************************/
    /* @fcn       timeView_tapResponse()                                                                                            */
    /* @details   respond to selection of the time view                                                                             */
    /*                                                                                                                              */
    /* @section     Opens                                                                                                           */
    /*      generate slideup for custDate Selection                                                                                 */
    /*      generate response actions                                                                                               */
    /*      complete and store                                                                                                      */
    /*                                                                                                                              */
    /********************************************************************************************************************************/
    @objc func timeView_tapResponse() {
        
        if(myVerbose) { print("ANoteTableViewCell.tvResp():        tap response selected"); }

        raiseTimePicker();
        
        //@todo
        
        //@goal present ANotePickerView, allowing for selection (upper bar of 'cancel', 'done' & 'date'
        
        return;
    }

    
    /********************************************************************************************************************************/
    /* @fcn       launchSubView()                                                                                                   */
    /* @details   launch the subview                                                                                                */
    /********************************************************************************************************************************/
    func launchSubView() {

        cellSubView.frame = getCSFrame(onscreen: false);
        
        //Slide in View
        UIView.animate(withDuration: launch_dur_s, delay: launch_del_s, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            if(self.myVerbose) { print("ANoteTableViewCell.launchSubView(): sliding view in"); }
                self.cellSubView.alpha = 1.0;
                self.cellSubView.frame = getCSFrame(onscreen: true);
        }, completion: { (finished: Bool) -> Void in
                self.launchCompletion();
            if(self.myVerbose) { print("ANoteTableViewCell.launchSubView(): sliding view in completion"); }
            self.cellSubView.frame = getCSFrame(onscreen: true);
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
            self.cellSubView.setContentsAlpha(1);
            if(self.myVerbose) { print("ANoteTableViewCell.launchCompl():   fade in begin"); }
        }, completion: { (finished: Bool) -> Void in
            if(self.myVerbose) { print("ANoteTableViewCell.launchCompl():   fade in complete"); }
        });
        
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
    /** @fcn        getNumber() -> Int
     *  @brief      get cell number
     *  @details    x
     *
     *  @return     (Int) number of active cell (e.g. '2' for Item #2)
     */
    /********************************************************************************************************************************/
    func getNumber() -> Int {
        return (tableIndex+1);
    }

    
    /********************************************************************************************************************************/
    /** @fcn        getRowValue() -> ANoteRow
     *  @brief      get cell contents
     *  @details    x
     *
     *  @return     (ANoteRow) row contents for cell
     */
    /********************************************************************************************************************************/
    func getRowValue() -> ANoteRow {
        return vc.rows[tableIndex];
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        storeRowValue(_ row : ANoteRow)
     *  @brief      set cell contents
     *  @details    x
     *
     *  @return     (ANoteRow) row contents for cell
     */
    /********************************************************************************************************************************/
    func storeRowValue(_ row : ANoteRow) {
        return vc.rows[tableIndex] = row;
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
            if(myVerbose) { print("ANoteTableViewCell.updateSel():     selected"); }

            //Subject field
            var attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.subjectField.text!);
            
            attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle,
                                         value: NSUnderlineStyle.styleSingle.rawValue,
                                         range: NSMakeRange(0, self.subjectField.text!.count));

            self.subjectField.attributedText = attributeString;
            self.subjectField.textColor = UIColor.gray;

            
            //Date field
            attributeString =  NSMutableAttributedString(string: self.bottField.text!);
            
            attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle,
                                         value: NSUnderlineStyle.styleSingle.rawValue,
                                         range: NSMakeRange(0, self.bottField.text!.count));

            self.bottField.attributedText = attributeString;
            self.bottField.textColor = UIColor.gray;
            
            
        } else {
            if(myVerbose) { print("ANoteTableViewCell.updateSel():     not selected"); }

            //Subject field
            var attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self.subjectField.text!);
            
            attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle,
                                         value: 0,
                                         range: NSMakeRange(0, attributeString.length));


            self.subjectField.attributedText = attributeString;
            self.subjectField.textColor = UIColor.black;

            
            //Subject field
            attributeString =  NSMutableAttributedString(string: self.bottField.text!);
            
            attributeString.addAttribute(NSAttributedStringKey.strikethroughStyle,
                                         value: 0,
                                         range: NSMakeRange(0, attributeString.length));

            //Date field
            self.bottField.attributedText = attributeString;
            self.bottField.textColor = UIColor.black;
        }
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        required init?(coder aDecoder: NSCoder)
     *  @brief      x
     *  @details    x
     *
     *  @param      [in] (NSCoder) coder aDecoder - x
     *
     */
    /********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder);
        fatalError("init(coder:) has not been implemented");
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        func numberOfLinesInLabel(_ yourString: NSString, labelWidth: CGFloat, labelHeight: CGFloat, font: UIFont) -> Int
     *  @brief      x
     *  @details    x
     *
     *  @param      [in] (NSString) yourString - x
     *  @param      [in] (CGFloat) labelWidth - x
     *  @param      [in] (CGFloat) labelHeight - x
     *  @param      [in] (UIFont) font - x
     *
     *  @return     (Int) descrip
     *
     */
    /********************************************************************************************************************************/
    func numberOfLinesInLabel(_ yourString: NSString, labelWidth: CGFloat, labelHeight: CGFloat, font: UIFont) -> Int {
        
        let paragraphStyle = NSMutableParagraphStyle()
    
        paragraphStyle.minimumLineHeight = labelHeight;
        paragraphStyle.maximumLineHeight = labelHeight;
        paragraphStyle.lineBreakMode = .byWordWrapping;
        
        let size        :  CGSize  = CGSize(width: 1, height: 2);
        let stringWidth :  CGFloat = size.width;

        let constrain   :  CGSize  = CGSize(width: labelWidth, height: labelHeight);
        
        let numberOfLines = ceil(Double(stringWidth/constrain.width))
        
        return Int(numberOfLines);
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
        if(myVerbose) { print("ANoteTableViewCell.checkResp():     selection response complete for '\(checked)'"); }
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        raiseTimePicker()
     *  @brief      raise a picker to select a time value
     *  @details    x
     */
    /********************************************************************************************************************************/
    func raiseTimePicker() {

        //Generate aNote TimePicker View to Slide Up
        let x : ANoteTimeSelect = ANoteTimeSelect(vc, self, date);

        //Give correct print()
        if(viewOpen) {
            x.show(vc);
            if(myVerbose) { print("ANoteTableViewCell.raiseTimePkr():  time selection picker was shown"); }
        } else {
            if(myVerbose) { print("ANoteTableViewCell.raiseTimePkr():  view not open, aborting load"); }
        }
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
        self.date = date;                                               /* if nil date is empty                                     */
        vc.rows[tableIndex].time = date;                                /* works? eww this is long                                  */
        
        //Update UI
        setDateLabel(date);
        setTimeLabel(date);
        
        //Grab date
        var respStr = "nil";
        if(date != nil) {
            respStr = "\(DateUtils.getDateString(date!))";		        /* only print if passed									    */
        }

        if(myVerbose) { print("ANoteTableViewCell.updateDate():    date was updated to '\(respStr)'"); }
        
        return;
    }

//**********************************************************************************************************************************//
//                                                         CELL INFO UPDATE                                                         //
//**********************************************************************************************************************************//
    
    //@todo     header
    func updateTitle(_ title : String) {
        
        var x : ANoteRow = getRowValue();
        
        x.main = title;
        
        storeRowValue(x);
        
        print("todo: \(title)");
    }
}

