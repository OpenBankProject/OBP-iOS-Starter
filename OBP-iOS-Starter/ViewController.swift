//
//  ViewController.swift
//  OBP-iOS-Starter
//
//  Created by Torsten Louland on 09/06/2017.
//  Copyright © 2017 TESOBE Ltd. All rights reserved.
//

import UIKit
import OBPKit

class ViewController: UIViewController {

	@IBOutlet weak var logInOut: UIButton!

	@IBOutlet weak var resultTextView: UITextView!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		syncLogInButton()
		resultTextView.text = ""
		tryoutAPI()
	}

	func syncLogInButton() {
		if let session = OBPSession.current() {
			logInOut.isEnabled = true
			logInOut.setTitle(session.valid ? "Log Out" : "Log In", for: .normal)
		} else {
			logInOut.isEnabled = false
		}
	}

	@IBAction func logInOut(_ sender: UIButton) {
		guard let session = OBPSession.current() else { return }
		switch session.state {
			case .invalid:
				session.validate { (error) in
					self.syncLogInButton()
					if error != nil {
						self.resultTextView.text = "Error: \(error!)"
						return
					}
					self.tryoutAPI()
				}
			case .valid:
				session.invalidate()
				syncLogInButton()
				self.resultTextView.text = ""
			default:
				return
		}
	}

	func tryoutAPI() {
		guard let session = OBPSession.current(), session.valid else { return }

		let resultHandler: HandleOBPMarshalData = { (deserializedObject, body) in
			if let dict = deserializedObject as? NSDictionary {
				self.resultTextView.text = "Result: \(dict.debugDescription)"
			}
		}

		let errorHandler: HandleOBPMarshalError = { (error, path) in
			self.resultTextView.text = "Error: \(error)\nPath: \(path)"
		}

		session.marshal.getResourceAtAPIPath("banks", withOptions: nil, forResultHandler: resultHandler, orErrorHandler: errorHandler)
	}

}

