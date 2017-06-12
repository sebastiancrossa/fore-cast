//
//  WeatherViewController.swift
//  SimpleWeather
//
//  Created by Sebastian Crossa on 6/11/17.
//  Copyright © 2017 CROSS-A. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet var userCityInput: UITextField!
    @IBOutlet var forecastTitle: UILabel!
    @IBOutlet var weatherDescription: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Looks for any single taps on screen
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        
        view.addGestureRecognizer(tap)
    }
    
    @IBAction func weatherSearch(_ sender: Any) {
        
        forecastTitle.text = "Today's forecast is:"
        view.endEditing(true)
        
        // URL that connects to the API so we can retrieve data
        // If user does not update the text field we will return an error
        if let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=" + userCityInput.text!.replacingOccurrences(of: " ", with: "%20") + ",uk&appid=5a14e6c17441b978de09f593ee02c8bd") {
        
            // Creating a task for the URL so we can get data from it
            let task = URLSession.shared.dataTask(with: url) {
                data, response, error in
                
                // See if we encounter any error while trying to retrieve the information
                if error == nil {
                    
                    // Variable that has the direct access to the url we are trying to connect to
                    if let contentURL = data {
                        
                        // Processing the JSON retrieved from the weather API
                        do {
                            
                            // Variable that will handles the direct result of the JSON
                            let jsonResult = try JSONSerialization.jsonObject(with: contentURL, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: AnyObject]
                            
                            print(jsonResult)
                            
                            if let description = ((jsonResult["weather"] as? NSArray)?[0] as? NSDictionary)?["description"] as? String {
                                
                                // We dispatch so we don't have to constantly wait
                                DispatchQueue.main.sync(execute: {
                                    
                                    self.weatherDescription.text = description
                                    
                                })
                                
                            }
                            
                        } catch {
                            
                            // Error handling if JSON processing fails
                            print("-- Weather Conditionshas encountered an error while tryiong to proccess the JSON file. (TIP: Double check if you are directing to a JSON file)")
                            
                        }
                        
                    }
                    
                } else {
                    
                    print("-- Weather Conditions has encountered an error : \(error)")
                    
                }
            }
            
            task.resume()
        
        } else {
            
            forecastTitle.text = "City required for search"
            
        }
        
    }
    
    // This function will be called when user taps on screen
    func dismissKeyboard() {
        
        // Will dismiss the keyboard
        view.endEditing(true)
        
    }
    
}
