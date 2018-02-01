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
    var backButton : UIButton!;
    var infoButton : UIButton!;
    var clipButton : UIButton!;
    var sendButton : UIButton!;
    var plusButton : UIButton!;
    
    //Ref
    var mainView   : UIView!;                                       /* main view of app                                             */
    var parentCell : ANoteTableViewCell!;
    
    //UI
    var topBar     : UIView;
    var titleBar   : UIView;
    var titleField : UITextField;
    var dateBar    : UIView;
    var datePlace  : UIView;
    var mainText   : UITextView;
    var menuBar    : UIView;
    
    //Config
    private let verbose : Bool = true;                              /* for this class                                               */

    //Background
    var bkgnds    : [String]!;
    var bkgnd_ind : Int!;                                           /* index of background for cell                                 */
    let bkgndView : UIImageView;                                    /* view holding background image                                */

    //Angle Definitions
    let RIGHT = CGFloat(0);
    let DOWN  = CGFloat(Double.pi/2);
    let LEFT  = CGFloat(Double.pi);
    let UP    = CGFloat(3*Double.pi/2);
    
    //(temp)
    var v : UIView!;
    
    
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
        
        //Init UI
        topBar = UIView();
        titleBar = UIView();
        titleField = UITextField();
        dateBar = UIView();
        datePlace = UIView();
        mainText = UITextView();
        menuBar = UIView();
        
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
        bkgnds    = getCellBackgrounds();                                   /* get all backgrounds                                  */
        bkgnd_ind = Utils.randN(0, bkgnds.count);                           /* pick random selection                                */
        bkgndView.frame = UIScreen.main.bounds;                             /* fullscreen                                           */
        bkgndView.contentMode = .scaleToFill;                               /* set unscaled                                         */
        bkgndView.image = UIImage(named: bkgnds[bkgnd_ind]);                /* acquire next background                              */

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
        
        if(verbose) { print("CellSubview.init():                 my cell #\(parentCell.getNumber()) subview init"); }
 
        return;
    }

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
            //let s : String = "cellsubview_ref.PNG";
            let s : String = (file as! NSURL).lastPathComponent!;
            
            var type = (file as! NSURL).pathExtension;
            type = type?.lowercased();                                  /* handle both cases                                        */
            
            //Filter Images
            var valid : Bool = ((type?.contains("png"))! || (type?.contains("jpg"))! || (type?.contains("jpeg"))!);
            
            //Filter Icons
            valid = (valid && !s.contains("AppIcon"));
            
            valid = (valid && s.contains("cellSubview"));
            
            //Append
            if(valid) {
                rslts.append(s);
            }
        }
        
        return rslts;
    }
    
    
    /********************************************************************************************************************************/
    /* @fcn       setContentsAlpha(_ alpha : CGFloat)                                                                               */
    /* @details   set alpha of all UI contents                                                                                      */
    /********************************************************************************************************************************/
    func setContentsAlpha(_ alpha : CGFloat) {
        
        //Apply alpha to all
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

        let x0    : CGFloat = 28;
        let xOffs : CGFloat = 65;
        
        
        //**************************************************************************************************************************//
        //                                             1 - RETURN ARROW                                                             //
        //**************************************************************************************************************************//
        backButton = UIButton(type: UIButtonType.roundedRect);
        backButton.translatesAutoresizingMaskIntoConstraints = true;
        backButton.sizeToFit();
        backButton.center = CGPoint(x: x0, y: 540);
        backButton.setBackgroundImage(UIImage(named:"subview_back.png"), for: UIControlState());
        backButton.addTarget(self, action: #selector(backPress(_:)), for:  .touchUpInside);
        
       self.addSubview(backButton);

        
        //**************************************************************************************************************************//
        //                                             2 - INFO BUTTON                                                              //
        //**************************************************************************************************************************//
        infoButton = UIButton(type: UIButtonType.roundedRect);
        infoButton.translatesAutoresizingMaskIntoConstraints = true;
        infoButton.sizeToFit();
        infoButton.center = CGPoint(x: x0+1*xOffs, y: 540);
        infoButton.setBackgroundImage(UIImage(named:"subview_info.png"), for: UIControlState());
        infoButton.addTarget(self, action: #selector(infoPress(_:)), for:  .touchUpInside);
        
        self.addSubview(infoButton);
        
        
        //**************************************************************************************************************************//
        //                                             3 - PAPERCLIP                                                                //
        //**************************************************************************************************************************//
        clipButton = UIButton(type: UIButtonType.roundedRect);
        clipButton.translatesAutoresizingMaskIntoConstraints = true;
        clipButton.sizeToFit();
        clipButton.center = CGPoint(x: x0+2*xOffs, y: 540);
        clipButton.setBackgroundImage(UIImage(named:"subview_paperclip.png"), for: UIControlState());
        clipButton.addTarget(self, action: #selector(clipPress(_:)), for:  .touchUpInside);
        
        self.addSubview(clipButton);
        
        
        //**************************************************************************************************************************//
        //                                             4 - SEND ICON                                                                //
        //**************************************************************************************************************************//
        sendButton = UIButton(type: UIButtonType.roundedRect);
        sendButton.translatesAutoresizingMaskIntoConstraints = true;
        sendButton.sizeToFit();
        sendButton.center = CGPoint(x: x0+3*xOffs, y: 540);
        sendButton.setBackgroundImage(UIImage(named:"subview_send.png"), for: UIControlState());
        sendButton.addTarget(self, action: #selector(sendPressed(_:)), for:  .touchUpInside);
        
        self.addSubview(sendButton);
        
        
        //**************************************************************************************************************************//
        //                                             5 - PLUS BUTTON                                                              //
        //**************************************************************************************************************************//
        v = UIView(frame:CGRect(x:285,y:540,width:3,height:4));
        
        //Circle
        let p1 = PathUtils.drawCirclePath(CGPoint(x:0, y:0), 22);
        let p2 = PathUtils.drawLinePath(CGPoint(x:-10,y:0),   CGPoint(x:+10, y:0));
        let p3 = PathUtils.drawLinePath(CGPoint(x:0,  y:-10), CGPoint(x:0,   y:+10));
        
        PathUtils.addPathToView(v, p1, 1, nil, UIColor.orange);
        PathUtils.addPathToView(v, p2, 2, UIColor.white, nil);
        PathUtils.addPathToView(v, p3, 2, UIColor.white, nil);
        
        plusButton = UIButton(type: UIButtonType.roundedRect);
        plusButton.translatesAutoresizingMaskIntoConstraints = true;
        plusButton.sizeToFit();
        plusButton.frame = CGRect(x:0, y:0, width:45, height:45);
        plusButton.center = CGPoint(x: 334, y: 538);
        plusButton.addTarget(self, action: #selector(plusPress(_:)), for:  .touchUpInside);

        self.addSubview(v);
        self.addSubview(plusButton);
        
        
        if(verbose) { print("CellSubview.addDevToolb():          toolbar population complete"); }
        
        return;
    }
    
    
    
    /********************************************************************************************************************************/
    /** @fcn        backPress(_ sender: UIButton!)
     *  @brief        return was pressed, return to main
     *
     *  @param      [in] (UIButton!) sender - button pressed
     *  @note      @objc exposed to enabled handleTap() access, not sure why
     */
    /********************************************************************************************************************************/
    @objc func backPress(_ sender: UIButton!) {
        
        if(verbose) { print("CellSubview.backPress():  back was pressed, dismissing view"); }

        //Move Frame offscreen
        self.frame = getCSFrame(onscreen: false);
        
        //Dismiss
        self.dismissSubView();
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        infoPress(_ sender: UIButton!)
     *  @brief        return was pressed, return to main
     *
     *  @param      [in] (UIButton!) sender - button pressed
     *  @note      @objc exposed to enabled handleTap() access, not sure why
     */
    /********************************************************************************************************************************/
    @objc func infoPress(_ sender: UIButton!) {
        
        backButton.isHidden = !backButton.isHidden;
        //infoButton.isHidden = !infoButton.isHidden;
        clipButton.isHidden = !clipButton.isHidden;
        sendButton.isHidden = !sendButton.isHidden;
        v.isHidden          = !v.isHidden;
 
        if(verbose) { print("CellSubview.infoPress():    info was pressed"); }

        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        clipPress(_ sender: UIButton!)
     *  @brief        return was pressed, return to main
     *
     *  @param      [in] (UIButton!) sender - button pressed
     *  @note      @objc exposed to enabled handleTap() access, not sure why
     */
    /********************************************************************************************************************************/
    @objc func clipPress(_ sender: UIButton!) {
        
        //Init view
        let p = ANoteTimeSelect(parentCell.vc, parentCell, date: parentCell.date);
        
        //Grab new time
        p.show(parentCell.vc);

        if(verbose) { print("CellSubview.clipPress():    clip was pressed"); }

        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        sendPressed(_ sender: UIButton!)
     *  @brief        return was pressed, return to main
     *
     *  @param      [in] (UIButton!) sender - button pressed
     *  @note      @objc exposed to enabled handleTap() access, not sure why
     */
    /********************************************************************************************************************************/
    @objc func sendPressed(_ sender: UIButton!) {
        
        if(verbose) { print("CellSubview.sendPressed():  send was pressed"); }

        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        plusPress(_ sender: UIButton!)
     *  @brief        return was pressed, return to main
     *
     *  @param      [in] (UIButton!) sender - button pressed
     *  @note      @objc exposed to enabled handleTap() access, not sure why
     */
    /********************************************************************************************************************************/
    @objc func plusPress(_ sender: UIButton!) {
        
        if(verbose) { print("CellSubview.returnPress():  plus was pressed"); }
        
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

