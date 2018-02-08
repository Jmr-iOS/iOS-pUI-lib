/************************************************************************************************************************************/
/** @file       UIKitExtens.swift
 *  @brief      extensions to UIKit classes for project use
 *  @details    x
 *
 *  @section    Opens
 *      font.applyBold()
 *      font.removeBold()
 *      font.applyItalic()
 *      font.removeItalic()
 *
 *  @section    Legal Disclaimer
 *      All contents of this source file and/or any other Jaostech related source files are the explicit property of Jaostech
 *      Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit



//**********************************************************************************************************************************//
//                                                      VIEW EXTENSIONS                                                             //
//**********************************************************************************************************************************//
extension UIView {
    
    /********************************************************************************************************************************/
    /** @fcn        setBorder(color : UIColor, size : CGFloat)
     *  @brief      set the border of view
     *  @details    x
     */
    /********************************************************************************************************************************/
    func setBorder(color : UIColor, size : CGFloat) {
        
        self.layer.borderWidth = size;
        self.layer.borderColor = color.cgColor;
        
        return;
    }
}


//**********************************************************************************************************************************//
//                                                      FONT EXTENSIONS                                                             //
//**********************************************************************************************************************************//
extension UIFont {
    
    /********************************************************************************************************************************/
    /** @fcn        updateSize(_ delta : CGFloat)
     *  @brief      update the size of the font as requested by delta
     *  @details    x
     *
     *  @param      [in] (Int) diff - difference to apply to pointSize
     *
     *  @return     (Int) size after change
     */
    /********************************************************************************************************************************/
    func updateSize(_ delta : CGFloat) -> UIFont {
        return self.withSize(pointSize + delta);
    }
}


//**********************************************************************************************************************************//
//                                                   UIIMAGEVIEW EXTENSIONS                                                         //
//**********************************************************************************************************************************//
extension UIImageView {
    
    /********************************************************************************************************************************/
    /** @fcn        sizeToImage()
     *  @brief      size view to image
     *  @@assum     (image!=nil)
     */
    /********************************************************************************************************************************/
    func sizeToImage() {

        //Grab loc
        let xC = self.center.x;
        let yC = self.center.y;
        
        //Size to fit
        self.frame  = CGRect (x: 0, y: 0, width: (self.image?.size.width)!/2, height: (self.image?.size.height)!/2);
        
        //Move to loc
        self.center = CGPoint(x:xC, y:yC);

        return;
    }
}


//**********************************************************************************************************************************//
//                                                   UIIMAGEVIEW EXTENSIONS                                                         //
//**********************************************************************************************************************************//
extension UITableView {
    
    /********************************************************************************************************************************/
    /** @fcn        refreshTable(numRows : Int)
     *  @brief      refresh table contents for display
     *  @details    x
     *
     *  @param      [in] (Int) numRows - number of rows to refresh (0...numRows-1)
     *
     *  @assum      section=0
     *
     *  @section    Opens
     *      none listed
     */
    /********************************************************************************************************************************/
    func refreshTable(numRows : Int) {
 
        //Reload
        for i in 0...(numRows-1) {
            self.reloadRows(at: [IndexPath(row:i, section:0)], with: .none);                /* reload specified row                 */
        }
 
        //Refresh
        self.reloadData();
 
        return;
    }
}

