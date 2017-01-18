//
//  InterfaceController.swift
//  Request Update WatchKit Extension
//
//  Created by Drew Westcott on 18/01/2017.
//  Copyright © 2017 Drew Westcott. All rights reserved.
//

import WatchKit
import WatchConnectivity


class InterfaceController: WKInterfaceController, WCSessionDelegate {

	@IBOutlet var fuelSelectedLabel: WKInterfaceLabel!
	var currentFuel = ""
	let localStorage = UserDefaults.standard
	
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
		
		if let fuel = localStorage.string(forKey: "fuel") {
			currentFuel = fuel
			if currentFuel == "cookie" {
				fuelSelectedLabel.setText("🍪")
			}
			if currentFuel == "coffee" {
				fuelSelectedLabel.setText("☕️")
			}
			if currentFuel == "pizza" {
				fuelSelectedLabel.setText("🍕")
			}
		}
	}
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
		if WCSession.isSupported() {
			let session = WCSession.default()
			session.delegate = self
			session.activate()
			print("watch activitaed")
		}
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

	@IBAction func coffeeTapped() {
		fuelSelectedLabel.setText("☕️")
		currentFuel = "coffee"
		localStorage.set("coffee", forKey: "fuel")
	}

	@IBAction func cookieTapped() {
		fuelSelectedLabel.setText("🍪")
		currentFuel = "cookie"
		localStorage.set("cookie", forKey: "fuel")
	}

	@IBAction func pizzaTapped() {
		fuelSelectedLabel.setText("🍕")
		currentFuel = "pizza"
		localStorage.set("pizza", forKey: "fuel")
	}
	
	func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
		
		
	}
	
	func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
		WKInterfaceDevice().play(.notification)
		let messagetype = message["Message"] as? String
		if messagetype == "needUpdate" {
			sendReply()
		}
	}
	
	func sendReply() {
		
		let message = ["fuel":currentFuel]
		print("Sent \(currentFuel)")
		WCSession.default().sendMessage(message, replyHandler: nil, errorHandler: nil)
		print("message sent")
	}
}
