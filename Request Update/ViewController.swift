//
//  ViewController.swift
//  Request Update
//
//  Created by Drew Westcott on 18/01/2017.
//  Copyright © 2017 Drew Westcott. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
	
	@IBOutlet weak var textLabel: UILabel!
	@IBOutlet weak var responseLabel: UILabel!
	
		override func viewDidLoad() {
			super.viewDidLoad()
			
			if (WCSession.isSupported()) {
				let watchSession = WCSession.default()
				watchSession.delegate = self
				watchSession.activate()
				print("Activated")
			}
			
		}
		
		override func didReceiveMemoryWarning() {
			super.didReceiveMemoryWarning()
			// Dispose of any resources that can be recreated.
		}
		
		func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
			
			if let watchMessage = applicationContext["watchMessage"] {
				
				print(watchMessage)
				
			}
		}
		
		func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
			
			print("Activated")
			
		}
		
		func sessionDidBecomeInactive(_ session: WCSession) {
			
			print("Session Inactive")
			
		}
		
		func sessionDidDeactivate(_ session: WCSession) {
			
			print("Session deactivated")
			
		}
		
		@IBAction func requestUpdate(_ sender: Any) {
			
			let message = ["Message":"needUpdate"]
			WCSession.default().sendMessage(message, replyHandler: nil, errorHandler: nil)
		}
	
	func waitingForUpdate() {
		textLabel.text = "Waiting for reply…"
	}
	
	func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
		
		if let fuel = message["fuel"] as? String {
			if fuel == "cookie" {
				responseLabel.text = "🍪"
			}
			if fuel == "coffee" {
				responseLabel.text = "☕️"
			}
			if fuel == "pizza" {
				responseLabel.text = "🍕"
			}
		}
		textLabel.text = ""
	}
}
