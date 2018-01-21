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
    
    //Data
    var nameLabel : UILabel!;
    
    //Config
    private let verbose : Bool;                                     /* for this class                                               */
    
    var temp_i : Int = 0;
    var rslts = [String]();
    let imgV : UIImageView;
    
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
        imgV = UIImageView();
        
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
        let x = Bundle.main.bundleURL;
        guard let fileEnumerator = FileManager.default.enumerator(at: x, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions()) else { return };
        while let file = fileEnumerator.nextObject() {
            let s : String = (file as! NSURL).lastPathComponent!;
            rslts.append(s);
        }
        

        imgV.frame = UIScreen.main.bounds;                                  /* fullscreen                                           */
        imgV.contentMode = .scaleToFill;                                    /* set unscaled                                         */
        imgV.image = UIImage(named: rslts[temp_i]);
        print(rslts[temp_i]);
        temp_i = temp_i + 1;
        
        self.addSubview(imgV);
        
        //**************************************************************************************************************************//
        //                                             NAME LABEL                                                                   //
        //**************************************************************************************************************************//


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
        retButton.sizeToFit();
        retButton.center = CGPoint(x: frame.width/2, y: 600);
        retButton.addTarget(self, action: #selector(returnPress(_:)), for:  .touchUpInside);
        
        
        //Init all hidden
        setContentsAlpha(0);
        
        //Load UI
        mainView.reloadInputViews();
        addSubview(self.nameLabel);
        addSubview(self.retButton);
        
        if(verbose) { print("CellSubview.init():                 my cell #\(parentCell.getNumber()) subview init"); }
 
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        updateBkgnd()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func updateBkgnd() {
        
        imgV.image = UIImage(named: rslts[temp_i]);
        
        temp_i = (temp_i + 1);
        
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
    /* @fcn       setContentsAlpha(_ alpha : CGFloat)                                                                               */
    /* @details   set alpha of all UI contents                                                                                      */
    /********************************************************************************************************************************/
    func setContentsAlpha(_ alpha : CGFloat) {
        
        //Apply alpha to all
        retButton.alpha  = alpha;
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

