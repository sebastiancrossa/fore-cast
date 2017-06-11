//
//  ViewController.swift
//  SimpleWeather
//
//  Created by Sebastian Crossa on 6/11/17.
//  Copyright © 2017 CROSS-A. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // URL that connects to the API so we can retrieve data
        let url = URL(string: "http://sample.openweathermap.org/data/2.5/weather?q=London,uk&appid=b1b15e88fa797225412429c1c50c122a1")!
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

