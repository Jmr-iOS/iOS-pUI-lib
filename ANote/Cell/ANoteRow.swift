/************************************************************************************************************************************/
/** @file       ANoteRow.swift
 *  @brief      x
 *  @details    x
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
import Foundation


struct ANoteRow {
    var main : String?;                                         /* primary text to display                                          */
    var body : String?;                                         /* sub text displayed below main and smaller                        */
    var bott : String?;                                         /* text for time label                                              */
    var time : Date?;                                           /* time selection for cell                                          */
}

extension ANoteRow {
    
    //@todo     header
    //@note     make easy to acces everywhere
    func getTimeString() -> String {
        
        if(time == nil) {
            return "";                                          /* return empty if no time value                                    */
        }
        
        //Get time components
        var hr  = Calendar.current.component(.hour,   from: time!);
        let min = Calendar.current.component(.minute, from: time!);
        var mer = "AM";
        
        //Handle meridian
        if(hr>11) { mer = "PM"; }
        if(hr>12) { hr = (hr-12); }
        
        //Gen strings
        let hrStr  = "\(hr)";                                           /* num chars std                                            */
        let minStr = String(format: "%02d", min);                       /* num chars 2                                              */
        
        //Gen text
        return "\(hrStr):\(minStr) \(mer)";
    }
    
    
    /****************************************************************************************************************************/
    /** @fcn        getDateString() -> String
     *  @brief      get date for print
     *  @details    x
     *
     *  @section    Examples
     *      "Today 5:00 PM"
     *      "Tomorrow 5:00 PM"
     *      "Fri, Jan 19 7:00 PM"
     */
    /****************************************************************************************************************************/
    func getDateString() -> String {
        
        var returnStr : String = "ABC";
//<TEMP>
        let cal = Calendar.current;
        let isToday : Bool = cal.isDateInToday(time!);
        let isTomm  : Bool = cal.isDateInTomorrow(time!);
        
       /*
 //Get time components
 var hr  = Calendar.current.component(.hour, from: date!);
 let min = Calendar.current.component(.minute, from: date!);
 var mer = "AM";
 
 //Handle meridian
 if(hr>11) { mer = "PM"; }
 if(hr>12) { hr = (hr-12); }
 
 //Gen strings
 let hrStr  = "\(hr)";                                           /* num chars std                                            */
 let minStr = String(format: "%02d", min);                       /* num chars 2                                              */
 
 //Apply text
 timeLabel.text  =   "\(hrStr):\(minStr) \(mer)";
 */
        
        if(isToday) {
            returnStr  = "Today \(getTimeString())";
        } else if(isTomm) {
            returnStr = "Tomorrow \(getTimeString())";
        } else {
            returnStr = "Maybe \(getTimeString())";
        }
        
//</TEMP>
        
        return returnStr;
    }
    
    
    @objc(rowHelperClass) class ANoteRowClass: NSObject, NSCoding {
    
        var row : ANoteRow;
       
        
        /****************************************************************************************************************************/
        /** @fcn        init(row: Row)
         *  @brief      x
         *  @details    x
         */
        /****************************************************************************************************************************/
        init(row: ANoteRow) {
            self.row = row;
            super.init()
        }

        
        /****************************************************************************************************************************/
        /** @fcn        required init?(coder aDecoder: NSCoder)
         *  @brief      x
         *  @details    x
         */
        /****************************************************************************************************************************/
        required init?(coder aDecoder: NSCoder) {
            guard let main = aDecoder.decodeObject(forKey: RowBackupKeys.main) as? String else { return nil; }
            guard let body = aDecoder.decodeObject(forKey: RowBackupKeys.body) as? String else { return nil; }
            guard let bott = aDecoder.decodeObject(forKey: RowBackupKeys.bott) as? String else { return nil; }
            guard let time = aDecoder.decodeObject(forKey: RowBackupKeys.time) as? Date   else { return nil; }
            
            row = ANoteRow(main: main, body: body, bott: bott, time: time);          /* init new row from retrieved                 */
            
            super.init();
            
            return;
        }
        
        
//**********************************************************************************************************************************//
//                                                       ACCESS ROUTINES                                                            //
// @brief       access to data in class                                                                                             //
//**********************************************************************************************************************************//
        
        
        /****************************************************************************************************************************/
        /** @fcn        encode()
         *  @brief      x
         *  @details    x
         */
        /****************************************************************************************************************************/
        func encode(with aCoder: NSCoder) {
            aCoder.encode(row.main, forKey: RowBackupKeys.main);
            aCoder.encode(row.body, forKey: RowBackupKeys.body);
            aCoder.encode(row.bott, forKey: RowBackupKeys.bott);
            aCoder.encode(row.time, forKey: RowBackupKeys.time);
            
            return;
        }
    
        
        /****************************************************************************************************************************/
        /** @fcn        decode() -> ANoteRow?
         *  @brief      x
         *  @details    x
         */
        /****************************************************************************************************************************/
        static func decode() -> ANoteRow? {
            let rowClassObject = NSKeyedUnarchiver.unarchiveObject(withFile: ANoteRowClass.path()) as? ANoteRowClass;
            
            return rowClassObject?.row;
        }
        
        
        /****************************************************************************************************************************/
        /** @fcn        static func saveStocksArray(rowArray: [ANoteRow]) -> Bool
         *  @brief      x
         *  @details    x
         */
        /****************************************************************************************************************************/
        static func saveStocksArray(rowArray: [ANoteRow]) -> Bool {
            let rowObjects = rowArray.map{ANoteRowClass(row: $0)}
            let file = documentsDirectoryURL().appendingPathComponent("ANoteRows").path;         /* @todo        to helper          */
            return NSKeyedArchiver.archiveRootObject(rowObjects, toFile: file);
        }
        
        
        /****************************************************************************************************************************/
        /** @fcn        static func loadStocksArray() -> [ANoteRow]?
         *  @brief      x
         *  @details    x
         */
        /****************************************************************************************************************************/
        static func loadStocksArray() -> [ANoteRow]? {
            let file = documentsDirectoryURL().appendingPathComponent("ANoteRows").path;    /* @todo        to helper               */
            let result = NSKeyedUnarchiver.unarchiveObject(withFile: file);                 /* @todo    string def to Globals       */
            return (result as? [ANoteRowClass])?.map{$0.row}
        }

        
//**********************************************************************************************************************************//
//                                                       HELPER ROUTINES                                                            //
// @brief       common routines                                                                                                     //
//**********************************************************************************************************************************//
        
        /****************************************************************************************************************************/
        /** @fcn        static func documentsDirectoryURL() -> URL
         *  @brief      x
         *  @details    x
         */
        /****************************************************************************************************************************/
        static func documentsDirectoryURL() -> URL {
            let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask);
            return urls[0];
        }
        
        /****************************************************************************************************************************/
        /** @fcn        path()
         *  @brief      x
         *  @details    x
         */
        /****************************************************************************************************************************/
        class func path() -> String {
            let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,
                                                                    FileManager.SearchPathDomainMask.userDomainMask,
                                                                    true).first;
            let path = documentsPath?.appendingFormat("/ANoteRow");                      /* @todo    string def to Globals           */
            
            return path!;
        }
    }
}


/************************************************************************************************************************************/
/*                                                                  KEYS                                                            */
/************************************************************************************************************************************/
struct RowBackupKeys {
    static let main : String = "main";
    static let body : String = "body";
    static let bott : String = "bott";
    static let time : String = "time";
}

