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
            print("returnValue = \(returnValue)")
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
              print("\nINSERT statement is not prepared.Return value: \(sqlReturnValue)")
              returnValue = false
            }
            // 5
            sqlReturnValue = sqlite3_finalize(insertStatement)
            return returnValue
          }




    static func createTable(db: OpaquePointer , createTableString : String) {
            // 1
            var createTableStatement: OpaquePointer?
            // 2
            if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) ==
                SQLITE_OK {
              // 3
              if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("\nMedicine table created.")
              } else {
                print("\nMedicine table is not created.")
              }
            } else {
              print("\nCREATE TABLE statement is not prepared.")
            }
            // 4
            sqlite3_finalize(createTableStatement)
          }

    static func dropTable(db: OpaquePointer , dropTableString : String) {
      // 1
      var dropTableStatement: OpaquePointer?
      // 2
      if sqlite3_prepare_v2(db, dropTableString, -1, &dropTableStatement, nil) ==
          SQLITE_OK {
        // 3
        if sqlite3_step(dropTableStatement) == SQLITE_DONE {
          print("\ndrop table execute")
        } else {
          print("\nDrop table is not created.")
        }
      } else {
        print("\nDROP TABLE statement is not prepared.")
      }
      // 4
      sqlite3_finalize(dropTableStatement)

    }



    static func delete(db: OpaquePointer, deleteStatementString: String) {
      var deleteStatement: OpaquePointer?
      if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) ==
          SQLITE_OK {
        let retVal = sqlite3_step(deleteStatement)
        if  retVal == SQLITE_DONE {
          print("\nSuccessfully deleted row.")
        } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared! \(errorMessage)")
          print("\nCould not delete row.")
        }
      } else {
        print("\nDELETE statement could not be prepared")
      }
      
      sqlite3_finalize(deleteStatement)
    }
}
