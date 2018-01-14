/************************************************************************************************************************************/
/** @file		ANoteCellSubview.swift
 * 	@brief		x
 * 	@details	x
 *
 * 	@section	Opens
 * 		none current
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
    var retButton  : UIButton!;                                     /* return button of the subview                                 */
    var mainButton : UIButton!;
    var bodyButton : UIButton!;
    var bottButton : UIButton!;
    
    //Data
    var nameLabel : UILabel!;
    
    //Config
    private let verbose : Bool;                                     /* for this class                                               */
    
    
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
        
        verbose = false;
        
        super.init(frame: UIScreen.main.bounds);
        
        //Store
        self.mainView = mainView;
        self.parentCell = parentCell;

        
        //**************************************************************************************************************************//
        //                                              INIT UI                                                                     //
        //**************************************************************************************************************************//
        backgroundColor = UIColor.white;
        frame = getCSFrame(onscreen: false);

		//Add name label
        nameLabel = UILabel();
        
        nameLabel.text = "Item #\(self.parentCell.getNumber()) Subview";
        nameLabel.font = UIFont(name: "MarkerFelt-Thin", size: 15);
        nameLabel.textColor = UIColor.black;
        nameLabel.numberOfLines = 1;

        nameLabel.numberOfLines = 0;
        nameLabel.sizeToFit();
        nameLabel.textAlignment = .center;
        nameLabel.center = CGPoint(x: UIScreen.main.bounds.width/2, y: 65);
        nameLabel.translatesAutoresizingMaskIntoConstraints = true;

        //**************************************************************************************************************************//
        //                                            INIT BUTTON                                                                   //
        //**************************************************************************************************************************//
        retButton = UIButton(type: UIButtonType.roundedRect);
 
        retButton.translatesAutoresizingMaskIntoConstraints = true;
        retButton.setTitle("Return",      for: UIControlState());
        retButton.backgroundColor = UIColor.green;
        retButton.sizeToFit();
        retButton.center = CGPoint(x: frame.width/2, y: 100);
        retButton.addTarget(self, action: #selector(returnPress(_:)), for:  .touchUpInside);
        
        
        //**************************************************************************************************************************//
        //                                            MAIN BUTTON                                                                   //
        //**************************************************************************************************************************//
        mainButton = UIButton(type: UIButtonType.roundedRect);
        
        mainButton.translatesAutoresizingMaskIntoConstraints = true;
        mainButton.setTitle("Main",      for: UIControlState());
        mainButton.backgroundColor = UIColor.green;
        mainButton.sizeToFit();
        mainButton.center = CGPoint(x: 40, y: 130);
        mainButton.addTarget(self, action: #selector(mainPress(_:)), for:  .touchUpInside);
        
        
        //**************************************************************************************************************************//
        //                                            BODY BUTTON                                                                   //
        //**************************************************************************************************************************//
        bodyButton = UIButton(type: UIButtonType.roundedRect);
        
        bodyButton.translatesAutoresizingMaskIntoConstraints = true;
        bodyButton.setTitle("Body",      for: UIControlState());
        bodyButton.backgroundColor = UIColor.green;
        bodyButton.sizeToFit();
        bodyButton.center = CGPoint(x: 40, y: 170);
        bodyButton.addTarget(self, action: #selector(bodyPress(_:)), for:  .touchUpInside);
    
        
        //**************************************************************************************************************************//
        //                                            BOTT BUTTON                                                                   //
        //**************************************************************************************************************************//
        bottButton = UIButton(type: UIButtonType.roundedRect);
        
        bottButton.translatesAutoresizingMaskIntoConstraints = true;
        bottButton.setTitle("Bott",      for: UIControlState());
        bottButton.backgroundColor = UIColor.green;
        bottButton.sizeToFit();
        bottButton.center = CGPoint(x: 40, y: 210);
        bottButton.addTarget(self, action: #selector(bottPress(_:)), for:  .touchUpInside);
        
        
        //Init all hidden
        setContentsAlpha(0);
        
        //@temp for debug validation
        backgroundColor = UIColor(red:0.44, green:0.07, blue:0.07, alpha:1.0);
        
        self.viewDidLoadish();
        
        if(verbose) { print("CellSubview.init():                 my custom cell #\(parentCell.getNumber()) subview init"); }
 
        return;
    }

    func viewDidLoadish() {
    
        mainView.reloadInputViews();
        addSubview(self.nameLabel);
        addSubview(self.retButton);
        addSubview(self.mainButton);
        addSubview(self.bodyButton);
        addSubview(self.bottButton);
        
        return;

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
    /** @fcn        mainPress(_ sender: UIButton!)
     *  @brief        return was pressed, return to main
     *
     *  @param      [in] (UIButton!) sender - button pressed
     *  @note      @objc exposed to enabled handleTap() access, not sure why
     */
    /********************************************************************************************************************************/
    @objc func mainPress(_ sender: UIButton!) {
        
        if(verbose) { print("CellSubview.returnPress():  main was pressed, dismissing view"); }

        self.parentCell.subjectField.text = self.parentCell.subjectField.text! + "2";
        self.parentCell.vc.rows[self.parentCell.tableIndex].main = self.parentCell.subjectField.text;
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        bodyPress(_ sender: UIButton!)
     *  @brief        return was pressed, return to main
     *
     *  @param      [in] (UIButton!) sender - button pressed
     *  @note      @objc exposed to enabled handleTap() access, not sure why
     */
    /********************************************************************************************************************************/
    @objc func bodyPress(_ sender: UIButton!) {
        
        if(verbose) { print("CellSubview.returnPress():  body was pressed, dismissing view"); }
        
        self.parentCell.descripField.text = self.parentCell.descripField.text! + "3";
        self.parentCell.vc.rows[self.parentCell.tableIndex].body = self.parentCell.descripField.text;
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        bottPress(_ sender: UIButton!)
     *  @brief        return was pressed, return to main
     *
     *  @param      [in] (UIButton!) sender - button pressed
     *  @note      @objc exposed to enabled handleTap() access, not sure why
     */
    /********************************************************************************************************************************/
    @objc func bottPress(_ sender: UIButton!) {
        
        if(verbose) { print("CellSubview.returnPress():  bottom was pressed, dismissing view"); }
        
        parentCell.bottField.text = self.parentCell.bottField.text! + "3";
        parentCell.vc.rows[parentCell.tableIndex].bott = parentCell.bottField.text;
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /* @fcn       setContentsAlpha(_ alpha : CGFloat)                                                                                 */
    /* @details   set alpha of all UI contents                                                                                      */
    /********************************************************************************************************************************/
    func setContentsAlpha(_ alpha : CGFloat) {
        
        //Apply alpha to all
        retButton.alpha  = alpha;
        mainButton.alpha = alpha;
        bodyButton.alpha = alpha;
        bottButton.alpha = alpha;
        nameLabel.alpha  = alpha;
    
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

