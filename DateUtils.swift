/************************************************************************************************************************************/
/** @file       DateUtils.swift
 *  @brief      utilities and example fo Date operations
 *  @details    x
 *
 *  @author     Justin Reina, Firmware Engineer, Jaostech
 *  @created    1/20/18
 *  @last rev   1/20/18
 *
 *  @section    Examples
 *      dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
 *          -->A(0): 1970-02-01T00:00:00.000+0000
 *          -->B(4): Sunday, February 1, 1970
 *          -->C(3): February 1, 1970
 *          -->D(2): Feb 1, 1970
 *          -->E(1): 2/1/70
 *
 *      dateFormat.dateFormat = "yyyy MMM EEEE HH:mm";
 *          -->A(0): 1970 Feb Sunday 00:00
 *          -->B(4): Sunday, February 1, 1970
 *          -->C(3): February 1, 1970
 *          -->D(2): Feb 1, 1970
 *          -->E(1): 2/1/70
 *
 *      dateFormat.dateFormat = "d"
 *          -->A(0): 1
 *          -->B(4): Sunday, February 1, 1970
 *          -->C(3): February 1, 1970
 *          -->D(2): Feb 1, 1970
 *          -->E(1): 2/1/70
 *
 *      dateFormat.dateFormat = "yyyy MMM EEE a";
 *          -->A(0): 1970 Feb Sun AM
 *          -->B(4): Sunday, February 1, 1970
 *          -->C(3): February 1, 1970
 *          -->D(2): Feb 1, 1970
 *          -->E(1): 2/1/70
 *
 *      dateFormat.dateFormat = "EEE, MMM d hh:mm a";
 *          -->A(0): Sun, Feb 1 12:00 AM
 *          -->B(4): Sunday, February 1, 1970
 *          -->C(3): February 1, 1970
 *          -->D(2): Feb 1, 1970
 *          -->E(1): 2/1/70
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


class DateUtils : NSObject {

    /********************************************************************************************************************************/
    /** @fcn        init()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    override init() {
        
        //@note     initialization of additional vars
        
        super.init();
        
        //@note     finalization of initialization
        
        if(verbose) { print("DateUtils.init():             initialization complete"); }

        return;
    }

    /********************************************************************************************************************************/
    /** @fcn        getDateString(date : Date) -> String
     *  @brief      get the conventional date string
     *  @details    "Sat, Jan 20 2018"
     */
    /********************************************************************************************************************************/
    class func getDateString(date : Date) -> String {
    
        let dateFormat = DateFormatter();
        dateFormat.timeZone = TimeZone(abbreviation: "UTC");
        dateFormat.dateStyle = .full;
        dateFormat.dateFormat = "EEE, MMM d YYYY";                          /* @format  'Sun, Jan 23 2000'                          */

        let dateString = dateFormat.string(from: date);
        
        return dateString;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        getTimeString(date : Date) -> String
     *  @brief      get the conventional time string
     *  @details    x
     */
    /********************************************************************************************************************************/
    class func getTimeString(date : Date,_ useMer : Bool?=false) -> String {
        return "\(useMer!)";
    }
    
    /********************************************************************************************************************************/
    /** @fcn        getToday() -> Date
     *  @brief      get today's date
     *  @details    x
     */
    /********************************************************************************************************************************/
    class func getToday() -> Date {
        return Date();
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        printExamples()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    class func printExamples() {
        
        //Get Date String
        let today = Date(timeIntervalSince1970:(31*24*60*60));                  /* @date    2/1/70 @ 12:00                          */
        let dateFormat = DateFormatter();
        dateFormat.timeZone = TimeZone(abbreviation: "UTC");
        dateFormat.dateFormat = "EEE, MMM d hh:mm a";                           /* @format  'Sun, Jan 23 7:26 PM'                   */
        
        var dateString = dateFormat.string(from: today);
        print("DateUtils.printExamples():    (\(dateFormat.dateStyle.rawValue)): \(dateString)");
        
        dateFormat.dateStyle = .full;
        dateString = dateFormat.string(from: today);
        print("DateUtils.printExamples():    (\(dateFormat.dateStyle.rawValue)): \(dateString)");
        
        dateFormat.dateStyle = .long;
        dateString = dateFormat.string(from: today);
        print("DateUtils.printExamples():    (\(dateFormat.dateStyle.rawValue)): \(dateString)");
        
        dateFormat.dateStyle = .medium;
        dateString = dateFormat.string(from: today);
        print("DateUtils.printExamples():    (\(dateFormat.dateStyle.rawValue)): \(dateString)");
        
        dateFormat.dateStyle = .short;
        dateString = dateFormat.string(from: today);
        print("DateUtils.printExamples():    (\(dateFormat.dateStyle.rawValue)): \(dateString)");

        dateFormat.dateStyle = .none;
        dateString = dateFormat.string(from: today);
        print("DateUtils.printExamples():    (\(dateFormat.dateStyle.rawValue)): \(dateString)");

        return;
    }
}
