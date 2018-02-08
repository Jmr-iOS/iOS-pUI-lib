/************************************************************************************************************************************/
/** @file		ViewUtils.swift
 *  @project    x
 * 	@brief		x
 * 	@details	x
 *
 * 	@author		Justin Reina, Firmware Engineer, Jaostech
 * 	@created	1/26/18
 * 	@last rev	2/7/18
 *
 * 	@section	Opens
 *      @todo   support multiple apps concurrently      (currently supports one)
 * 		@todo   support multiple popups concurrently    (currently supports one)
 *
 * 	@section	Legal Disclaimer
 * 	    All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 * 		Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit

//Global Defs
let wS : CGFloat = UIScreen.main.bounds.width;                                          /* screen dimensions                        */
let hS : CGFloat = UIScreen.main.bounds.height;
let bS : CGRect  = UIScreen.main.bounds;


class ViewUtils : NSObject {
    
    //Vars
    static var view         : UIView!;                                                  /* main view of running application         */
    static var popupView    : UIView!                                                   /* popup to launch                          */
    static var popupLabel   : UILabel!;                                                 /* label for popup holding text             */
    static var popupRunning : Bool = false;                                             /* is the popup in progress?                */
    
    //Const
    static let popupHeight : CGFloat = 35;

    
    /********************************************************************************************************************************/
    /** @fcn        init()
     *  @brief      x
     */
    /********************************************************************************************************************************/
    override init() {

        //Super
        super.init();
        
        if(verbose) { print("ViewUtils.init():      initialization complete"); }
        return;
    }

    
//**********************************************************************************************************************************//
//                                                        POPUP MESSAGE                                                             //
//**********************************************************************************************************************************//
    
    /********************************************************************************************************************************/
    /** @fcn        class func popup(_ msg : String)
     *  @brief      launch a popup message
     *
     *  @section     Opens
     *      @todo   specify  launch time & delays
     *      @todo   specify with callback
     *      @todo   specify background color
     *      @todo   specify height
     *      @todo   specify font
     *      @todo   respond to selection
     */
    /********************************************************************************************************************************/
    class func popup(_ msg : String) {
        
        //@pre  safety
        if(view == nil)  { fatalError("ViewUtils.popup():    view not stored on call, aborting"); }
        if(popupRunning) { fatalError("ViewUtils.popup():    popup attempted while already in progress, aborting"); }
        
        //@pre  init
        if(popupView == nil) {
            initPopup();
        }
        
        //Apply message
        popupLabel.text = msg;
        
        //Launch
        launchPopup();
        
        print("popup launched for \(msg)");
        
        return;
    }

    /********************************************************************************************************************************/
    /** @fcn        class func initPopup()
     *  @brief      x
     */
    /********************************************************************************************************************************/
    class func initPopup() {
        
        //Create text label
        popupLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: popupHeight));
        popupLabel.font  =   UIFont(name: "HelveticaNeue", size: 17);
        popupLabel.text  =   "";
        popupLabel.textColor     = UIColor.white;
        popupLabel.textAlignment = NSTextAlignment.center;
        
        //Create popup view
        popupView = UIView();
        popupView.backgroundColor = UIColor(red: 83/255, green: 90/255, blue: 102/255, alpha: 1);
        popupView.addSubview(popupLabel);
        popupView.frame = CGRect(x: 0, y: hS, width: self.view.frame.width, height: popupHeight);
        
        //Add to view
        view.addSubview(popupView);

        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        class func launchPopup()
     *  @brief      x
     */
    /********************************************************************************************************************************/
    class func launchPopup() {

        //@pre  safety
        if(popupRunning) { fatalError("ViewUtils.lnchPop():  popup attempted while already in progress, aborting"); }
        
        //Mark in progress
        popupRunning = true;
        
        //Begin launch
        UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            if(verbose) { print("ViewUtils.loadPopup():              sliding popup in"); }
            self.popupView.frame = CGRect(x: 0, y: hS-popupHeight, width: wS, height: popupHeight);
            
        }, completion: { (finished: Bool) -> Void in
            if(verbose) { print("ViewUtils.loadPopup():              sliding popup in completion"); }
            
            //queue dismissal
            Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(dismissPopup), userInfo: nil, repeats: false);
        });
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        class func dismissPopup()
     *  @brief      x
     */
    /********************************************************************************************************************************/
    @objc class func dismissPopup() {

        //@pre  safety
        if(!popupRunning) { fatalError("ViewUtils.dismpop():  popup dismissal attempted but not up, aborting"); }
        
        //Begin dismiss
        UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            if(verbose) { print("ViewUtils.loadPopup():              sliding popup out"); }
            self.popupView.frame = CGRect(x: 0, y: hS, width: self.view.frame.width, height: popupHeight);
            
        }, completion: { (finished: Bool) -> Void in
            if(verbose) { print("ViewUtils.loadPopup():              sliding popup out completion"); }
            popupRunning = false;                                           /* mark as dismissed                                    */

            
        });

        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        class func popupInProg() -> Bool
     *  @brief      return if popup in progress to view
     */
    /********************************************************************************************************************************/
    class func popupInProg() -> Bool {
        return popupRunning;
    }
    
    
