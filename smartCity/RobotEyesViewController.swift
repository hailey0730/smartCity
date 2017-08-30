//
//  ViewController.swift
//  smartCity
//
//  Created by AsiaMac on 18/8/2017.
//  Copyright © 2017年 AsiaMac. All rights reserved.
//

import UIKit


class RobotEyesViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.display()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//=============================================
    
    private func display(){
        
//        let url =  URL(string: "http://www.chatbot.hk/tts.clinicbot.php")
        let url = Bundle.main.url(forResource: "robotEyes", withExtension: "html")
        
        self.webView.allowsInlineMediaPlayback = true
        self.webView.mediaPlaybackRequiresUserAction = false
//        self.webView.frame = self.view.bounds
//        self.webView.scalesPageToFit = true
        
        self.webView.loadRequest(URLRequest(url: url!))
            
    }

    

}

