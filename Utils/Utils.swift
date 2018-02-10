/************************************************************************************************************************************/
/** @file       Utils.swift
 *  @project    x
 *  @brief      x
 *  @details    x
 *
 *  @author     Justin Reina, Firmware Engineer, Jaostech
 *  @created    1/4/18
 *  @last rev   2/9/18
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


//**********************************************************************************************************************************//
//                                                    Global Definitions                                                            //
//**********************************************************************************************************************************//
let NUM_MONTHS_IN_YEAR    : Int = 12;
let NUM_DAYS_IN_MONTH_MAX : Int = 31;
let NUM_HOURS_IN_DAY      : Int = 24;
let NUM_MIN_IN_HOUR       : Int = 60;
let NUM_SEC_IN_MIN        : Int = 60;


//**********************************************************************************************************************************//
//                                                     Global Types                                                                 //
//**********************************************************************************************************************************//

/************************************************************************************************************************************/
/** @fcn        Dimension
 *  @brief      table dimension
 *  @details    x
 *  @open       consider moving to conditional inclusion or different naming for clarity
 */
/************************************************************************************************************************************/
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
    
 
    /********************************************************************************************************************************/
    /** @fcn        class func delay(_ t_s : Int)
     *  @brief      delay for t(ms)
     *  @details    x
     */
    /********************************************************************************************************************************/
    class func delay(_ t_ms : Int) {
        usleep(UInt32(t_ms*1000000));
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        class func delayMs(_ t_ms : Int)
     *  @brief      delay for t(ms)
     *  @details    x
     */
    /********************************************************************************************************************************/
    class func delayMs(_ t_ms : Int) {
        usleep(UInt32(t_ms*1000));
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        class func delayUs(_ t_us : Int)
     *  @brief      delay for t(us)
     *  @details    x
     */
    /********************************************************************************************************************************/
    class func delayUs(_ t_us : Int) {
        usleep(UInt32(t_us));
        return;
    }
}
