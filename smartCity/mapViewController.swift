//
//  mapViewController.swift
//  smartCity
//
//  Created by AsiaMac on 18/8/2017.
//  Copyright © 2017年 AsiaMac. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class mapViewController: UIViewController {
    @IBOutlet weak var mapView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.displayMap()
        Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(self.timeToMoveOn), userInfo: nil, repeats: false)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //=============================================
    
    private func displayMap(){
        mapView.image = UIImage(named: "iPad Landscape Copy.png")
        mapView.contentMode = UIViewContentMode.scaleAspectFill
       
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.nextPic), userInfo: nil, repeats: false)
        
        
       
    }
    
    @objc private func nextPic(){
            mapView.image = UIImage(named: "iPad Landscape Copy 2-1.png")
            mapView.contentMode = UIViewContentMode.scaleAspectFill
        
        Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.nextPic2), userInfo: nil, repeats: false)
    }
    
    @objc private func nextPic2(){
            mapView.image = UIImage(named: "iPad Landscape Copy 3-1.png")
            mapView.contentMode = UIViewContentMode.scaleAspectFill
        
    }
    
    @objc private func timeToMoveOn() {
        self.performSegue(withIdentifier: "mapToWait", sender: self)
        
    }
    
    
}

