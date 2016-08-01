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
    
    var isLoggedIn: Bool = false
    
    override init() {
        super.init()
        player.delegate = self
    }
    
    func startWithAccessToken(token: String!) {
        do {
            try player.startWithClientId("168bdd1bac0a4c45b92151f94b2360f7")
            player.loginWithAccessToken(token)
        } catch {
            print("Falied to start SPTAudioStreamingController with client id")
        }
    }
    
    // MARK: SPTAudioStreamingDelegate
    
    func audioStreamingDidLogin(audioStreaming: SPTAudioStreamingController!) {
        isLoggedIn = true
    }
    
    func audioStreamingDidLogout(audioStreaming: SPTAudioStreamingController!) {
        isLoggedIn = false
    }
    
}
