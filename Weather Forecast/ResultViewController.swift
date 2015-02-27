//
//  ResultViewController.swift
//  Weather Forecast
//
//  Created by Khorhadris Ham on 2015-02-26.
//  Copyright (c) 2015 Khorhadris Ham. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    func ShowError(){
        println("was unable to find result based on the provided input")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = NSURL(string: "http://weather-forecast.com/locations/Toronto/forecasts/latest")

        if url != nil{
            println("Entered here")
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!){
                (data, response, error) in
                
                println("PLEASE WORKWEG@$G)H@#R(J!!!")
                var urlError = false

                if error == nil {
                    var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding)
                    println(urlContent)
                    
                    dispatch_async(dispatch_get_main_queue()){
                        self.webView.loadHTMLString(urlContent, baseURL: nil)
                    }
                    
                }else{
                    urlError = true
                }
                
                if urlError == true{
                    self.ShowError()
                }

            }
            task.resume()
        }else{
            self.ShowError()
        }

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
