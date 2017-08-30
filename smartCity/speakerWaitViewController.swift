//
//  speakerWaitViewController.swift
//  smartCity
//
//  Created by AsiaMac on 25/8/2017.
//  Copyright © 2017年 AsiaMac. All rights reserved.
//

import Foundation
import Firebase
import UIKit


class speakerWaitViewController: UIViewController {
    
    @IBOutlet weak var message: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.displayMessage()
        self.loopCheck()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //=============================================
    private func displayMessage(){
        
        var ref: DatabaseReference!
        ref = Database.database().reference().child("Message")
        ref.observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject]
            
            let showMessage = postDict?["text"] as! String
            
            self.message.text = showMessage
        })
    }
    
    private func loopCheck(){
        var ref: DatabaseReference!
        ref = Database.database().reference().child("Action")
        ref.observe(DataEventType.value, with:{ (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject]
            
            let showSpeaker = postDict?["text"] as! String
            
            if showSpeaker == "show_event_now_action"{
                 self.performSegue(withIdentifier: "waitToSpeaker", sender: self)
            }else if showSpeaker == "show_agenda_action"{
                print("agenda")
                self.performSegue(withIdentifier: "waitToAgenda", sender: self)
            }else if showSpeaker == "show_whattoeat_action" {
                self.performSegue(withIdentifier: "waitToEat", sender: self)
            }
        })

    }
}
