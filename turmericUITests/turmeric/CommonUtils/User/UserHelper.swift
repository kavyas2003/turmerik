//
//  UserHelper.swift
//  turmeric
//
//  Created by kavya sriram on 8/14/20.
//  Copyright ©️ 2020 kavya sriram. All rights reserved.
//

import Foundation
import SQLite3

class UserHelper {
  static func UserInsert(name: NSString, username: NSString, password: NSString, email: NSString) {
    var insertStatement: OpaquePointer?
  let insertStatementString = "INSERT INTO User (name, username, password, email) VALUES ('\(name)','\(username)','\(password)','\(email)');"
  var db : OpaquePointer
    db = DButils.openDatabase()!


  // 1
  if (sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK) {
      let retVal = sqlite3_step(insertStatement)
      if retVal == SQLITE_DONE {
          print("\nSuccessfully inserted row.")
      }
      else {
          print("\nCould not insert row.")
      }
      sqlite3_reset(insertStatement)
  }
  else {
    print("\nINSERT statement is not prepared.")
  }
  // 5
  sqlite3_finalize(insertStatement)

}
    
    static func UserQuery(username: String) -> String? {
 //       let queryStatementString = " SELECT * FROM User where username like '%\(username)%'"
        let queryStatementString = " SELECT * FROM User "
        var queryStatement: OpaquePointer?
        var user = ""
        var db : OpaquePointer
        db = DButils.openDatabase()!
      if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
        print("\n")
        while (sqlite3_step(queryStatement) == SQLITE_ROW) {
          guard let queryResultCol0 = sqlite3_column_text(queryStatement, 0) else {
            print("Query result is nil.")
            return nil
          }
            guard let queryResultCol1 = sqlite3_column_text(queryStatement, 1) else{
                return nil
            }
            guard let queryResultCol2 = sqlite3_column_text(queryStatement, 2) else{
                return nil
            }
            guard let queryResultCol3 = sqlite3_column_text(queryStatement, 3) else {
                return nil
            }
         let name = String(cString: queryResultCol0)
         let username = String(cString: queryResultCol1)
         let password = String(cString: queryResultCol2)
         let email = String(cString: queryResultCol3)

          print("Query Result:")
          print("user:\(name), \(username), \(password), \(email)")
          user = ("\(name), \(username), \(password), \(email)")
 //         return user
        }
        } else {
          let errorMessage = String(cString: sqlite3_errmsg(db))
          print("\nQuery is not prepared \(errorMessage)")
      }
      sqlite3_finalize(queryStatement)
      return user
    }
    
    static func getUser(username: String) -> User
    {
        
        let userinfo = UserQuery(username: username)
        let user = userinfo!.components(separatedBy: ", ")
        print("userinfo: \(String(describing: userinfo))")
        let nameVal = user[0]
        let usernameVal = user[1]
        let passwordVal = user[2]
        let emailVal = user[3]
        let finaluser = User(name:nameVal, username:usernameVal, password:passwordVal, email:emailVal)
        //let password = userinfo[2]
       // print("password \(password)")
        return finaluser
        
    }
}



