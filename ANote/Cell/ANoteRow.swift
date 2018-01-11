/************************************************************************************************************************************/
/** @file       Row.swift
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


struct Row {
    var main : String?;                                         /* primary text to display                                          */
    var body : String?;                                         /* sub text displayed below main and smaller                        */
    var bott : String?;                                         /* text for time label                                              */
    var time : Date?;                                           /* time selection for cell                                          */
}

extension Row {
    
    @objc(rowHelperClass) class RowClass: NSObject, NSCoding {
    
        var row: Row;
       
        
        /****************************************************************************************************************************/
        /** @fcn        init(row: Row)
         *  @brief      x
         *  @details    x
         */
        /****************************************************************************************************************************/
        init(row: Row) {
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
            
            row = Row(main: main, body: body, bott: bott, time: time);          /* init new row from retrieved                      */
            
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
        /** @fcn        static encode(row: Row)
         *  @brief      x
         *  @details    x
         */
        /****************************************************************************************************************************/
        static func encodeX(row: Row) {
            let rowClassObject = RowClass(row: row);
            
            let stat : Bool = NSKeyedArchiver.archiveRootObject(rowClassObject, toFile: RowClass.path());
            
            print("-->I found that the encode save was \(stat)");
            
            return;
        }
    
        
        /****************************************************************************************************************************/
        /** @fcn        decode() -> Row?
         *  @brief      x
         *  @details    x
         */
        /****************************************************************************************************************************/
        static func decode() -> Row? {
            let rowClassObject = NSKeyedUnarchiver.unarchiveObject(withFile: RowClass.path()) as? RowClass;
            
            return rowClassObject?.row;
        }
        
        
        /****************************************************************************************************************************/
        /** @fcn        static func saveStocksArray(rowArray: [Row]) -> Bool
         *  @brief      x
         *  @details    x
         */
        /****************************************************************************************************************************/
        static func saveStocksArray(rowArray: [Row]) -> Bool {
            let rowObjects = rowArray.map{RowClass(row: $0)}
            let file = documentsDirectoryURL().appendingPathComponent("Rows").path;         /* @todo        to helper               */
            return NSKeyedArchiver.archiveRootObject(rowObjects, toFile: file);
        }
        
        
        /****************************************************************************************************************************/
        /** @fcn        static func loadStocksArray() -> [Row]?
         *  @brief      x
         *  @details    x
         */
        /****************************************************************************************************************************/
        static func loadStocksArray() -> [Row]? {
            let file = documentsDirectoryURL().appendingPathComponent("Rows").path;         /* @todo        to helper               */
            let result = NSKeyedUnarchiver.unarchiveObject(withFile: file);                 /* @todo    string def to Globals       */
            return (result as? [RowClass])?.map{$0.row}
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
            let path = documentsPath?.appendingFormat("/Row");                          /* @todo    string def to Globals           */
            
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

