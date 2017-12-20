//
//  ViewController.swift
//  ChatApp
//
//  Created by Raul  Canul on 19/12/17.
//  Copyright © 2017 Raul  Canul. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ref =  DatabaseReference.init()
    var userName:String?
    var listOfChatInfo = [Chat]()
    @IBOutlet weak var textChatField: UITextField!
    @IBOutlet weak var chatList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        chatList.delegate = self
        chatList.dataSource = self
        
        loginFirebase()
        self.ref = Database.database().reference()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listOfChatInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellChat:ChatTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellChat", for: indexPath) as! ChatTableViewCell
        
        cellChat.setChat(chat: self.listOfChatInfo[indexPath.row])
        
        return cellChat
    }
    
    func loadChatRoom(){
        self.ref.child("chat").queryOrdered(byChild: "postDate").observe( .value, with: {
            (snapshot) in
                self.listOfChatInfo.removeAll()
            
            if let snapshot = snapshot.children.allObjects as? [DataSnapshot] {
                
                for snap in snapshot {
                    if let postData = snap.value as? [String:AnyObject] {
                        let userName = postData["name"] as? String
                        let text = postData["text"] as? String
                        let postDate = postData["postDate"] as? CLong
                        
                        self.listOfChatInfo.append( Chat(userName: userName!, text: text!, datePost: "\(postDate)") )
                        
                    }
                }
                self.chatList.reloadData()
                let indexPath = IndexPath(row: self.listOfChatInfo.count - 1, section: 0)
                self.chatList.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        })
    }

    func loginFirebase() {
        Auth.auth().signInAnonymously() {
            (user, error) in
            
            if let error = error {
                print("Cannot Login: \(error)")
            } else {
                print("User ID \(user?.uid)")
                self.loadChatRoom()
            }
        }
        
    }
    
    
    @IBAction func sendToRoom(_ sender: Any) {
        // SEND INFO TO FIREBASE DB
        let dictionary = ["text": textChatField.text,
                          "name":  userName!,
                          "postDate": ServerValue.timestamp()] as [String : Any]
        self.ref.child("chat").childByAutoId().setValue(dictionary)
    }
    

}

