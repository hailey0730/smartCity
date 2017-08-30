//
//  displayViewController.swift
//  smartCity
//
//  Created by AsiaMac on 18/8/2017.
//  Copyright © 2017年 AsiaMac. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class displayViewController: UIViewController {
    @IBOutlet weak var eventTitle: UITextView!
    @IBOutlet weak var eventVenue: UITextView!
    @IBOutlet weak var time: UITextView!
    @IBOutlet weak var speaker: UIImageView!
    @IBOutlet weak var name: UITextView!
    @IBOutlet weak var speakerTitle: UITextView!
    @IBOutlet weak var intro: UITextView!
    @IBOutlet weak var company: UILabel!
    
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        self.displaySpeakerDetail(speakerName: speakerName, eventTopic: eventTopic, eventDate: eventDate, venue: venue, eventTime: eventTime, speakerTitleStr: speakerTitleStr, speakerCompany: speakerCompany, content: content)
        
            var ref: DatabaseReference!
            ref = Database.database().reference().child("Action")
            ref.observe(DataEventType.value, with:{ (snapshot) in
                let postDict = snapshot.value as? [String : AnyObject]
                
                let showSpeaker = postDict?["text"] as! String
                
                if showSpeaker == "show_event_now_action"{
                     self.displayWebPage()
                }else if showSpeaker == "show_agenda_action" || showSpeaker == "show_whattoeat_action"{
                    self.performSegue(withIdentifier: "waitDisplay", sender: self)
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
    
    private func displayWebPage(){
        var ref: DatabaseReference!
        ref = Database.database().reference().child("Agenda").child("robot1")
        ref.observe(DataEventType.value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject]
            let eventName = postDict?["EventName"]
            self.eventTitle.text = eventName as! String!
            
            let eventTime = postDict?["EventTime"]
            self.time.text = eventTime as! String

            let eventVenue = postDict?["EventVenue"] as! String
            let eventDate = postDict?["EventDate"] as! String
            let dateVenue = eventDate + "  |  " + eventVenue
            self.eventVenue.text = dateVenue

            let speakerCompany = postDict?["SpeakerCompany"]
            self.company.text = speakerCompany as! String
            
            let speakerDesc = postDict?["SpeakerDesc"]
            self.intro.text = speakerDesc as! String
            
            let speakerName = postDict?["SpeakerName"]
            self.name.text = speakerName as! String
            
            let speakerPhoto = postDict?["SpeakerPhoto"]
            self.getImage(imgageUrl: speakerPhoto as! String, imgView: self.speaker)
            
            let speakerTitle = postDict?["SpeakerTitle"]
            self.speakerTitle.text = speakerTitle as! String
            
        
        })
        
    }
    
    
    private func displaySpeakerDetail(speakerName: String, eventTopic: String, eventDate: String, venue: String, eventTime: String, speakerTitleStr: String, speakerCompany: String, content: String){
        
        let fileName = speakerName + ".png"
        speaker.image = UIImage(named: fileName)
        speaker.contentMode = UIViewContentMode.scaleAspectFill
        
        let dateVenue = eventDate + " | " + venue
        
        self.eventTitle.text = eventTopic
        self.eventVenue.text = dateVenue
        self.time.text = eventTime
        self.name.text = speakerName
        self.speakerTitle.text = speakerTitleStr
        self.company.text = speakerCompany
        self.intro.text = content
    }
    
        
    private func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    private func getImage(imgageUrl: String, imgView: UIImageView){
        if let checkedUrl = URL(string: imgageUrl ) {
            //            if imgView == self.healthTop{
            //                imgView.contentMode = .scaleAspectFill
            //            }else{
            imgView.contentMode = .scaleAspectFit
            //            }
            self.getDataFromUrl(url: checkedUrl) { (data, response, error)  in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() { () -> Void in
                    imgView.image = UIImage(data: data)
                }
            }
        }
        
    }
        
    @objc private func timeToMoveOn() {
        self.performSegue(withIdentifier: "waitDisplay", sender: self)
        
    }
    

}
