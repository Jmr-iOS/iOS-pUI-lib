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
    
    //Temp-UI
    var retButton  : UIButton!;                                     /* return button of the subview                                 */
    
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
        
        super.init(frame: UIScreen.main.bounds);
        
        //Store
        self.mainView = mainView;
        self.parentCell = parentCell;

        //Init view
        backgroundColor = UIColor.white;
        frame = getCSFrame(onscreen: false);
        
        
        //**************************************************************************************************************************//
        //                                              BACKGROUND                                                                  //
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
        //                                              TOP BAR                                                                     //
        //**************************************************************************************************************************//
        topBar.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: 37);
        topBar.backgroundColor = UIColor.lightGray;
        y = (y + topBar.bounds.height);
        
        
        //**************************************************************************************************************************//
        //                                              TITLE BAR                                                                   //
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
        //                                               DATE BAR                                                                   //
        //**************************************************************************************************************************//
        dateBar.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: 33);
        dateBar.backgroundColor = UIColor.darkGray;
        y = (y + dateBar.bounds.height);

        
        //**************************************************************************************************************************//
        //                                             DATE VIEW                                                                    //
        // @todo    only inserted when date is present                                                                              //
        //**************************************************************************************************************************//
        datePlace.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: 81);
        datePlace.backgroundColor = UIColor.blue;
        y = (y + datePlace.bounds.height);
        
        
        //**************************************************************************************************************************//
        //                                             MAIN TEXT                                                                    //
        //**************************************************************************************************************************//
        mainText.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: 312);
        mainText.returnKeyType = UIReturnKeyType.done;
        mainText.backgroundColor = nil;
        mainText.delegate = self;
        mainText.text = "";
        y = (y + mainText.bounds.height);
        
        
        //**************************************************************************************************************************//
        //                                             MENU BAR                                                                     //
        //**************************************************************************************************************************//
        menuBar.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - y));
        menuBar.backgroundColor = UIColor.purple;


        //**************************************************************************************************************************//
        //                                          RETURN BUTTON                                                                   //
        //**************************************************************************************************************************//
        retButton = UIButton(type: UIButtonType.roundedRect);
        
        retButton.translatesAutoresizingMaskIntoConstraints = true;
        retButton.setTitle("Return",      for: UIControlState());
        retButton.sizeToFit();
        retButton.center = CGPoint(x: frame.width/2, y: 500);
        retButton.addTarget(self, action: #selector(returnPress(_:)), for:  .touchUpInside);
        
        //Init all hidden
        setContentsAlpha(0);
        
        //Load UI
        mainView.reloadInputViews();
        addSubview(bkgndView);
        addSubview(retButton);
        addSubview(topBar);
        addSubview(titleBar);
        addSubview(dateBar);
        addSubview(datePlace);
        addSubview(mainText);
        addSubview(menuBar);
        
        addSubview(retButton);

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
        
        let x = Bundle.main.bundleURL;
        let fileEnumerator = FileManager.default.enumerator(at: x, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions());
        
        while let file = fileEnumerator?.nextObject() {
            let s : String = (file as! NSURL).lastPathComponent!;
            
            var type = (file as! NSURL).pathExtension;
            type = type?.lowercased();                                  /* handle both cases                                        */
            
            let valid : Bool = ((type?.contains("png"))! || (type?.contains("jpg"))! || (type?.contains("jpeg"))!);
            
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

