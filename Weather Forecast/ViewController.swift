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

    var weather = ""
    //var urlString:String = ""

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
    
    @IBAction func quickSearchButton(sender: AnyObject) {
        var url = NSURL(string: "http://weather-forecast.com/locations/Toronto/forecasts/latest")
        if(inputText != nil){
            println("input text is: \(inputText.text)")
            var urlString: String = "http://weather-forecast.com/locations/replace/forecasts/latest"
            var urlStringArray = urlString.componentsSeparatedByString("/")
            urlStringArray[4] = inputText.text
            urlString = "/".join(urlStringArray)
            println(urlString)
            println("test for commmiting")
            url = NSURL(string:urlString)
            println(url)
        }
        
        if url != nil {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
                var urlError = false
                if error == nil{
                    var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding) as NSString!
                    var urlContentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
                    
                    if urlContentArray.count > 0{
                        var weatherArray = urlContentArray[1].componentsSeparatedByString("</span>")
                        self.weather = weatherArray[0] as String
                        println(self.weather)
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
                        println("uhoh \(self.weather)")
                        self.resultLabel.text = self.weather
                    }
                }
            })
            task.resume()
        }
        
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

