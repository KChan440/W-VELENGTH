//
//  Screens.swift
//  WVLNGTH
//
//  Created by Spencer Prescott on 8/3/16.
//  Copyright © 2016 WVLNGTH. All rights reserved.
//

import Foundation

enum Screen: String {
    case AuthenticationScreen = "LoginViewController"
    case OverviewScreen = "OverviewViewController"
}

class Screens: NSObject {
    
    static var screenMapping: [Screen : AnyClass] = [
        .AuthenticationScreen : LoginViewController.self,
        .OverviewScreen : OverviewViewController.self
    ]
    
    class func viewControllerForScreen(screen: Screen) -> ViewController? {
        guard let klass = self.screenMapping[screen]
            else { return nil }
        
        let storyboard = UIStoryboard(name: String(klass), bundle: nil)
        return storyboard.instantiateViewControllerWithIdentifier(String(klass)) as? ViewController
    }

}
