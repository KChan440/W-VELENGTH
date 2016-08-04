//
//  SpotifyAuthenticationManager.swift
//  WVLNGTH
//
//  Created by Spencer Prescott on 7/31/16.
//  Copyright © 2016 WVLNGTH. All rights reserved.
//

import Foundation

class SpotifyAuthenticationManager: NSObject {
    
    static var currentSession: SPTSession! {
        get {
            return SPTAuth.defaultInstance().session
        }
    }
    
    static var isValidSession: Bool {
        get {
            return NSUserDefaults.standardUserDefaults().objectForKey(SPTAuth.defaultInstance().sessionUserDefaultsKey) != nil
        }
    }
    
    /**
     Called on lauch to set up constants used in authenticating with Spotify
     */
    class func prepareForLaunch() {
        SPTAuth.defaultInstance().clientID = "168bdd1bac0a4c45b92151f94b2360f7"
        SPTAuth.defaultInstance().sessionUserDefaultsKey = "SpotifySessionKey"
        SPTAuth.defaultInstance().redirectURL = NSURL(string: "wvlngth://spotify-login-callback")
        // TODO: Determine auth scopes that we need
        SPTAuth.defaultInstance().requestedScopes = [SPTAuthStreamingScope]
    }
    
    /**
     Prompts the user to authenticate with Spotify
     */
    class func authenticate() {
        let authenticationURL = SPTAuth.defaultInstance().loginURL
        if UIApplication.sharedApplication().canOpenURL(authenticationURL) {
            UIApplication.sharedApplication().openURL(authenticationURL)
        } else {
            print("Unable to open url \(authenticationURL.absoluteString)")
        }
    }
    
    /**
     Log user out and clear all session data
     */
    class func logout() {
        if (AudioPlayerManager.sharedInstance.player.loggedIn) {
            AudioPlayerManager.sharedInstance.player.logout()
        }
        NSUserDefaults.standardUserDefaults().removeObjectForKey(SPTAuth.defaultInstance().sessionUserDefaultsKey)
        Router.sharedInstance.resetNavigationStackWithScreen(.AuthenticationScreen)
    }
    
    /**
     AppDelegate calls this method when it opens Spotify OAuth in Safari
     
     - parameter url: Deeplink url
     
     - returns: if the url should be opened
     */
    class func handleAuthenticationCallbackTriggeredByURL(url: NSURL?) -> Bool {
        guard url != nil
            else { return false }
        if SPTAuth.defaultInstance().canHandleURL(url!) {
            SPTAuth.defaultInstance().handleAuthCallbackWithTriggeredAuthURL(url!, callback: { (error, session) in
                if error != nil {
                    print("Spotify Authentication Error: \(error.debugDescription)")
                    return
                }
                Router.sharedInstance.resetNavigationStackWithScreen(.OverviewScreen)
            })
            return true
        }
        
        return false
    }
}
