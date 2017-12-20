//
//  Chat.swift
//  ChatApp
//
//  Created by Raul  Canul on 19/12/17.
//  Copyright © 2017 Raul  Canul. All rights reserved.
//

import UIKit

class Chat: NSObject {
    var userName:String?
    var text:String?
    var datePost: String?
    
    init( userName:String, text:String,  datePost: String) {
        self.userName = userName
        self.text = text
        self.datePost = datePost
    }
}
