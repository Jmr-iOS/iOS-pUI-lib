/************************************************************************************************************************************/
/** @file		DataBackup.swift
 *	@project    x
 * 	@brief		x
 * 	@details	x
 *
 * 	@notes		x
 *
 * 	@section	Opens
 *          DataBackup needs tested, and should NOT be used until final confirmation of it's operation!
 *
 * 	@section	Legal Disclaimer
 * 			All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 * 			Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class DataBackup : NSObject, NSCoding {

    //class data
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL         = DocumentsDirectory.appendingPathComponent("ref_bak");

    static let verbose : Bool = false;

    //system value FOR backup
    static var vc : ViewController!;                                        /* for use and access to data during a backup store/load*/

    //data values FOR or FROM backup (temp verbose title for clarity)
    var someVal_0 : Int?;


//MARK: Initialization
    /********************************************************************************************************************************/
    /** @fcn        init?(someVal_0 : Int?, someStr_0 : String?)
     *  @brief      initialization from backup
     *  @details    used by convienence init
     *
     *  @param      [in] (Int?)    someVal_0 - x
     */
    /********************************************************************************************************************************/
    init?(someVal_0 : Int?) {                                               /* Initialization from backup                           */
        
        self.someVal_0 = someVal_0;
        
        if(DataBackup.verbose) { print("DataBackup.init?():           initialization from backup begin (\(someVal_0!))"); }
        
        super.init();
        
        if(DataBackup.verbose) { print("DataBackup.init?():           initialization from backup complete"); }
        
        return;
    }


// MARK: NSCoding
    //Store
    /********************************************************************************************************************************/
    /** @fcn        encode()
     *  @brief      x
     *  @details    x
     *
     *  @param      [in] (NSCoder) aCoder - x
     */
    /********************************************************************************************************************************/
    func encode(with aCoder: NSCoder) {

        aCoder.encode(self.someVal_0, forKey:DataBackupKeys.someVal_0);
        
        if(DataBackup.verbose) { print("DataBackup.encodeWithCoder(): storage complete"); }
        
        return;
    }
    
    
    //Retrieve
    /********************************************************************************************************************************/
    /** @fcn        convenience init?()
     *  @brief      x
     *  @details    x
     *
     *  @param      [in] (NSCoder) coder - x
     */
    /********************************************************************************************************************************/
    required convenience init?(coder aDecoder: NSCoder) {

        let someVal_0Backup : Int? = aDecoder.decodeObject(forKey: DataBackupKeys.someVal_0) as? Int;
        
        if(DataBackup.verbose) { print("DataBackup.convience.init?(): retrieved \(someVal_0Backup!) for dummyData"); }
        
        self.init(someVal_0: someVal_0Backup);
        
        if(DataBackup.verbose) { print("DataBackup.convience.init?(): initialization complete"); }
        
        return;
    }


// MARK: Code Interface
    /********************************************************************************************************************************/
    /*  @fcn        class func loadData()                                                                                           */
    /*  @brief      retrieve the App data & state to file from backup                                                               */
    /*  @details    calls convienence init() on backup retrieval                                                                    */
    /*  @pre        vc is stored                                                                                                    */
    /********************************************************************************************************************************/
    @discardableResult
    class func loadData() -> DataBackup? {

        if(DataBackup.verbose) { print("DataBackup.loadData():        entering NSKeyedUnarchiver search"); }

        let retrievedData : DataBackup? = NSKeyedUnarchiver.unarchiveObject(withFile: DataBackup.ArchiveURL.path) as? DataBackup;

        if(DataBackup.verbose) { print("DataBackup.loadData():        exiting NSKeyedUnarchiver search with '\(String(describing: retrievedData?.hash))'"); }

        //@todo     init data of vc if needed
        
        if(retrievedData != nil) {
            return retrievedData;
        }

        return nil;
    }


    /********************************************************************************************************************************/
    /*	@fcn		class func saveData()                                                                                           */
    /*  @brief      save the App data & state from the view controller access to file for later retrieval                           */
    /********************************************************************************************************************************/
    @discardableResult
    class func saveData() -> Bool {

        var someData : Int = 0;
        
        let prevBak = DataBackup.loadData();
        
        if(prevBak != nil) {
        if(prevBak?.someVal_0 != nil) {
            
            if(DataBackup.verbose) { print("DataBackup.saveData():        found: \(prevBak!.someVal_0!)"); }
            
            someData = (prevBak!.someVal_0!) + 1;
            
            if(DataBackup.verbose) { print("DataBackup.saveData():        saved: \(someData)"); }
        }
        }

        let currState : Int = someData;

        let backup    : DataBackup    = DataBackup(someVal_0: currState)!;

        let backupSaveStatus = NSKeyedArchiver.archiveRootObject(backup,      toFile: DataBackup.ArchiveURL.path);

        if(DataBackup.verbose) { print("DataBackup.saveData():        name save status is '\(backupSaveStatus)' "); }

        return backupSaveStatus;
    }
    
    
    /********************************************************************************************************************************/
    /*	@fcn		class func updateBackup()                                                                                       */
    /*  @brief      a clean wrapper for simple and clear code architecture communication                                            */
    /********************************************************************************************************************************/
    class func updateBackup() {
        DataBackup.saveData();
        return;
    }
    
    
    /********************************************************************************************************************************/
    /*	@fcn		class func storeViewController(vc : ViewController)                                                             */
    /*  @brief      x                                                                                                               */
    /********************************************************************************************************************************/
    class func storeViewController(_ vc : ViewController) {
        DataBackup.vc = vc;
        return;
    }
}


/************************************************************************************************************************************/
/*																  KEYS                                                              */
/************************************************************************************************************************************/
struct DataBackupKeys {
    static let someVal_0 : String = "someVal_0";
}

