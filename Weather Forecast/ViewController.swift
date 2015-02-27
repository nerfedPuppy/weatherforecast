//
//  ViewController.swift
//  Weather Forecast
//
//  Created by Khorhadris Ham on 2015-02-26.
//  Copyright (c) 2015 Khorhadris Ham. All rights reserved.
//

import UIKit

var locName:String!
class ViewController: UIViewController {

    //var locName:String!

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var inputText: UITextField!
    @IBAction func serachButton(sender: AnyObject) {
        if inputText.text == ""{
            println("Please enter a valid city or country name and press Search! button")
        }else{
            locName = inputText.text
            println("searching for \(locName)")
        }
    }
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var url = NSURL(string: "http://weather-forecast.com/locations/Toronto/forecasts/latest")
        var weather = ""
        if url != nil {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
                var urlError = false
                if error == nil{
                    var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding) as NSString!
                    var urlContentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
                    
                    if urlContentArray.count > 0{
                        var weatherArray = urlContentArray[1].componentsSeparatedByString("</span>")
                        var weather = weatherArray[0] as String
                        println(weather)
                    }else{
                        urlError = true
                    }
                }else{
                    urlError = true
                }
                
                dispatch_async(dispatch_get_main_queue()){
                    if urlError == true{
                        //do something
                    }else{
                        println(weather)
                        self.resultLabel.text = weather
                    }
                }
                
            })
            task.resume()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

