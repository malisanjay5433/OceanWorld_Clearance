//
//  UserDefault.swift
//  OceanWorld_Clearance
//
//  Created by Sanjay Mali on 12/02/18.
//  Copyright © 2018 Sanjay Mali. All rights reserved.
//

import Foundation
import UIKit
let isLogeddIN = "isLoggedIn"
let isLogeddOUT = "isLogeddOUT"
let UserInfo = "userInfo"

class UserDefaultDetails{
    var userdefault = UserDefaults()
    func  saveUserDetails(dic:[String:String]) {
        userdefault.set(dic, forKey:UserInfo)
        print(dic)
        userdefault.synchronize()
    }
    func loggedIN(){
        userdefault.set(true, forKey:isLogeddIN)
        userdefault.synchronize()
        
    }
    
    func loggedOUT(){
        userdefault.set(false, forKey:isLogeddOUT)
        userdefault.synchronize()
    }
    
    
    func isloggedIn() ->Bool{
        let isloggedIn = userdefault.value(forKey:isLogeddIN)
        return (isloggedIn != nil)
        
    }
    func isloggedOut() ->Bool{
        let isloggedOut = userdefault.value(forKey:isLogeddOUT)
        return (isloggedOut != nil)
    }
    
    func getUserDetails() ->[String:String]{
        let userInfo = userdefault.value(forKey:UserInfo)
        return userInfo as! [String : String]
    }
}
