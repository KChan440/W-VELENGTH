//
//  OverviewViewController.swift
//  WVLNGTH
//
//  Created by Spencer Prescott on 8/3/16.
//  Copyright © 2016 WVLNGTH. All rights reserved.
//

import UIKit

class OverviewViewController: ViewController {
    override var screenName: Screen? {
        get {
            return .OverviewScreen
        }
    }
    
    @IBAction func logoutButtonTapped(sender: UIButton) {
        SpotifyAuthenticationManager.logout()
    }
}
