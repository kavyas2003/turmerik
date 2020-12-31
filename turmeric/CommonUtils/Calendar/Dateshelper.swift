//
//  Dateshelper.swift
//  turmeric
//
//  Created by kavya sriram on 9/19/20.
//  Copyright © 2020 kavya sriram. All rights reserved.
//

import Foundation
import SQLite3

class Dateshelper{
    static func createDatesDB() {
        var db : OpaquePointer
        db = DButils.openDatabase()!
        //Don't need this here.
        
       //Create the user table and start with dropping the existing usertable.
       // Check table already exists
       var createTableString = """
       CREATE TABLE Dates(
       day CHAR(255),
       time CHAR(255));
       """

        DButils.createTable(db: db, createTableString: createTableString, tableName: "Dates", forceCreate: false)
    }
    static func DateInsert(day: String, time: String) {
        var insertStatement: OpaquePointer?
      let insertStatementString = "INSERT INTO Dates (day,time) VALUES ('\(day)','\(time)');"
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
}
