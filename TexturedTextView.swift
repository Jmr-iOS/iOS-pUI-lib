/************************************************************************************************************************************/
/** @file       TexturedTextView.swift
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
class TexturedTextView :  NSObject {
    
    var textview  : UITextView;
    var imageView : UIImageView;

    
    /********************************************************************************************************************************/
    /** @fcn        init()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    override init() {
        
        //Init
        textview  = UITextView();
        imageView = UIImageView();
        
        //Super
        super.init();
        
        //Image
        imageView.image = UIImage(named:"textured");                /* grab texture img                                             */
        
        //Text
        textview.backgroundColor = nil;                             /* for imageview to be seen through                             */
        
        //Placement
        imageView.contentMode = .topLeft;                           /* place the image in the upper left corner unscaled            */
        imageView.clipsToBounds = true;                             /* constrain image to frame boundaries                          */
        
        print("TexturedTextView.init():      initialization complete");
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        frame(_ frame : CGRect)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func text(_ text : String) {
        
        textview.text = text;
        
        print("TexturedTextView.text():      complete");
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        frame(_ frame : CGRect)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func frame(_ frame : CGRect) {
        
        textview.frame  = frame;                                    /* apply the frame to both                                      */
        imageView.frame = frame;
        
        print("TexturedTextView.frame():     complete");
        
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
        
        print("TexturedTextView.color():     complete");
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        font(_ font : UIFont?)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func font(_ font : UIFont?) {
        textview.font = font;
        print("TexturedTextView.font():      complete");
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        textColor(_ textColor : UIColor)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func textColor(_ textColor : UIColor) {
        textview.textColor = textColor;
        print("TexturedTextView.textColor(): complete");
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        textAlignment(_ textAlignment : NSTextAlignment)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func textAlignment(_ textAlignment : NSTextAlignment) {
        textview.textAlignment = textAlignment;
        print("TexturedTextView.textAligt(): complete");
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
        view.addSubview(self.textview);                             /* add the text to input view on top                            */

        print("TexturedView.addToView():     adding to view complete");
        
        return;
    }
}

