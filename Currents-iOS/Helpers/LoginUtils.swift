//
//  Utils.swift
//  Currents-iOS
//
//  Created by Ethan Hu on 4/18/18.
//  Copyright © 2018 CUSD Currents. All rights reserved.
//

import Foundation

//This class provides some utility functions that might be accessed from the entire app for user login.
class LoginUtils {
    
    private static let userIdentifierKeyInDefaults = "userIdentifier"
    private static let usernameKeyInDefaults = "username"
    
    /*
     * The authentication function for the user login.
     * - username: the username to be authenticated
     * - password: the password to be authenticated
     * - Returns: a unique device identifier from the server if this (username, password) pair passes
     * server authentication. Nil if the identification failed. The benefit of this is that this
     * unique identifier can be provided each time to the server so that the user won't have to re-login.
     */
    static func auth(username:String, password:String) -> String? {
        //authentication here, for now placeholder auth is used
        if username == "test" && password == "test" {
            return "ABCDEF"
        }
        else {
            return nil
        }
    }
    
    /*
     * Saves the user name and unique identifier (idealy provided by the auth function) to userdefaults
     * - username: the username to be saved
     * - identifier: the unique identifier to be saved.
     */
    static func saveUniqueUserInfoToDefaults(username:String, identifier: String) {
        let defaults = UserDefaults.standard
        defaults.set(identifier, forKey: userIdentifierKeyInDefaults)
        defaults.set(username, forKey: usernameKeyInDefaults)
    }
    
    /*
     * Communicate with the server by sending the (username, userIdentifier) pair.
     * If the server recognize this pair, then the user won't have to re-login.
     */
    static func loginRequired() -> Bool {
        let defaults = UserDefaults.standard
        if let username = defaults.object(forKey: usernameKeyInDefaults) as? String
           ,let userIdentifier = defaults.object(forKey: userIdentifierKeyInDefaults) as? String{
            //do server identification here
            if username == "test" && userIdentifier == "ABCDEF" {
                return false
            }
        }
        return true
    }
    
    
}
