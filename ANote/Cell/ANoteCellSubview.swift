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
 *      keyboard dismisses
 *      main view here is scrollable
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


class ANoteCellSubview : UIView {
    
    //Ref
    var mainView     : UIView!;                                     /* main view of app                                             */
    var parentCell   : ANoteTableViewCell!;
    
    //UI
    var topBar    : UIView;
    var titleBar  : UIView;
    var dateBar   : UIView;
    var datePlace : UIView;
    var mainText  : UITextView;
    var menuBar   : UIView;
    
    //PrevUI
    var retButton  : UIButton!;                                     /* return button of the subview                                 */
    
    //Config
    private let verbose : Bool = false;                             /* for this class                                               */
    
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
        titleBar.backgroundColor = UIColor.red;
        y = (y + titleBar.bounds.height);

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
        mainText.backgroundColor = UIColor.orange;
        mainText.text = "main";
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
            print("CellSubview.dismissSubView():       sliding view out");
            self.alpha = 1.0;
            self.frame = getCSFrame(onscreen: false);
        }, completion: { (finished: Bool) -> Void in
            print("CellSubview.dismissSubView():       sliding view out completion");
            self.setContentsAlpha(0);
            self.frame = getCSFrame(onscreen: false);
        });
        
        self.mainView.reloadInputViews();
        
        return;
    }
    
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
}

