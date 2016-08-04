//
//  AudioPlayerManager.swift
//  WVLNGTH
//
//  Created by Spencer Prescott on 7/31/16.
//  Copyright © 2016 WVLNGTH. All rights reserved.
//

import Foundation

class AudioPlayerManager: NSObject, SPTAudioStreamingDelegate {
    static let sharedInstance = AudioPlayerManager()
    
    let player = SPTAudioStreamingController.sharedInstance()
    
    override init() {
        super.init()
        player.delegate = self
    }
    
    /**
     Starts the audio player with Spotify auth token
     
     - parameter token: Spotify Auth Token
     */
    func startWithCurrentSession() {
        do {
            try player.startWithClientId(SPTAuth.defaultInstance().clientID)
            player.loginWithAccessToken(SpotifyAuthenticationManager.currentSession.accessToken)
        } catch {
            print("Falied to start SPTAudioStreamingController with client id")
        }
    }
    
    // MARK: SPTAudioStreamingDelegate
    
    func audioStreamingDidLogin(audioStreaming: SPTAudioStreamingController!) {
  
    }
    
    func audioStreamingDidLogout(audioStreaming: SPTAudioStreamingController!) {

    }
    
}
