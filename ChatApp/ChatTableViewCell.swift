//
//  ChatTableViewCell.swift
//  ChatApp
//
//  Created by Raul  Canul on 19/12/17.
//  Copyright © 2017 Raul  Canul. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    
    // MARK: UI Elements
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var textChatLabel: UITextView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setChat(chat:Chat) {
        print("\(chat.text)")
        userNameLabel.text = chat.userName
        textChatLabel.text = chat.text
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
