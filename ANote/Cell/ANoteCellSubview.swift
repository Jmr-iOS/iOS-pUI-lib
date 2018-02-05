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
 *      text and graphics colors adjust to selected background (e.g. darker text for darker bkgnds etc.)
 *           have divider update color for brown background (hard to see)
 *
 *  @section    Data Architecture
 *      each row represents a data entry whose data is captured in completion by the row's cell subview, presented here. all data
 *      fields are thus represented as fields of the cell subview (e.g. nameLabel, etc.)
 *
 *  @section    Opens
 *      Gen as new class
 *      white box
 *      box tap selection
 *      Add lines
 *      Add text
 *      Add checkbox w/delegate
 *      Add due date stamp
 *      Add icons
 *
 * 	@section	Legal Disclaimer
 * 			All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 * 			Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class ANoteCellSubview : UIView, UITextFieldDelegate, UITextViewDelegate, UIDateStampDelegate {
    
    //New
    var backButton : UIButton!;
    var infoButton : UIButton!;
    var clipButton : UIButton!;
    var sendButton : UIButton!;
    var plusButton : UIButton!;
    
    //Ref
    var mainView   : UIView!;                                       /* main view of app                                             */
    var parentCell : NewTableViewCell!;
    
    //UI
    var topBar     : UIView;
    var titleBar   : UIView;
    var titleField : UITextField;
    var dateBar    : UIView;
    var datePlace  : UIView;
    var mainText   : UITextView;
    var menuBar    : UIView;
    var bookmark   : UIButton;

    //Date
    var dateLabel : UILabel!;
    var dateStamp : UIDateStamp!;
    
    //Star bar
    var stars    : [UIImageView];
    var starView : UIView!;
    var starCt   : Int!;
    
    //Config
    let numStars = 5;
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
    
    //Images
    let bookImg_sel   = UIImage(named:"bookmark_selected.png");
    let bookImg_unsel = UIImage(named:"bookmark_unselected.png");
    let starImg_on  = UIImage(named: "star_on.png");
    let starImg_off = UIImage(named: "star_off.png");
    
    //(temp)
    var v        : UIView!;
    var foldV    : UIView!;                                         /* folder listing, topbar                                       */
    var bookSel  : Bool;

    
    /********************************************************************************************************************************/
	/**	@fcn		init(mainView : UIView, parentCell : NewTableViewCell)
	 *  @brief		x
     *
     *  @param      [in] (UIView) mainView - main view of app
     *  @param      [in] (ANoteTableViewCell) - parent cell for subview
     *
     *  @post       all UI contents hidden
     */
	/********************************************************************************************************************************/
    init(mainView : UIView, parentCell : NewTableViewCell) {
        
        //Prep Background
        bkgndView = UIImageView();
        
        //Init UI
        topBar     = UIView();
        titleBar   = UIView();
        titleField = UITextField();
        dateBar    = UIView();
        datePlace  = UIView();
        mainText   = UITextView();
        menuBar    = UIView();
        bookmark   = UIButton(type: UIButtonType.roundedRect);

        //Init Vars
        bookSel = false;
        stars   = [UIImageView]();

        //Super
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
        y = (y + topBar.bounds.height);

        //Section Label
        initSectLabel(topBar);
        
        //Bookmark Icon
        initBookmark(topBar);
        
        
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
        
        //Divider
        let divider = UIView(frame: CGRect(x:13, y: (y+1), width: (UIScreen.main.bounds.width-2*13), height: 0.5));
        divider.backgroundColor = UIColor.gray;
        divider.alpha = 0.20;

        
        //**************************************************************************************************************************//
        //                                                         DATE BAR                                                         //
        //**************************************************************************************************************************//
        dateBar.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: 33);
        y = (y + dateBar.bounds.height);

        //Init text
        let dateLabel   = UILabel(frame: CGRect(x:14, y:10, width:0, height:0));
        
        //Setup Text
        dateLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 12);
        dateLabel.textColor = UIColor.lightGray;
        dateLabel.textAlignment = .left;
        dateLabel.translatesAutoresizingMaskIntoConstraints = true;
        dateLabel.text = "Thu, Jul 7, 2016";
        dateLabel.sizeToFit();
    
        //Add action
        let tapGesture : UITapGestureRecognizer = UITapGestureRecognizer();
        tapGesture.numberOfTapsRequired = 1;
        dateLabel.addGestureRecognizer(tapGesture);
        dateLabel.isUserInteractionEnabled = true;
        tapGesture.addTarget(self, action: #selector(dateLabelPress(_:)));
        
        //Add Stars
        initStars(dateBar);
    
        //Add to view
        dateBar.addSubview(dateLabel);

        
        //**************************************************************************************************************************//
        //                                                        DATE VIEW                                                         //
        // @todo    only inserted when date is present                                                                              //
        //**************************************************************************************************************************//
        dateStamp = UIDateStamp(y0: y);
        dateStamp.setDelegate(self);
        y = (y + dateStamp.bounds.height);
        
        
        //**************************************************************************************************************************//
        //                                                        MAIN TEXT                                                         //
        //**************************************************************************************************************************//
        mainText.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: 312);
        mainText.returnKeyType = UIReturnKeyType.done;
        mainText.textColor = UIColor.lightGray;
        mainText.backgroundColor = nil;                                 /* set to transparent (dflt:white)                          */
        mainText.delegate = self;
        mainText.text = "";
        y = (y + mainText.bounds.height);
        
        
        //**************************************************************************************************************************//
        //                                                        MENU BAR                                                          //
        //**************************************************************************************************************************//
        menuBar.frame = CGRect(x: 0, y: y, width: UIScreen.main.bounds.width, height: (UIScreen.main.bounds.height - y));

        //Init all hidden
        setContentsAlpha(0);
        
        //Load UI
        mainView.reloadInputViews();
        addSubview(bkgndView);
        addSubview(topBar);
        addSubview(titleBar);
        addSubview(dateBar);
        addSubview(dateStamp);
        addSubview(divider);
        addSubview(mainText);
