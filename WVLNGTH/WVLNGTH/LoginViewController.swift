//
//  LoginViewController.swift
//  WVLNGTH
//
//  Created by Spencer Prescott on 7/30/16.
//  Copyright © 2016 WVLNGTH. All rights reserved.
//

import UIKit

class LoginViewController: ViewController {
    
    override var screenName: Screen? {
        get {
            return .AuthenticationScreen
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonTapped(sender: UIButton) {
        SpotifyAuthenticationManager.authenticate()
    }

}

