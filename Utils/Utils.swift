/************************************************************************************************************************************/
/** @file       Utils.swift
 *  @project    x
 *  @brief      x
 *  @details    x
 *
 *  @author     Justin Reina, Firmware Engineer, Jaostech
 *  @created    1/4/18
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


/********************************************************************************************************************************/
/** @fcn        Dimension
 *  @brief      table dimension
 *  @details    x
 *  @open       consider moving to conditional inclusion or different naming for clarity
 */
/********************************************************************************************************************************/
enum Dimension {
    case cols;
    case rows;
}


class Utils : NSObject {
    
    /********************************************************************************************************************************/
    /** @fcn        init()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    override init() {
        super.init();
        print("Utils.init():    initialization complete");

        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        class func selectedRowValue(handler : UIPickerViewDelegate, picker : UIPickerView, ic : Int) -> String
     *  @brief      get value of selected column (ic)
     *  @details    x
     */
    /********************************************************************************************************************************/
    class func selectedRowValue(handler : UIPickerViewDelegate, picker : UIPickerView, ic : Int) -> String {
        
        //Row Index
        let ir  = picker.selectedRow(inComponent: ic);
        
        //Value
        let val = handler.pickerView!(picker, titleForRow:  ir, forComponent: ic);
        
        return val!;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        class func rand() -> Double
     *  @brief      get a random Double [0:1]
     *  @details    range (0:1)
     *
     *  @return     (Double) random number between 0 and 1
     *
     *  @ref    https://learnappmaking.com/random-numbers-swift/
     *
     *  @section    Description
     *      drand48() - (Double) [0.0:del:1.0]
     */
    /********************************************************************************************************************************/
    class func rand() -> Double {
        let randInt : UInt32 = arc4random();                                /* true random seed & unique each call                  */
        let randDbl : Double = Double(randInt)/Double(UInt32.max);          /* convert to Double                                    */
        return randDbl;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        class func randN() -> Int
     *  @brief      get a random Int (min:1:max)
     *  @details    range (-INT_MIN:INT_MAX) [(-2^32):(2^32-1)]
     *
     *  @return     (Double) random number between 0 and 1
     *
     *  @ref    https://learnappmaking.com/random-numbers-swift/
     *
     *  @section    Description
     *      arc4random()           - (UInt32) [0:1:(2^32-1]
     *      arc4random_uniform(_:) - (UInt32) [0:1:(n-1)]
     */
    /********************************************************************************************************************************/
    class func randN() -> Int {
        return Int(arc4random());
    }
    
    /********************************************************************************************************************************/
    /** @fcn        class func randN(_ max : Int) -> Int
     *  @brief      get a random Int within a range (0:max)
     *  @details    x
     */
    /********************************************************************************************************************************/
    class func randN(_ max : Int) -> Int {
        
        //Calc value
        let x : Double = (rand() * Double(max));
        
        //Convert units
        return Int(x);
    }
    
    /********************************************************************************************************************************/
    /** @fcn        class func randN(_ min : Int,_ max : Int) -> Int
     *  @brief      get a random Int within a range (0:max)
     *  @details    x
     */
    /********************************************************************************************************************************/
    class func randN(_ min : Int,_ max : Int) -> Int {
        
        //Calc value
        let x : Double = (rand() * (Double(max-min)) + Double(min));        /* offset past min by delta                             */
                
        //Convert units
        return Int(x);
    }
    
    
}
