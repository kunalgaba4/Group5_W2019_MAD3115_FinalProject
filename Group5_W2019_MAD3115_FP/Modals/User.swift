//
//  User.swift
//  Group5_W2019_MAD3115_FP
//
//  Created by Cheeku on 2019-03-16.
//  Copyright © 2019 Cheeku. All rights reserved.
//

import Foundation

class User {
    private var _userID: String!
    private var _name: String!
    private var _email: String!
    private var _profilePicture: String!
    private var _provider: String!
    
    var userID: String {
        return _userID
    }
    var name: String {
        return _name
    }
    var email: String {
        return _email
    }
    var profilePicURL: String {
        return _profilePicture
    }
    var provider: String {
        return _provider
    }
    
    init(name: String, img: String, email: String, provider: String) {
        self._name = name
        self._profilePicture = img
        self._email = email
        self._provider = provider
    }
    
}
