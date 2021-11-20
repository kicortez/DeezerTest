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
	private var albumsCoordinator: ArtistAlbumCoordinator?
	
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
	
	func homeController(_ controller: HomeController, didSelectArtist artist: Int) {
		if let presenter = presenter as? UINavigationController {
			let coordinator = ArtistAlbumCoordinator(presenter: presenter)
			coordinator.start()
		
			albumsCoordinator = coordinator
		}
		
	}
	
}
