//
//  SelectUserViewController.swift
//  SnapChat
//
//  Created by Morgan Hondros on 1/8/19.
//  Copyright © 2019 Morgan Hondros. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase



class SelectUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var users : [User] = []
    
    var imageURL = ""
    var descrip = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        Database.database().reference().child("users").observe(DataEventType.childAdded) { (snapshot) in
            print(snapshot)
            
            let user = User()
//            user.email = snapshot.value!("email") as! String
            user.email = (snapshot.value as! NSDictionary)["email"] as! String
            user.uid = snapshot.key
            
            self.users.append(user)
            self.tableView.reloadData()
            
        }
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let user = users[indexPath.row]
        cell.textLabel?.text = user.email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        
        let snap = ["from":user.email, "description":descrip, "imageURL":imageURL]
        
        Database.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
    }


}
