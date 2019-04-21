//
//  Configuration.swift
//  NovaTools
//
//  Created by Clayton Oliveira on 20/08/2018.
//  Copyright © 2018 Clayton Oliveira. All rights reserved.
//

import Foundation

enum UserDefaultsKeys: String {
    case userLoged = "userLoged"
    case userPassword = "userPassword"
    case userTypeAprov = "userTypeAprov"
    case userToken = "userToken"
}

class Configuration {
    let defaults = UserDefaults.standard
    static var shared: Configuration = Configuration()
    
    func Logout() {
        
        defaults.set("", forKey: UserDefaultsKeys.userLoged.rawValue)
        defaults.set("", forKey: UserDefaultsKeys.userPassword.rawValue)
        defaults.set("", forKey: UserDefaultsKeys.userTypeAprov.rawValue)
        defaults.set("", forKey: UserDefaultsKeys.userToken.rawValue)
        
    }
    
    var User: String {
        get {
            if let usr = defaults.string(forKey: UserDefaultsKeys.userLoged.rawValue) {
                return usr
            }
            else
            {
                return ""
            }
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.userLoged.rawValue)
        }
    }
    
    var Password: String {
        get {
            if let pass = defaults.string(forKey: UserDefaultsKeys.userPassword.rawValue) {
                return pass
            }
            else
            {
                return ""
            }
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.userPassword.rawValue)
        }
    }
    
    var TipoAprovacao: String {
        get {
            if let pass = defaults.string(forKey: UserDefaultsKeys.userPassword.rawValue) {
                return pass
            }
            else
            {
                return ""
            }
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.userPassword.rawValue)
        }
    }
    var TokenAPI: String {
        get {
            if let tok = defaults.string(forKey: UserDefaultsKeys.userToken.rawValue) {
                return tok
            }
            else
            {
                return ""
            }
        }
        set {
            defaults.set(newValue, forKey: UserDefaultsKeys.userToken.rawValue)
        }
    }
    
    private init() {
        
    }
}
