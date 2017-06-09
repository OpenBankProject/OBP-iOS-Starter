//
//  AppDelegate.swift
//  OBP-iOS-Starter
//
//  Created by Torsten Louland on 09/06/2017.
//  Copyright © 2017 TESOBE Ltd. All rights reserved.
//

import UIKit
import OBPKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.

		let serverBase = "https://apisandbox.openbankproject.com/obp/v3.0.0/"
		var serverInfo = OBPServerInfo.firstEntry(forAPIServer: serverBase)
		if  serverInfo == nil {
			serverInfo = OBPServerInfo.addEntry(forAPIServer: serverBase)
			serverInfo?.accessData = [
				// ••• Substitute Your App Credentials Here (obtain from <server>/consumer-registration) •••
				// (don't store credentials this way in production)
				OBPServerInfo_APIBase			:	serverBase,
				OBPServerInfo_AuthServerBase	:	"https://apisandbox.openbankproject.com/",
				OBPServerInfo_ClientKey			:	"5d3cgan1likch0zormp1hn400gjm3ofmrjwasqu1", // aka Consumer Key
				OBPServerInfo_ClientSecret		:	"yimcqxhwb04tq4mxbnotwjeckjz4zd2f24ploz3f", // aka Consumer Secret
			]
		}
		if  let si = serverInfo, let session = OBPSession(serverInfo: si) {
			OBPSession.setCurrent(session)
			// uncomment following to use direct login; default is OAuth; both are easy - heavy lifting is done for you.
			// session.authMethod = .directLogin
		}

		return true
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}


}

