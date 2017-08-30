//
//  whereToEatViewController.swift
//  smartCity
//
//  Created by AsiaMac on 29/8/2017.
//  Copyright © 2017年 AsiaMac. All rights reserved.
//

import Foundation
import Firebase

class whereToEatViewController: UIViewController{
    
    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.scrollView.isScrollEnabled = true
        var ref: DatabaseReference!
        ref = Database.database().reference().child("Action")
        ref.observe(DataEventType.value, with:{ (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject]
            
            let showSpeaker = postDict?["text"] as! String
            
            if showSpeaker == "show_event_now_action" || showSpeaker == "show_agenda_action"{
                self.performSegue(withIdentifier: "eatToWait", sender: self)
            }else{
                Timer.scheduledTimer(timeInterval: 90.0, target: self, selector: #selector(self.timeToMoveOn), userInfo: nil, repeats: false)
            }
        })
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //=============================================
    
    @objc private func timeToMoveOn() {
        self.performSegue(withIdentifier: "eatToWait", sender: self)
        
    }
}
