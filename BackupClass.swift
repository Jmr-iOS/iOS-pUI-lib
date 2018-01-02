/************************************************************************************************************************************/
/** @file       BackupClass.swift
 *  @brief      x
 *  @details    x
 *
 *  @author     Justin Reina, Firmware Engineer, Jaostech
 *  @created    1/1/18
 *  @last rev   1/1/18
 *
 *
 *  @notes      x
 *
 *  @section    Opens
 *      remove NSObject ref if possible
 *
 *  @section    Legal Disclaimer
 *      All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 *      Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class BackupClass : NSObject, NSCoding {
    
    var someField: String;
    
    
    /********************************************************************************************************************************/
    /** @fcn        init(blogName: String)
     *  @brief      designated initializer
     */
    /********************************************************************************************************************************/
    init(someField: String) {
        self.someField = someField;
        
        super.init();                                           /* call NSObject's init method                                      */
        
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn      func encode(with aCoder: NSCoder)
     *  @brief    x
     *  @details  x
     */
    /********************************************************************************************************************************/
    func encode(with aCoder: NSCoder) {
        aCoder.encode(someField, forKey: ClassBackupKeys.someField);
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn      func encodeWithCoder(aCoder: NSCoder)
     *  @brief    x
     *  @details  x
     */
    /********************************************************************************************************************************/
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encode(someField, forKey: ClassBackupKeys.someField);
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn      required convenience init?(coder aDecoder: NSCoder)
     *  @brief    x
     *  @details  x
     */
    /********************************************************************************************************************************/
    required convenience init?(coder aDecoder: NSCoder) {
        // decoding could fail, for example when no Blog was saved before calling decode
        guard let unarchivedFieldName = aDecoder.decodeObject(forKey: ClassBackupKeys.someField) as? String
            else {
                // option 1 : return an default Blog
                self.init(someField: "unnamed");
                return;
                
                // option 2 : return nil, and handle the error at higher level
        }
        
        // convenience init must call the designated init
        self.init(someField: unarchivedFieldName);
    }
}




/************************************************************************************************************************************/
/*                                                                  KEYS                                                            */
/************************************************************************************************************************************/
struct ClassBackupKeys {
    static let someField : String = "someField";
}