//**********************************************************************************************************************************//
//                                                          POPUP MENU                                                              //
//**********************************************************************************************************************************//

    /********************************************************************************************************************************/
    /** @fcn        class func genPopupMenu() -> PopupMenu
     *  @brief      generate a popup menu
     */
    /********************************************************************************************************************************/
    class func genPopupMenu() -> PopupMenu {
        return PopupMenu();
    }
    
    
//**********************************************************************************************************************************//
//                                                          HELPERS                                                                 //
//**********************************************************************************************************************************//

    /********************************************************************************************************************************/
    /** @fcn        class func storeView(_ view : UIView)
     *  @brief      store main view for popup insertion
     */
    /********************************************************************************************************************************/
    class func storeView(_ view : UIView) {
        self.view = view;
        return;
    }

}


/************************************************************************************************************************************/
/** @class      PopupMenu : UIView
 *  @brief      popmenu for use
 *
 *  @section     Opens
 *      working
 */
/************************************************************************************************************************************/
class PopupMenu : UIView {
    
    //Datatypes
    struct Row {
        var title     : String?;                                    /* nil fields are unused (e.g. nil title left blank)            */
        var resp      : ()->()?;
        var height    : Int?;
        var textColor : UIColor?;
        var bakColor  : UIColor?;
    }

    //State
    var rows : [Row];
    
    
    /********************************************************************************************************************************/
    /** @fcn        init()
     *  @brief      x
     */
    /********************************************************************************************************************************/
    init() {
        
        //Init
        rows = [Row]();
        
        //Super
        super.init(frame:CGRect(x:1,y:2,width:3,height:4));
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        addRow(_ title: String,_  resp: @escaping ()->())
     *  @brief      x
     */
    /********************************************************************************************************************************/
    func addRow(_ title: String?,_  resp: @escaping ()->()?) {
        
        let r : Row = Row(title: title, resp: resp, height: nil, textColor: nil, bakColor: nil);
        
        rows.append(r);
        
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        getRow(i : Int) -> PopupMenu.Row
     *  @brief      x
     */
    /********************************************************************************************************************************/
    func getRow(i : Int) -> PopupMenu.Row {
        return rows[i];
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        setRows(_ rows: [PopupMenu.Row])
     *  @brief      x
     */
    /********************************************************************************************************************************/
    func setRows(_ rows: [PopupMenu.Row]) {
        self.rows = rows;                                                   /* swift copies arrays on assignment                    */
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        getRows()
     *  @brief      x
     */
    /********************************************************************************************************************************/
    func getRows() ->  [PopupMenu.Row] {
        return rows;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        show()
     *  @brief      x
     */
    /********************************************************************************************************************************/
    func show() {
        
        //@pre (if already launched ignore)
        
        
        //Create the table
        
        
        //Launch it
        
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        dismiss()
     *  @brief      x
     */
    /********************************************************************************************************************************/
    func dismiss() {
        print("dismiss");
        
        //Fade offscreen
        
        //Dispose?
        
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        required init?(coder aDecoder: NSCoder)
     *  @brief      x
     */
    /********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
}