//!!!   addDevToolbar(parentCell.vc.view);
        
//!!!   if(verbose) { print("CellSubview.init():                 my cell #\(parentCell.getNumber()) subview init"); }
 
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        initBookmark(_ view : UIView)
     *  @brief      initialize bookmark button
     *
     *  @param      [in] (UIView) view - view to add bookmark into
     *
     *  @pre    bookmark is initialized
     */
    /********************************************************************************************************************************/
    func initBookmark(_ view : UIView) {

        let x0 : CGFloat = (UIScreen.main.bounds.width - 37);
        let y0 : CGFloat = 9;
        
        //Config
        bookmark.translatesAutoresizingMaskIntoConstraints = true;
        bookmark.frame = CGRect(x: x0, y: y0, width:30, height:30);
        bookmark.setBackgroundImage(bookImg_unsel, for: UIControlState());
        bookmark.addTarget(self, action: #selector(bookPress(_:)), for:  .touchUpInside);
        bookmark.sizeToFit();
        
        //Add
        view.addSubview(bookmark);

        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        initSectLabel(_ view : UIView)
     *  @brief      initialize bookmark button
     *
     *  @param      [in] (UIView) view - view to add bookmark into
     *
     *  @pre    bookmark is initialized
     */
    /********************************************************************************************************************************/
    func initSectLabel(_ view : UIView) {
        
        //Text
        foldV = UIView(frame: CGRect(x:8, y:11, width:60, height:20));
        let t   = UILabel(frame: CGRect(x:10, y:5, width:0, height:0));
        t.center = CGPoint(x:20, y:2);
        
        //Setup Text
        t.font = UIFont(name: "HelveticaNeue-Medium", size: 12);
        t.textColor = UIColor.lightGray;
        t.textAlignment = .center;
        t.translatesAutoresizingMaskIntoConstraints = true;
        t.text = "Today";
        t.sizeToFit();
        
        //@todo  Draw Folder (5)
        let foldImg = UIImageView();
        foldImg.frame = CGRect(x:5, y:3, width:277/21, height:255/20);    /* scale by x18                                           */
        foldImg.contentMode = .scaleToFill;                               /* set unscaled                                           */
        foldImg.image = UIImage(named: "folder_icon.png");                /* acquire next background                                */

        //Integrate
        foldV.addSubview(t);
        //foldV.addSubview(fPh);
        foldV.addSubview(foldImg);
        foldV.sizeToFit();
        
        //Add
        view.addSubview(foldV);

        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        initStars(_ view : UIView)
     *  @brief      initialize stars bar
     *  @details    one button overlaid on five star images
     *
     *  @param      [in] (UIView) view - view to add bookmark into
     *
     *  @pre    bookmark & stars initialized
     */
    /********************************************************************************************************************************/
    func initStars(_ view : UIView) {
        
        let xOffs = (UIScreen.main.bounds.width - 85);
        
        //Init view
        starView = UIView(frame: CGRect(x: xOffs, y:10, width:68, height: 20));
        starCt   = 0;
        
        //Populate stars
        for i in 0...(numStars-1) {
            //Init
            let star = UIImageView(frame: CGRect(x:5+(i*12), y:2, width:10, height: 10));
            star.image = starImg_off;                                       /* init all to off                                      */
            star.contentMode = .scaleToFill;

            //Add
            stars.append(star);                                             /* to member var for later access                       */
            starView.addSubview(star);                                      /* to view                                              */
        }
        
        //Add action
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(starResponse(_:)));
        starView.addGestureRecognizer(tapGestureRecognizer);
        
        //Add to view
        view.addSubview(starView);

        return;
    }

    
    /********************************************************************************************************************************/
    /* @fcn       setContentsAlpha(_ alpha : CGFloat)                                                                               */
    /* @details   set alpha of all UI contents                                                                                      */
    /********************************************************************************************************************************/
    func setContentsAlpha(_ alpha : CGFloat) {
        
        //Apply alpha to all
        topBar.alpha    = alpha;
        titleBar.alpha  = alpha;
        datePlace.alpha = alpha;
        dateBar.alpha   = alpha;
        mainText.alpha  = alpha;
        menuBar.alpha   = alpha;
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        tapResponse(i : Int)
     *  @brief      tap response to dateStamp selection
     *  @details    x
     *
     *  @section    Opens
     *      implement response & handle on selection
     */
    /********************************************************************************************************************************/
    @objc func tapResponse(i : Int) {

//!!!   let ts = ANoteTimeSelect(parentCell.vc, parentCell, Date());
       
//!!!   ts.show(parentCell.vc);
        
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

        let w    : CGFloat = UIScreen.main.bounds.width;
        
        let x0    : CGFloat = 33;
        let y0    : CGFloat = UIScreen.main.bounds.height - 28;
        let xOffs : CGFloat = (w-2*x0)/4;

        
        //**************************************************************************************************************************//
        //                                             1 - RETURN ARROW                                                             //
        //**************************************************************************************************************************//
        backButton = UIButton(type: UIButtonType.roundedRect);
        backButton.translatesAutoresizingMaskIntoConstraints = true;
        backButton.sizeToFit();
        backButton.center = CGPoint(x: x0, y: y0);
        backButton.setBackgroundImage(UIImage(named:"subview_back.png"), for: UIControlState());
        backButton.addTarget(self, action: #selector(backPress(_:)), for:  .touchUpInside);
        
       self.addSubview(backButton);

        
        //**************************************************************************************************************************//
        //                                             2 - INFO BUTTON                                                              //
        //**************************************************************************************************************************//
        infoButton = UIButton(type: UIButtonType.roundedRect);
        infoButton.translatesAutoresizingMaskIntoConstraints = true;
        infoButton.sizeToFit();
        infoButton.center = CGPoint(x: x0+1*xOffs, y: y0);
        infoButton.setBackgroundImage(UIImage(named:"subview_info.png"), for: UIControlState());
        infoButton.addTarget(self, action: #selector(infoPress(_:)), for:  .touchUpInside);
        
        self.addSubview(infoButton);
        
        
        //**************************************************************************************************************************//
        //                                             3 - PAPERCLIP                                                                //
        //**************************************************************************************************************************//
        clipButton = UIButton(type: UIButtonType.roundedRect);
        clipButton.translatesAutoresizingMaskIntoConstraints = true;
        clipButton.sizeToFit();
        clipButton.center = CGPoint(x: x0+2*xOffs, y: y0);
        clipButton.setBackgroundImage(UIImage(named:"subview_paperclip.png"), for: UIControlState());
        clipButton.addTarget(self, action: #selector(clipPress(_:)), for:  .touchUpInside);
        
        self.addSubview(clipButton);
        
        
        //**************************************************************************************************************************//
        //                                             4 - SEND ICON                                                                //
        //**************************************************************************************************************************//
        sendButton = UIButton(type: UIButtonType.roundedRect);
        sendButton.translatesAutoresizingMaskIntoConstraints = true;
        sendButton.sizeToFit();
        sendButton.center = CGPoint(x: x0+3*xOffs, y: y0);
        sendButton.setBackgroundImage(UIImage(named:"subview_send.png"), for: UIControlState());
        sendButton.addTarget(self, action: #selector(sendPressed(_:)), for:  .touchUpInside);
        
        self.addSubview(sendButton);
        
        
        //**************************************************************************************************************************//
        //                                             5 - PLUS BUTTON                                                              //
        //**************************************************************************************************************************//
        v = UIView(frame:CGRect(x:x0+4*xOffs,y:y0,width:3,height:4));
        
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
        plusButton.center = CGPoint(x: 334, y: y0-2);
        plusButton.addTarget(self, action: #selector(plusPress(_:)), for:  .touchUpInside);

        self.addSubview(v);
        self.addSubview(plusButton);
        
        
        if(verbose) { print("CellSubview.addDevToolb():          toolbar population complete"); }
        
        return;
    }

    
//**********************************************************************************************************************************//
//                                                      BUTTON & VIEW RESPONSES                                                     //
//**********************************************************************************************************************************//

    /********************************************************************************************************************************/
    /** @fcn        dateLabelPress(_ gestureRecognizer: UITapGestureRecognizer)
     *  @brief      date label was pressed
     *
     *  @param      [in] (UIButton!) sender - button pressed
     */
    /********************************************************************************************************************************/
    @objc func dateLabelPress(_ gestureRecognizer: UITapGestureRecognizer) {
        
//!!!   let vc = parentCell.vc!;
//!!!   let date = Date();
        
        //(temp for disp)
//!!!   let ts = ANoteTimeSelect(vc, parentCell, date);
//!!!   ts.show(vc);
        
        if(verbose) { print("CellSubview.dateLblPr():            date was pressed"); }
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        starResponse(_ sender: UIButton!)
     *  @brief      star bar was pressed
     *
     *  @param      [in] (UIButton!) sender - button pressed
     */
    /********************************************************************************************************************************/
    @objc func starResponse(_ gestureRecognizer: UITapGestureRecognizer) {
        
        //Increment count
        starCt = ((starCt+1)%(numStars+1));                                         /* selection to advance                         */
        
        //Set stars
        for i in 0...(numStars-1) {
        
            var img = starImg_off;
            
            if(i < starCt) {
                img = starImg_on;
            }
            
            //Update the new star
            stars[i].image = img;
        }
        
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        bookPress(_ sender: UIButton!)
     *  @brief      bookmark was pressed
     *
     *  @param      [in] (UIButton!) sender - button pressed
     */
    /********************************************************************************************************************************/
    @objc func bookPress(_ sender: UIButton!) {
        
        if(bookSel) {
            bookmark.setBackgroundImage(bookImg_unsel, for: UIControlState());
        } else {
            bookmark.setBackgroundImage(bookImg_sel, for: UIControlState());
        }
        
        bookSel = !bookSel;
        
        if(verbose) { print("CellSubview.bookPress():    bookmark pressed"); }
        
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
        
        if(verbose) { print("CellSubview.backPress():            back was pressed, dismissing view"); }

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

//<DEV>
        backButton.isHidden = !backButton.isHidden;
        //infoButton.isHidden = !infoButton.isHidden;
        clipButton.isHidden = !clipButton.isHidden;
        sendButton.isHidden = !sendButton.isHidden;
        v.isHidden          = !v.isHidden;
//<DEV>

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
//!!!   let p = ANoteTimeSelect(parentCell.vc, parentCell, parentCell.date);

        //Grab new time
//!!!   p.show(parentCell.vc);

        if(verbose) { print("CellSubview.clipPress():    clip was pressed"); }

        return;
    }

    var devCtr : Int = 1;
    
    /********************************************************************************************************************************/
    /** @fcn        sendPressed(_ sender: UIButton!)
     *  @brief        return was pressed, return to main
     *
     *  @param      [in] (UIButton!) sender - button pressed
     *  @note      @objc exposed to enabled handleTap() access, not sure why
     */
    /********************************************************************************************************************************/
    @objc func sendPressed(_ sender: UIButton!) {
        
        //Swap nil, empty, date
        dateStamp.setStamp(devCtr);        
        devCtr = (devCtr+1)%3;
        
        if(verbose) { print("CellSubview.sendPressed():          send was pressed"); }

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
        
        //@todo     handle other fields
        
        //Update
//!!!   parentCell.updateTitle(titleField.text!);
        
        //dismiss
        textField.resignFirstResponder();

        if(verbose) { print("CellSubview.txtFieldShldRtrn():     return key pressed and exiting"); }
        
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
        if(verbose) { print("CellSubview.txtViewShldEnd():       return key pressed and signaling exit"); }
        return true;
    }
    
    
    /********************************************************************************************************************************/
    /* @fcn       textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool         */
    /* @details   dismiss keyboard on completion (2/2)                                                                              */
    /********************************************************************************************************************************/
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            mainText.resignFirstResponder();
            if(verbose) { print("CellSubview.textView(SCT):          return key pressed and exiting"); }
            return false;
        }

        return true;
    }


//**********************************************************************************************************************************//
//                                                          HELPERS                                                                 //
//**********************************************************************************************************************************//
    
    //@todo     header
    func updateDate(date : Date) {
        //apply to all fields
        dateLabel.text = "Thu, Jul 8, 2016";
        print("todo");
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
    /* @fcn       required init?(coder aDecoder: NSCoder)                                                                           */
    /* @details   x                                                                                                                 */
    /********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
}

