//
//  ArtistAlbumsController.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/20/21.
//

import UIKit
import Combine

protocol ArtistDetailsControllerDelegate: AnyObject {
	func artistDetailsController(_ controller: ArtistDetailsController, didSelectAlbum album: AlbumViewModel)
}

class ArtistDetailsController: UIViewController {

	private lazy var dataSource: AlbumControllerCollectionDataSource = makeDataSource()

	private lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
		
		collectionView.register(cell: AlbumCollectionCell.self)
		
		return collectionView
	}()
	
	weak var delegate: ArtistDetailsControllerDelegate?
	
	private var artistViewModel: ArtistViewModel = ArtistViewModel()
	
	private var cancellables: Set<AnyCancellable> = Set()
	
	static func generate(with artistViewModel: ArtistViewModel) -> ArtistDetailsController {
		let controller = ArtistDetailsController()
		controller.artistViewModel = artistViewModel
		
		return controller
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		setupViews()
		setupSubscribers()
		
		artistViewModel.getArtistAlbums()
    }
	
	private func setupViews() {
		view.backgroundColor = .systemBackground
		
		setupCollectionView()
	}
	
	private func setupCollectionView() {
		collectionView.delegate = self
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(collectionView)
		view.pin(collectionView)
	}
	
	private func applySnapshot(data: [ArtistDetailsCollectionDataWrapper]) {
		var snapshot = AlbumControllerCollectionSnapshot()
		
		snapshot.appendSections([1])
		snapshot.appendItems(data)
		
		dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
	}
	
	private func setupSubscribers() {
		artistViewModel
			.$artist
			.map({ $0?.name })
			.sink { [weak self] name in
				self?.title = name
			}
			.store(in: &cancellables)
		
		artistViewModel
			.$collectionData
			.sink { [weak self] data in
				self?.applySnapshot(data: data)
			}
			.store(in: &cancellables)
		
		artistViewModel
			.$selectedAlbumViewModel
			.compactMap({ $0 })
			.sink { [weak self] albumViewModel in
				guard let self = self else { return }
				self.delegate?.artistDetailsController(self, didSelectAlbum: albumViewModel)
			}
			.store(in: &cancellables)
	}
    
}

// MARK: - UICollectionView setup
extension ArtistDetailsController {
	
	private func makeDataSource() -> AlbumControllerCollectionDataSource {
		let source = AlbumControllerCollectionDataSource(collectionView: collectionView, cellProvider: { [weak self] (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
			let cell = self?.artistViewModel.collectionViewCell(collectionView, atIndexPath: indexPath, forItemWithIdentifier: itemIdentifier)
			
			return cell
		})
		
		return source
	}
	
	private func makeLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
			
			return self.buildAlbumsLayout()
		}
		
		return layout
	}
																				 
	// MARK: - Albums Layout
	
	private func buildAlbumsLayout() -> NSCollectionLayoutSection? {
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
											  heightDimension: .fractionalHeight(1.0))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(0.7))
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
		group.interItemSpacing = .fixed(8.0)
		
		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets = NSDirectionalEdgeInsets(top: 8.0,
														leading: 16.0,
														bottom: 8.0,
														trailing: 16.0)
		section.interGroupSpacing = 8.0
		
		return section
	}
	
}

// MARK: - UICollectionViewDelegate
extension ArtistDetailsController: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		guard let dataWrapper = dataSource.itemIdentifier(for: indexPath) else { return }
		
		artistViewModel.didSelectItemWithIdentifier(dataWrapper)
	}
}
