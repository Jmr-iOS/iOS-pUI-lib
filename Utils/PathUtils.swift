/************************************************************************************************************************************/
/** @file       PathUtils.swift
 *  @project    x
 *  @brief      x
 *  @details    x
 *
 *  @author     Justin Reina, Firmware Engineer, Jaostech
 *  @created    1/31/18
 *  @last rev   1/31/18
 *
 *
 *  @notes      x
 *
 *  @section    Opens
 *      none current
 *
 *  @section    Legal Disclaimer
 *      All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 *      Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class PathUtils : NSObject {
    
    //Angle Definitions
    static let RIGHT = CGFloat(0);
    static let DOWN  = CGFloat(Double.pi/2);
    static let LEFT  = CGFloat(Double.pi);
    static let UP    = CGFloat(3*Double.pi/2);
    
    
    /********************************************************************************************************************************/
    /** @fcn        init()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    override init() {
        super.init();
        
        if(verbose) { print("PathUtils.init():                   initialization complete"); }

        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        class func addPathToView(_ view : UIView,_ path : UIBezierPath,_ lineWidth : CGFloat,
     *                                       _ lineColor : UIColor?,_ fillColor : UIColor?)
     *  @brief      add a path into a view
     *  @details    x
     *
     *  @param      [in] (UIView) view - view to add to
     *  @param      [in] (UIView) path - path to add
     *  @param      [in] (CGFloat) lineWidth - line width to apply
     *
     *  @section    Opens
     *      make colors optional inputs with default values
     */
    /********************************************************************************************************************************/
    class func addPathToView(_ view : UIView,_ path : UIBezierPath,_ lineWidth : CGFloat,_ lineColor : UIColor?,_ fillColor : UIColor?) {
        
        //Init
        let newShapeLayer = CAShapeLayer();
        
        //Draw
        newShapeLayer.path = path.cgPath;
        if(lineColor != nil) { newShapeLayer.strokeColor = lineColor!.cgColor; }
        if(fillColor != nil) { newShapeLayer.fillColor   = fillColor!.cgColor; }
        newShapeLayer.lineWidth = lineWidth;
        
        //Rounded edges?
        newShapeLayer.lineJoin = "round";
        newShapeLayer.lineCap  = "round";
        
        //Add to view
        view.layer.addSublayer(newShapeLayer);
        
        if(verbose) { print("PathUtils.addPathToView():          path added to view"); }
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        class func drawLinePath(_ start : CGPoint,_ end : CGPoint) -> UIBezierPath
     *  @brief      draw line
     *  @details    x
     *
     *  @param      [in] (UIView) start - begin line
     *  @param      [in] (UIView) end   - end line
     *
     *  @return     (UIBezierPath) path rendered
     */
    /********************************************************************************************************************************/
    class func drawLinePath(_ start : CGPoint,_ end : CGPoint) -> UIBezierPath {
        
        //Init
        let path = UIBezierPath();
        
        //Gen
        path.move(to: start);
        path.addLine(to: end);
        
        if(verbose) { print("PathUtils.drawLinePath():           path added to view"); }
        
        return path;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        class func drawCirclePath(_ center : CGPoint,_ radius : CGFloat) -> UIBezierPath
     *  @brief      draw full circle
     *  @details    x
     *
     *  @param      [in] (CGPoint) center - begin line
     *  @param      [in] (CGFloat) radius   - end line
     *
     *  @return     (UIBezierPath) path rendered
     */
    /********************************************************************************************************************************/
    class func drawCirclePath(_ center : CGPoint,_ radius : CGFloat) -> UIBezierPath {
        
        let path = UIBezierPath();
        
        path.addArc(withCenter: center, radius: radius, startAngle: UP,   endAngle: DOWN, clockwise: true);
        path.addArc(withCenter: center, radius: radius, startAngle: DOWN, endAngle: UP,   clockwise: true);
        
        if(verbose) { print("PathUtils.drawCirclePath():         path added to view"); }
        
        return path;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        class func drawSemiCirclePath(_ center : CGPoint,_ radius : CGFloat,_ start : CGFloat,_ end : CGFloat) -> UIBezierPath
     *  @brief      draw semicircle
     *  @details    x
     *
     *  @param      [in] (CGPoint) center - center of arc
     *  @param      [in] (CGFloat) radius - arc radius
     *  @param      [in] (CGFloat) start  - start angle [Deg]
     *  @param      [in] (CGFloat) end    - end angle [Deg]
     *
     *  @return     (UIBezierPath) path rendered
     */
    /********************************************************************************************************************************/
    class func drawSemiCirclePath(_ center : CGPoint,_ radius : CGFloat,_ start : CGFloat,_ end : CGFloat) -> UIBezierPath {
        
        let path = UIBezierPath();
        
        //Expand notation
        let startAngle : CGFloat = CGFloat((start/180)*CGFloat(Double.pi));
        let endAngle   : CGFloat = CGFloat((end/180)*CGFloat(Double.pi));
        
        //Draw
        path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle,   clockwise: true);
        
        if(verbose) { print("PathUtils.drawSemiCirclePath():     path added to view"); }
        
        return path;
    }
    
}
