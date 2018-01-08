/************************************************************************************************************************************/
/** @file       TexturedLabel.swift
 *  @project    x
 *  @brief      x
 *  @details    x
 *
 *  @author     Justin Reina, Firmware Engineer, Jaostech
 *  @created    1/8/18
 *  @last rev   1/8/18
 *
 *
 *  @notes      x
 *
 *  @section    Opens
 *      TexturedView allows specification of color
 *
 *  @section    Legal Disclaimer
 *      All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 *      Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit

//@need
class TexturedLabel :  NSObject {
    
    var label     : UILabel;
    var imageView : UIImageView;

    
    /********************************************************************************************************************************/
    /** @fcn        init()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    override init() {
        
        //Init
        label     = UILabel();
        imageView = UIImageView();
        
        //Super
        super.init();
        
        //Image
        imageView.image = UIImage(named:"textured");                /* grab texture img                                             */
        
        //Placement
        imageView.contentMode = .topLeft;                           /* place the image in the upper left corner unscaled            */
        imageView.clipsToBounds = true;                             /* constrain image to frame boundaries                          */
        
        print("TexturedLabel.init():         initialization complete");
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        frame(_ frame : CGRect)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func text(_ text : String) {
        label.text = text;
        print("TexturedLabel.text():         complete");
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        frame(_ frame : CGRect)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func frame(_ frame : CGRect) {
        label.frame     = frame;                                    /* apply the frame to both                                      */
        imageView.frame = frame;
        print("TexturedLabel.frame():        complete");
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        color(_ color : UIColor)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func color(_ color : UIColor) {
        imageView.backgroundColor = color;                          /* set the background color of the view, setting texture color  */
        print("TexturedLabel.color():        complete");
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        font(_ font : UIFont?)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func font(_ font : UIFont?) {
        label.font = font;
        print("TexturedLabel.font():         complete");
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        textColor(_ textColor : UIColor)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func textColor(_ textColor : UIColor) {
        label.textColor = textColor;
        print("TexturedLabel.textColor():    complete");
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        textAlignment(_ textAlignment : NSTextAlignment)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func textAlignment(_ textAlignment : NSTextAlignment) {
        label.textAlignment = textAlignment;
        print("TexturedLabel.textAlignmnt(): complete");
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        numberOfLines(_ numberOfLines : Int)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func numberOfLines(_ numberOfLines : Int) {
        label.numberOfLines = numberOfLines;
        print("TexturedLabel.numLinescol():  complete");
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        lineBreakMode(_ lineBreakMode : NSLineBreakMode)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func lineBreakMode(_ lineBreakMode : NSLineBreakMode) {
        label.lineBreakMode = lineBreakMode;
        print("TexturedLabel.lineBreakMod(): complete");
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        addToView(_ view : UIView)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func addToView(_ view : UIView) {

        view.addSubview(self.imageView);                            /* add textured view to input view                              */
        view.addSubview(self.label);                                /* add the label to input view on top                           */

        print("TexturedView.addToView():     adding to view complete");
        
        return;
    }
}

