import SwiftUI
import SQLite3

class DButils {
    
    static func openDatabase() -> OpaquePointer? {
        var db: OpaquePointer?
        db = nil
        
        
        enum Database: String {
            case Part1
            case Part2
            case Part3
            
            var path: String? {
                let tutorialDirectoryUrl = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                return tutorialDirectoryUrl?.appendingPathComponent("\(self.rawValue).sqlite").relativePath
            }
        }
        
        let dbPath = Database.Part3.path
        //    dbPath = "turmeric1"
        
        let returnValue = sqlite3_open(dbPath, &db)
 //       print("returnValue = \(returnValue)")
        if  returnValue == SQLITE_OK {
            print("Successfully opened connection to database at dawana")
        } else {
            print("Unable to open database. Return value: \(returnValue)" )
        }
        return db
    }
    
    
    static func insert(db: OpaquePointer,insertStatementString: String) -> Bool{
        var returnValue = true
        var insertStatement: OpaquePointer?
        var sqlReturnValue = sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil)
        
        if sqlReturnValue == SQLITE_OK {
            sqlReturnValue = sqlite3_step(insertStatement)
            if sqlReturnValue  == SQLITE_DONE {
                print("\nSuccessfully inserted row.")
            }
            else {
                print("\nCould not insert row. Return value: \(sqlReturnValue)")
            }
            sqlite3_reset(insertStatement)
        }
        else {
            let errormsg = sqlite3_errmsg(db)
            print("\nINSERT statement is not prepared.Return value: \(sqlReturnValue) : Msg - \(errormsg)")
            returnValue = false
        }
        
        sqlReturnValue = sqlite3_finalize(insertStatement)
        return returnValue
    }
    
    static func tableExists(db: OpaquePointer, tableName : String) -> Bool {
        //Add logic to return table name
        var returnValue = true
//        let queryStatementString = "SELECT name FROM sqlite_master WHERE type='table' AND name='{\(tableName)}';"
        let queryStatementString = "SELECT name FROM sqlite_master WHERE type='table' AND name='\(tableName)';"
        let collist = query(db: db, queryString: queryStatementString)
        if collist.count == 0{
            returnValue = false
        } else {
            returnValue = true
        }
        return returnValue
    }
    
    static func createTable(db: OpaquePointer , createTableString : String, tableName : String, forceCreate : Bool) -> Bool{
        
        var returnvalue = true
        let tableExists = DButils.tableExists(db: db,tableName: tableName)
        var createTableFlag = false
        var createTableStatement: OpaquePointer?
        if tableExists == true {
            //Check if table already exists
            if forceCreate  == true {
                //Drop the table
                createTableFlag = true
                dropTable(db: db, tableName: tableName)
            }
        } else {
            createTableFlag = true
        }
        if(createTableFlag == true) {
            //Check if table is there and if it there return
            var sqlreturnvalue = sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil)
            
            if sqlreturnvalue == SQLITE_OK {
                sqlreturnvalue = sqlite3_step(createTableStatement)
                if sqlreturnvalue == SQLITE_DONE {
                    print("\(tableName) table created.")
                } else {
                    print("\(tableName) table is not created. returnvalue: \(sqlreturnvalue)")
                }
            } else {
                print("\nCREATE TABLE statement is not prepared. returnvalue: \(sqlreturnvalue)")
                returnvalue = false
            }
        }
        sqlite3_finalize(createTableStatement)
        return returnvalue
    }
    
    
    static func dropTable(db: OpaquePointer , tableName : String) -> Bool {
        
        
        var dropTableStatement: OpaquePointer?
        var returnvalue = true
        let dropTableString = "Drop table "+tableName
        var sqlreturnvalue = sqlite3_prepare_v2(db, dropTableString, -1, &dropTableStatement, nil)
        
        if sqlreturnvalue ==
            SQLITE_OK {
            sqlreturnvalue = sqlite3_step(dropTableStatement)
            if sqlreturnvalue == SQLITE_DONE {
                print("\ndrop table execute")
            } else {
                print("\nDrop table is not dropped. return value: \(sqlreturnvalue)")
            }
        } else {
            print("\nDROP TABLE statement is not prepared.return value: \(sqlreturnvalue)")
            returnvalue = false
        }
        
        sqlite3_finalize(dropTableStatement)
        return returnvalue
        
    }
    
    
    
    static func delete(db: OpaquePointer, deleteStatementString: String) -> Bool {
        var deleteStatement: OpaquePointer?
        var returnvalue = true
        var sqlreturnvalue = sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil)
        if sqlreturnvalue == SQLITE_OK {
            sqlreturnvalue = sqlite3_step(deleteStatement)
            if  sqlreturnvalue == SQLITE_DONE {
                print("\nSuccessfully deleted row.")
            } else {
                let errorMessage = String(cString: sqlite3_errmsg(db))
                print("\nQuery is not prepared! \(errorMessage)")
                print("\nCould not delete row. return value: \(sqlreturnvalue)")
            }
            sqlite3_reset(deleteStatement)
        } else {
            print("\nDELETE statement could not be prepared. return value: \(sqlreturnvalue)")
            returnvalue = false
        }
        sqlite3_finalize(deleteStatement)
        return returnvalue
    }
    
    static func query(db: OpaquePointer, queryString : String) -> [[String]] {
        var returnArray = [[String]]()
        var queryStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, queryString,
                              -1,
                              &queryStatement,
                              nil
            ) == SQLITE_OK {
            let columnCount = sqlite3_column_count(queryStatement)
            while (sqlite3_step(queryStatement) == SQLITE_ROW) {
                //            let columnCount = sqlite3_data_count(queryStatement)
                var rowArray = [String]()
                var column:Int32 = 0
                while column < columnCount {
                    let queryResultCol = sqlite3_column_text(queryStatement, column)
                    if queryResultCol != nil {
                        let string = String(cString: sqlite3_column_text(queryStatement, 0))
                        rowArray.append(string)
                    }
                    column = column + 1
                }
                returnArray.append(rowArray)
            }
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
        }
        sqlite3_finalize(queryStatement)
        return returnArray
    }
    static func update(db:OpaquePointer, updateStatementString: String) {
      var updateStatement: OpaquePointer?
      if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) ==
          SQLITE_OK {
        if sqlite3_step(updateStatement) == SQLITE_DONE {
          print("\nSuccessfully updated row.")
        } else {
          print("\nCould not update row.")
        }
      } else {
        print("\nUPDATE statement is not prepared")
      }
      sqlite3_finalize(updateStatement)
    }
}
