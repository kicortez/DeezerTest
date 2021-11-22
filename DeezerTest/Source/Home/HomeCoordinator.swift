//
//  HomeCoordinator.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/20/21.
//

import Foundation
import UIKit

class HomeCoordinator {
	
	private weak var presenter: UIViewController?
	
	init(presenter: UINavigationController) {
		self.presenter = presenter
	}
	
	func start() {
		let homeController = HomeController()
		homeController.delegate = self
		
		if let presenter = presenter as? UINavigationController {
			presenter.setViewControllers([homeController], animated: false)
		}
	}
	
}

extension HomeCoordinator: HomeControllerDelegate {
	
	func homeController(_ controller: HomeController, didSelectArtist artist: Artist) {
		if let presenter = presenter as? UINavigationController {
			let albumsController = ArtistDetailsController.generate(with: artist)
			presenter.pushViewController(albumsController, animated: true)
		}
		
	}
	
}
