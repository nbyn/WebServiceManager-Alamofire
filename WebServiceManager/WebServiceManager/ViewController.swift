//
//  ViewController.swift
//  WebServiceManager
//
//  Created by Malik Wahaj Ahmed on 10/04/2017.
//  Copyright © 2017 Malik Wahaj Ahmed. All rights reserved.
//

import UIKit
import MBProgressHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func getButtonTapped(_ sender: UIButton) {
        
        MBProgressHUD.showAdded(to: view, animated: true)
        WebServiceManager.sharedInstance.getRequest(
            urlString: WebServiceManager.kBaseURL + "posts",
            completionHandler: { response, error in
        
            MBProgressHUD.hide(for: self.view, animated: true)
            if error != nil {
                print(error?.localizedDescription ?? "Error")
            }
            else {
                print(response ?? "Nil Response")
            }
        })
    }
    
    @IBAction func postButtonTapped(_ sender: UIButton) {
        
        let params = ["title":"foo", "body":"bar","id":"1"]
        
        MBProgressHUD.showAdded(to: view, animated: true)
        WebServiceManager.sharedInstance.postRequest(
            urlString: WebServiceManager.kBaseURL + "posts",
            paramDict: params as [String : AnyObject]?,
            completionHandler: { response, error in
            
            MBProgressHUD.hide(for: self.view, animated: true)
            if error != nil {
                print(error?.localizedDescription ?? "Error")
            }
            else {
                print(response ?? "Nil Response")
            }
        })
    }
}

