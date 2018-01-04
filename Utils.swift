/************************************************************************************************************************************/
/** @file       Utils.swift
 *  @project    x
 *  @brief      x
 *  @details    x
 *
 *  @author     Justin Reina, Firmware Engineer, Jaostech
 *  @created    1/4/18
 *  @last rev   1/4/18
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
}
