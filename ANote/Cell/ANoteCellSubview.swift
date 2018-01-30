/************************************************************************************************************************************/
/** @file		ANoteCellSubview.swift
 * 	@brief		x
 * 	@details	x
 *
 * 	@section	Opens
 * 		add top bar             (UIView)
 *      add title bar           (UIView)
 *      add date placeholder    (UIView)
 *      add main text           (UITextView)
 *      add bottom menubar      (UIView)
 *      ...
 *      main view here is scrollable
 *      mainText & titleText feature 'return' keyboard (after menu bar added for keyboard dismissal)
 *
 *  @section    Data Architecture
 *      each row represents a data entry whose data is captured in completion by the row's cell subview, presented here. all data
 *      fields are thus represented as fields of the cell subview (e.g. nameLabel, etc.)
 *
 * 	@section	Legal Disclaimer
 * 			All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 * 			Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class ANoteCellSubview : UIView, UITextFieldDelegate, UITextViewDelegate {
    
    //New
    var backButtonView : UIView!;
    var infoButtonView : UIView!;
    var clipButtonView : UIView!;
    var sendButtonView : UIView!;
    var plusButtonView : UIView!;
    
    //Ref
    var mainView     : UIView!;                                     /* main view of app                                             */
    var parentCell   : ANoteTableViewCell!;
    
    //UI
    var topBar     : UIView;
    var titleBar   : UIView;
    var titleField : UITextField;
    var dateBar    : UIView;
    var datePlace  : UIView;
    var mainText   : UITextView;
    var menuBar    : UIView;
    
    //Dev UI
    var retButton  : UIButton!;                                     /* return button of the subview                                 */
    var addButton  : UIButton!;                                     /* add time button                                              */
    var togButton  : UIButton!;                                     /* add toggle button                                            */
    
    //Config
    private let verbose : Bool = true;                              /* for this class                                               */
    
    private static var bkgnd_ctr : Int =  0;                        /* background index to use for specified call                   */
    var bkgnd_ind : Int;                                            /* index of background for cell                                 */
    let bkgndView : UIImageView;                                    /* view holding background image                                */
 
    var temp_i : Int = 0;
    var rslts = [String]();
    

    /********************************************************************************************************************************/
	/**	@fcn		init(mainView : UIView, parentCell : ANoteTableViewCell)
	 *  @brief		x
     *
     *  @param      [in] (UIView) mainView - main view of app
     *  @param      [in] (ANoteTableViewCell) - parent cell for subview
     *
     *  @post       all UI contents hidden
     */
	/********************************************************************************************************************************/
    init(mainView : UIView, parentCell : ANoteTableViewCell) {
        
        //Prep Background
        bkgndView = UIImageView();
        bkgnd_ind = ANoteCellSubview.bkgnd_ctr;                                 /* grab index for use                               */
        
        //Init UI
        topBar = UIView();
        titleBar = UIView();
        titleField = UITextField();
        dateBar = UIView();
        datePlace = UIView();
        mainText = UITextView();
        menuBar = UIView();
        
        //Dev UI
        retButton = UIButton(type: UIButtonType.roundedRect);
        addButton = UIButton(type: UIButtonType.roundedRect);
        togButton = UIButton(type: UIButtonType.roundedRect);

        super.init(frame: UIScreen.main.bounds);
        
        //Store
        self.mainView = mainView;
        self.parentCell = parentCell;

        //Init view
        backgroundColor = UIColor.white;
        frame = getCSFrame(onscreen: false);
        
        
        //**************************************************************************************************************************//
        //                                                        BACKGROUND                                                        //
        //**************************************************************************************************************************//
        let images : [String] = getCellBackgrounds();                       /* get all backgrounds                                  */
        bkgndView.frame = UIScreen.main.bounds;                             /* fullscreen                                           */
        bkgndView.contentMode = .scaleToFill;                               /* set unscaled                                         */
        bkgndView.image = UIImage(named: images[bkgnd_ind]);                /* acquire next background                              */

        //update ctr
        ANoteCellSubview.bkgnd_ctr = (ANoteCellSubview.bkgnd_ctr + 1);      /* update for next after use                            */

        //Track view offset
        var y : CGFloat = UIApplication.shared.statusBarFrame.height;       /* height to begin view placement                       */
        
        
        //**************************************************************************************************************************//
        //                                                         TOP BAR                                                          //
        //**************************************************************************************************************************//
        topBar.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: 37);
        topBar.backgroundColor = UIColor.lightGray;
        y = (y + topBar.bounds.height);
        
        //@todo  Draw Folder
        
        //@todo  Text
        
        //@todo  Draw Folder
        
        //Bookmark Icon
        
        //**************************************************************************************************************************//
        //                                                        TITLE BAR                                                         //
        //**************************************************************************************************************************//
        titleBar.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: 40);
        y = (y + titleBar.bounds.height);

        //Gen text field
        titleField.frame = CGRect(x: 13, y: -1, width: titleBar.frame.width-13, height: titleBar.frame.height);
        titleField.placeholder = "Untitled";
        titleField.font = UIFont(name: "HelveticaNeue-Medium", size: 46);
        titleField.font = FontUtils.updateFontSize(titleField.font!, 26);
        titleField.clearButtonMode = .always;
        titleField.clearsOnBeginEditing = true;
        titleField.textColor = UIColor.darkGray;
        titleField.returnKeyType = UIReturnKeyType.done;
        titleField.delegate = self;
        
        //Add to bar
        titleBar.addSubview(titleField);
        
        
        //**************************************************************************************************************************//
        //                                                         DATE BAR                                                         //
        //**************************************************************************************************************************//
        dateBar.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: 33);
        dateBar.backgroundColor = UIColor.darkGray;
        y = (y + dateBar.bounds.height);

        
        //**************************************************************************************************************************//
        //                                                        DATE VIEW                                                         //
        // @todo    only inserted when date is present                                                                              //
        //**************************************************************************************************************************//
        datePlace.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: 81);
        datePlace.backgroundColor = UIColor.blue;
        y = (y + datePlace.bounds.height);
        
        
        //**************************************************************************************************************************//
        //                                                        MAIN TEXT                                                         //
        //**************************************************************************************************************************//
        mainText.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: 312);
        mainText.returnKeyType = UIReturnKeyType.done;
        mainText.backgroundColor = nil;
        mainText.delegate = self;
        mainText.text = "";
        y = (y + mainText.bounds.height);
        
        
        //**************************************************************************************************************************//
        //                                                        MENU BAR                                                          //
        //**************************************************************************************************************************//
        menuBar.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - y));
        menuBar.backgroundColor = UIColor.purple;


        //**************************************************************************************************************************//
        //                                                         BUTTONS                                                          //
        //**************************************************************************************************************************//
        //Return Button
        retButton.translatesAutoresizingMaskIntoConstraints = true;
        retButton.setTitle("Return",      for: UIControlState());
        retButton.sizeToFit();
        retButton.center = CGPoint(x: frame.width/2-75, y: 500);
        retButton.addTarget(self, action: #selector(returnPress(_:)), for:  .touchUpInside);

        //Add Button
        addButton.translatesAutoresizingMaskIntoConstraints = true;
        addButton.setTitle("Set Time",      for: UIControlState());
        addButton.sizeToFit();
        addButton.center = CGPoint(x: frame.width/2, y: 500);
        addButton.addTarget(self, action: #selector(setPress(_:)), for:  .touchUpInside);

        //Toggle Button
        togButton.translatesAutoresizingMaskIntoConstraints = true;
        togButton.setTitle("Toggle",      for: UIControlState());
        togButton.sizeToFit();
        togButton.center = CGPoint(x: frame.width/2+75, y: 500);
        togButton.addTarget(self, action: #selector(togPress(_:)), for:  .touchUpInside);

        
        
        //Init all hidden
        setContentsAlpha(0);
        
        //Load UI
        mainView.reloadInputViews();
        addSubview(bkgndView);
//        addSubview(topBar);
//        addSubview(titleBar);
//        addSubview(dateBar);
//        addSubview(datePlace);
//        addSubview(mainText);
//        addSubview(menuBar);
        addDevToolbar(parentCell.vc.view);
        
        addSubview(retButton);
        addSubview(addButton);
        addSubview(togButton);
        
        if(verbose) { print("CellSubview.init():                 my cell #\(parentCell.getNumber()) subview init"); }
 
        return;
    }
//</PREV>
    /********************************************************************************************************************************/
    /** @fcn        getCellBackgrounds() -> [String]
     *  @brief      get listing of all available images for background use
     *
     *  @return     ([String]?) all local images found on phone
     *
     *  @section    Supported Types
     *      png, jpg, jpeg
     */
    /********************************************************************************************************************************/
    func getCellBackgrounds() -> [String] {
        
        var rslts = [String]();
        
        let url    = Bundle.main.bundleURL;
        let opts = FileManager.DirectoryEnumerationOptions();
        let fileEnumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: nil, options: opts);
        
        while let file = fileEnumerator?.nextObject() {
            let s : String = "IMG_0720.PNG";                            /* <TEMP>(file as! NSURL).lastPathComponent!;               */
            
            var type = (file as! NSURL).pathExtension;
            type = type?.lowercased();                                  /* handle both cases                                        */
            
            //Filter Images
            var valid : Bool = ((type?.contains("png"))! || (type?.contains("jpg"))! || (type?.contains("jpeg"))!);
            
            //Filter Icons
            valid = (valid && !s.contains("AppIcon"));
            
            //Append
            if(valid) {
                rslts.append(s);
            }
        }
        
        return rslts;
    }

    
    /********************************************************************************************************************************/
	/**	@fcn		returnPress(_ sender: UIButton!)
	 *  @brief		return was pressed, return to main
     *
     *  @param      [in] (UIButton!) sender - button pressed
     *  @note      @objc exposed to enabled handleTap() access, not sure why
     */
	/********************************************************************************************************************************/
    @objc func returnPress(_ sender: UIButton!) {
        
        if(verbose) { print("CellSubview.returnPress():  return was pressed, dismissing view"); }
        
        //Move Frame offscreen
        self.frame = getCSFrame(onscreen: false);

        //Dismiss
        self.dismissSubView();
        
        return;
    }
    
    
    
    /********************************************************************************************************************************/
    /** @fcn        setPress(_ sender: UIButton!)
     *  @brief      x
     *
     *  @param      [in] (UIButton!) sender - button pressed
     *  @note       @objc exposed to enabled handleTap() access, not sure why
     */
    /********************************************************************************************************************************/
    @objc func setPress(_ sender: UIButton!) {
        
        if(verbose) { print("CellSubview.setPress():             add was pressed"); }

        //Init view
        let p = ANoteTimeSelect(parentCell.vc, parentCell, date: parentCell.date);
        
        //Grab new time
        p.show(parentCell.vc);
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        togPress(_ sender: UIButton!)
     *  @brief      x
     *
     *  @param      [in] (UIButton!) sender - button pressed
     *  @note       @objc exposed to enabled handleTap() access, not sure why
     */
    /********************************************************************************************************************************/
    @objc func togPress(_ sender: UIButton!) {

        backButtonView.isHidden = !backButtonView.isHidden;
        infoButtonView.isHidden = !infoButtonView.isHidden;
        clipButtonView.isHidden = !clipButtonView.isHidden;
        sendButtonView.isHidden = !sendButtonView.isHidden;
        plusButtonView.isHidden = !plusButtonView.isHidden;
        
        if(verbose) { print("CellSubview.togPress():             add was pressed"); }
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /* @fcn       setContentsAlpha(_ alpha : CGFloat)                                                                               */
    /* @details   set alpha of all UI contents                                                                                      */
    /********************************************************************************************************************************/
    func setContentsAlpha(_ alpha : CGFloat) {
        
        //Apply alpha to all
        retButton.alpha  = alpha;
        topBar.alpha     = alpha;
        titleBar.alpha   = alpha;
        datePlace.alpha  = alpha;
        dateBar.alpha    = alpha;
        mainText.alpha   = alpha;
        menuBar.alpha    = alpha;
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /* @fcn       dismissSubView()                                                                                                  */
    /* @details   dismiss the subview                                                                                               */
    /********************************************************************************************************************************/
    func dismissSubView() {
        
        frame = getCSFrame(onscreen: true);
        
        //Slide in View
        UIView.animate(withDuration: launch_dur_s, delay: launch_del_s, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            if(self.verbose) { print("CellSubview.dismissSubView():       sliding view out"); }
            self.alpha = 1.0;
            self.frame = getCSFrame(onscreen: false);
        }, completion: { (finished: Bool) -> Void in
            if(self.verbose) { print("CellSubview.dismissSubView():       sliding view out completion"); }
            self.setContentsAlpha(0);
            self.frame = getCSFrame(onscreen: false);
        });
        
        self.mainView.reloadInputViews();
        
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        addDevToolbar(_ view : UIView)
     *  @brief      add toolbar manually for dev
     *
     *  @param      [in] (UIView) view - view to add to
     *
     *  @section    Opens
     *      Offset from bottom of screen (top is curr offset)
     *      Add tap responses to each button
     */
    /********************************************************************************************************************************/
    func addDevToolbar(_ view : UIView) {
        
        var x0 : CGFloat;
        var y0 : CGFloat;
        var h : CGFloat;
        var w : CGFloat;
        var lineWidth : CGFloat
        var P0 : CGPoint;
        var P1 : CGPoint;
        var P2 : CGPoint;
        var shapeLayer : CAShapeLayer;
        
        var backButtonPath  : UIBezierPath!;
        var infoButtonPath : UIBezierPath!;
        var clipButtonPath : UIBezierPath!;
        var sendButtonPath : UIBezierPath!;
        var plusButtonPath : UIBezierPath!;

        
        //**************************************************************************************************************************//
        //                                             1 - RETURN ARROW                                                             //
        //**************************************************************************************************************************//
        x0 = 29;
        y0 = 14;
        h = 8;
        w = 9;
        lineWidth = 2;
        
        P0 = CGPoint(x: x0,   y: y0);
        P1 = CGPoint(x: x0-w, y: y0+h);
        P2 = CGPoint(x: x0,   y: y0+2*h);
        
        //Init
        backButtonView = UIView(frame: CGRect(x: 0, y: 520, width: UIScreen.main.bounds.width, height: 45));
        backButtonPath = UIBezierPath();
        backButtonPath.move(to: P0);
        backButtonPath.addLine(to: P1);
        backButtonPath.addLine(to: P2);

        //Init
        shapeLayer = CAShapeLayer();
        
        //Rounded edges?
        shapeLayer.lineJoin = "round";
        shapeLayer.lineCap  = "round";
        
        //Draw
        shapeLayer.path = backButtonPath.cgPath;
        shapeLayer.strokeColor = UIColor.blue.cgColor;
        shapeLayer.fillColor = nil;
        shapeLayer.lineWidth = lineWidth;
        
        //Add to view
        backButtonView.layer.addSublayer(shapeLayer);
        self.addSubview(backButtonView);

        
        //**************************************************************************************************************************//
        //                                             2 - INFO BUTTON                                                              //
        //**************************************************************************************************************************//
        x0 = 95;
        y0 = 14;
        h = 8;
        w = 9;
        lineWidth = 2;
        
        P0 = CGPoint(x: x0,   y: y0);
        P1 = CGPoint(x: x0-w, y: y0+h);
        P2 = CGPoint(x: x0,   y: y0+2*h);
        
        //Init
        infoButtonView = UIView(frame: CGRect(x: 0, y: 520, width: UIScreen.main.bounds.width, height: 45));
        infoButtonPath = UIBezierPath();
        infoButtonPath.move(to: P0);
        infoButtonPath.addLine(to: P1);
        infoButtonPath.addLine(to: P2);
        
        //Init
        shapeLayer = CAShapeLayer();
        
        //Rounded edges?
        shapeLayer.lineJoin = "round";
        shapeLayer.lineCap  = "round";
        
        //Draw
        shapeLayer.path = infoButtonPath.cgPath;
        shapeLayer.strokeColor = UIColor.blue.cgColor;
        shapeLayer.fillColor = nil;
        shapeLayer.lineWidth = lineWidth;
        
        //Add to view
        infoButtonView.layer.addSublayer(shapeLayer);
        self.addSubview(infoButtonView);

        
        //**************************************************************************************************************************//
        //                                             3 - PAPERCLIP                                                                //
        //**************************************************************************************************************************//
        x0 = 160;
        y0 = 14;
        h = 8;
        w = 9;
        lineWidth = 2;
        
        P0 = CGPoint(x: x0,   y: y0);
        P1 = CGPoint(x: x0-w, y: y0+h);
        P2 = CGPoint(x: x0,   y: y0+2*h);
        
        //Init
        clipButtonView = UIView(frame: CGRect(x: 0, y: 520, width: UIScreen.main.bounds.width, height: 45));
        clipButtonPath = UIBezierPath();
        clipButtonPath.move(to: P0);
        clipButtonPath.addLine(to: P1);
        clipButtonPath.addLine(to: P2);
        
        //Init
        shapeLayer = CAShapeLayer();
        
        //Rounded edges?
        shapeLayer.lineJoin = "round";
        shapeLayer.lineCap  = "round";
        
        //Draw
        shapeLayer.path = clipButtonPath.cgPath;
        shapeLayer.strokeColor = UIColor.blue.cgColor;
        shapeLayer.fillColor = nil;
        shapeLayer.lineWidth = lineWidth;
        
        //Add to view
        clipButtonView.layer.addSublayer(shapeLayer);
        self.addSubview(clipButtonView);
        
        
        //**************************************************************************************************************************//
        //                                             4 - SEND ICON                                                                //
        //**************************************************************************************************************************//
        x0 = 225;
        y0 = 14;
        h = 8;
        w = 9;
        lineWidth = 2;
        
        P0 = CGPoint(x: x0,   y: y0);
        P1 = CGPoint(x: x0-w, y: y0+h);
        P2 = CGPoint(x: x0,   y: y0+2*h);
        
        //Init
        sendButtonView = UIView(frame: CGRect(x: 0, y: 520, width: UIScreen.main.bounds.width, height: 45));
        sendButtonPath = UIBezierPath();
        sendButtonPath.move(to: P0);
        sendButtonPath.addLine(to: P1);
        sendButtonPath.addLine(to: P2);
        
        //Init
        shapeLayer = CAShapeLayer();
        
        //Rounded edges?
        shapeLayer.lineJoin = "round";
        shapeLayer.lineCap  = "round";
        
        //Draw
        shapeLayer.path = sendButtonPath.cgPath;
        shapeLayer.strokeColor = UIColor.blue.cgColor;
        shapeLayer.fillColor = nil;
        shapeLayer.lineWidth = lineWidth;
        
        //Add to view
        sendButtonView.layer.addSublayer(shapeLayer);
        self.addSubview(sendButtonView);
        
        
        //**************************************************************************************************************************//
        //                                             5 - PLUS BUTTON                                                              //
        //**************************************************************************************************************************//
        x0 = 285;
        y0 = 14;
        h = 8;
        w = 9;
        lineWidth = 2;
        
        P0 = CGPoint(x: x0,   y: y0);
        P1 = CGPoint(x: x0-w, y: y0+h);
        P2 = CGPoint(x: x0,   y: y0+2*h);
        
        //Init
        plusButtonView = UIView(frame: CGRect(x: 0, y: 520, width: UIScreen.main.bounds.width, height: 45));
        plusButtonPath = UIBezierPath();
        plusButtonPath.move(to: P0);
        plusButtonPath.addLine(to: P1);
        plusButtonPath.addLine(to: P2);
        
        //Init
        shapeLayer = CAShapeLayer();
        
        //Rounded edges?
        shapeLayer.lineJoin = "round";
        shapeLayer.lineCap  = "round";
        
        //Draw
        shapeLayer.path = plusButtonPath.cgPath;
        shapeLayer.strokeColor = UIColor.blue.cgColor;
        shapeLayer.fillColor = nil;
        shapeLayer.lineWidth = lineWidth;
        
        //Add to view
        plusButtonView.layer.addSublayer(shapeLayer);
        self.addSubview(plusButtonView);
        
        
        if(verbose) { print("CellSubview.addDevToolb():          return was pressed, dismissing view"); }
        
        return;
    }
    
//**********************************************************************************************************************************//
//                                                     UITEXTFIELD DELEGATE                                                         //
//**********************************************************************************************************************************//

    /********************************************************************************************************************************/
    /* @fcn       textFieldShouldReturn(_ textField : UITextField) -> Bool                                                          */
    /* @details   dismiss keyboard on completion                                                                                    */
    /********************************************************************************************************************************/
    func textFieldShouldReturn(_ textField : UITextField) -> Bool {
        
        //dismiss
        textField.resignFirstResponder();
        
        if(verbose) { print("ViewController.txtFieldShldRtrn():  return key pressed and exiting"); }
        
        return true;                                                        /* normal behavior                                      */
    }
    

//**********************************************************************************************************************************//
//                                                     UITEXTVIEW DELEGATE                                                          //
//**********************************************************************************************************************************//
    
    /********************************************************************************************************************************/
    /* @fcn       textViewShouldEndEditing(_ textView: UITextView) -> Bool                                                          */
    /* @details   dismiss keyboard on completion       (1/2)                                                                        */
    /********************************************************************************************************************************/
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if(verbose) { print("ViewController.txtViewShldEnd():    return key pressed and signaling exit"); }
        return true;
    }
    
    
    /********************************************************************************************************************************/
    /* @fcn       textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool         */
    /* @details   dismiss keyboard on completion (2/2)                                                                              */
    /********************************************************************************************************************************/
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            mainText.resignFirstResponder();
            if(verbose) { print("ViewController.textView(SCT):       return key pressed and exiting"); }
            return false;
        }

        return true;
    }

    
    /********************************************************************************************************************************/
    /* @fcn       required init?(coder aDecoder: NSCoder)                                                                           */
    /* @details   x                                                                                                                 */
    /********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
}

