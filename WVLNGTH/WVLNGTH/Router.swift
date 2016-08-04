//
//  Router.swift
//  WVLNGTH
//
//  Created by Spencer Prescott on 8/3/16.
//  Copyright © 2016 WVLNGTH. All rights reserved.
//

import Foundation

class Router: NSObject {
    static let sharedInstance = Router()
    
    let navigationController = UINavigationController()
    
    /**
     Returns the initial window of the app
     
     - returns: UIWindow to show on app
     */
    func prepareToLaunch() -> UIWindow {
        let window = UIWindow(frame: UIScreen.mainScreen().bounds)
        navigationController.viewControllers = [Screens.viewControllerForScreen(SpotifyAuthenticationManager.isValidSession ? .OverviewScreen : .AuthenticationScreen)!]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        return window
    }
    
    func pushToScreen(screen: Screen, animated: Bool) {
        let viewController = Screens.viewControllerForScreen(screen)
        assert(viewController != nil, "Set \(screen.rawValue) as the screenName on the view controller you are pushing to.")
        navigationController.pushViewController(viewController!, animated: animated)
    }
    
    func presentScreenEmbededInNavigationController(screen: Screen, animated: Bool) {
        let viewController = Screens.viewControllerForScreen(screen)
        assert(viewController != nil, "Set \(screen.rawValue) as the screenName on the view controller you are pushing to.")
        navigationController.presentViewController(UINavigationController(rootViewController: viewController!), animated: animated, completion: nil)
    }
    
    func presentScreen(screen: Screen, animated: Bool) {
        let viewController = Screens.viewControllerForScreen(screen)
        assert(viewController != nil, "Set \(screen.rawValue) as the screenName on the view controller you are pushing to.")
        navigationController.presentViewController(viewController!, animated: animated, completion: nil)
    }
    
    func popCurrentScreen(animated: Bool) {
        navigationController.popViewControllerAnimated(animated)
    }
    
    func dismissPresentedScreen(animated: Bool) {
        // TODO: Think about this more as it might not work
        navigationController.dismissViewControllerAnimated(animated, completion: nil)
    }
    
    func resetNavigationStackWithScreen(screen: Screen) {
        let viewController = Screens.viewControllerForScreen(screen)
        assert(viewController != nil, "Set \(screen.rawValue) as the screenName on the view controller you are pushing to.")
        navigationController.viewControllers = [viewController!]
    }
}
