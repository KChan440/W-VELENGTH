//
//  SpotifyManager.swift
//  WVLNGTH
//
//  Created by Spencer Prescott on 7/31/16.
//  Copyright © 2016 WVLNGTH. All rights reserved.
//

import Foundation

class SpotifyManager: NSObject {
    
    class func prepareForLaunch() {
        SPTAuth.defaultInstance().clientID = "168bdd1bac0a4c45b92151f94b2360f7"
        SPTAuth.defaultInstance().redirectURL = NSURL(string: "wvlngth://spotify-login-callback")
        // TODO: Determine auth scopes that we need
        SPTAuth.defaultInstance().requestedScopes = [SPTAuthStreamingScope]
    }
    
    class func authenticate() {
        let authenticationURL = SPTAuth.defaultInstance().loginURL
        if UIApplication.sharedApplication().canOpenURL(authenticationURL) {
            UIApplication.sharedApplication().openURL(authenticationURL)
        } else {
            print("Unable to open url \(authenticationURL.absoluteString)")
        }
    }
    
    class func handleAuthenticationCallbackTriggeredByURL(url: NSURL?) -> Bool {
        guard url != nil
            else { return false }
        if SPTAuth.defaultInstance().canHandleURL(url!) {
            SPTAuth.defaultInstance().handleAuthCallbackWithTriggeredAuthURL(url!, callback: { (error, session) in
                if error != nil {
                    print("Spotify Authentication Error: \(error.debugDescription)")
                    return
                }
                self.loginWithSpotifySession(session)
            })
            return true
        }
        
        return false
    }
    
    private class func loginWithSpotifySession(session: SPTSession) {
        // Initialize Audio Player with new session
        AudioPlayerManager.sharedInstance.startWithAccessToken(session.accessToken)
    }
}
