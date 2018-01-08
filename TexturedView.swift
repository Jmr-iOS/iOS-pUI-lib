/************************************************************************************************************************************/
/** @file       TexturedView.swift
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
class TexturedView :  NSObject {
    
    var imageView : UIImageView;
    
    /********************************************************************************************************************************/
    /** @fcn        init()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    override init() {
        
        //Init
        imageView = UIImageView();
        
        //Super
        super.init();
        
        //Image
        imageView.image = UIImage(named:"textured");                /* grab texture img                                             */
        
        //Placement
        imageView.contentMode = .topLeft;                           /* place the image in the upper left corner unscaled            */
        imageView.clipsToBounds = true;                             /* constrain image to frame boundaries                          */
        
        print("TexturedView.init():          initialization complete");
        
        return;
    }
    

    /********************************************************************************************************************************/
    /** @fcn        frame(_ frame : CGRect)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func frame(_ frame : CGRect) {
        
        imageView.frame = frame;                                    /* apply the frame to the imageview                             */
        
        print("TexturedView.frame():         complete");
        
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
        
        print("TexturedView.color():         complete");
        
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

        print("TexturedView.addToView():     adding to view complete");
        
        return;
    }
}

