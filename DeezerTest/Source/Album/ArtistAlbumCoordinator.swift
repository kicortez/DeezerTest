//
//  ArtistAlbumCoordinator.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/20/21.
//

import Foundation
import UIKit

class ArtistAlbumCoordinator {
	
	private weak var presenter: UIViewController?
	
	init(presenter: UINavigationController) {
		self.presenter = presenter
	}
	
	func start() {
		let controller = ArtistAlbumsController()
		
		if let presenter = presenter as? UINavigationController {
			presenter.pushViewController(controller, animated: true)
		}
	}
	
}
