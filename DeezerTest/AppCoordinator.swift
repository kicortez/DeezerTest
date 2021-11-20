//
//  AppCoordinator.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/20/21.
//

import Foundation
import UIKit

class AppCoordinator {
	
	private weak var window: UIWindow?
	
	init(window: UIWindow) {
		self.window = window
	}
	
	func start() {
		window?.rootViewController = ViewController()
		window?.makeKeyAndVisible()
	}
	
}
