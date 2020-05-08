//
//  Student.swift
//  AttendanceAppKing
//
//  Created by marvin evins on 5/7/20.
//  Copyright © 2020 websavantmedia. All rights reserved.
//

import Foundation

class Student{
    private var _id:String!
    private var _first_name:String!
    private var _last_name:String!
    private var _email:String!
    private var _gender:String!
    private var _tardy:Int! = 0
    private var _absence:Int! = 0
    
    //init getters
    
    var id:String{
           return _id
       }
    
    var first_name: String{
        return _first_name
    }
    
    var last_name: String{
        return _last_name
    }
    
    var email: String{
        return _email
    }
    var gender: String{
        return _gender
    }
    
    init(first_name: String, last_name:String, id:String, email:String, gender:String, tardy:Int, absence:Int  ){
        self._id = id
        self._first_name = first_name
        self._last_name = last_name
        self._email = email
        self._gender = gender
        self._tardy = tardy
        self._absence = absence
        
        
    }
   
    
    

    
}
