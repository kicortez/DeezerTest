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

// MARK: - HomeControllerDelegate
extension HomeCoordinator: HomeControllerDelegate {
	func homeController(_ controller: HomeController, didSelectArtist artistViewModel: ArtistViewModel) {
		if let presenter = presenter as? UINavigationController {
			let artistDetailsController = ArtistDetailsController.generate(with: artistViewModel)
			artistDetailsController.delegate = self
			presenter.pushViewController(artistDetailsController, animated: true)
		}
	}
}

// MARK: - ArtistDetailsControllerDelegate
extension HomeCoordinator: ArtistDetailsControllerDelegate {
	func artistDetailsController(_ controller: ArtistDetailsController, didSelectAlbum album: AlbumViewModel) {
		if let presenter = presenter as? UINavigationController {
			let albumDetailsController = AlbumDetailsController.generate(with: album)
			presenter.pushViewController(albumDetailsController, animated: true)
		}
	}
}
