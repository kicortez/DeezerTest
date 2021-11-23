//
//  AlbumDetailsController.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/22/21.
//

import UIKit

enum AlbumDetailsCollectionDataWrapper: Hashable {
	case track(track: Track)
}

internal typealias AlbumDetailsCollectionDataSource = UICollectionViewDiffableDataSource<Int, AlbumDetailsCollectionDataWrapper>
internal typealias AlbumDetailsCollectionSnapshot = NSDiffableDataSourceSnapshot<Int, AlbumDetailsCollectionDataWrapper>

class AlbumDetailsController: UIViewController {

	private var album: Album?
	
	private lazy var dataSource: AlbumDetailsCollectionDataSource = makeDataSource()

	private lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
		
		return collectionView
	}()
	
	weak var delegate: HomeControllerDelegate?
	
	private var data: [AlbumDetailsCollectionDataWrapper] = []
	
	static func generate(with album: Album) -> AlbumDetailsController {
		let controller = AlbumDetailsController()
		controller.album = album
		
		return controller
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViews()
		applySnapshot()
	}
	
	private func setupViews() {
		view.backgroundColor = .white
		
		setupCollectionView()
	}
	
	private func setupCollectionView() {
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(collectionView)
		view.pin(collectionView)
	}
	
	private func applySnapshot() {
		var snapshot = AlbumDetailsCollectionSnapshot()
		
		snapshot.appendSections([1])
		snapshot.appendItems(data)
		
		dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
	}

}

// MARK: - UICollectionView setup
extension AlbumDetailsController {
	
	private func makeDataSource() -> AlbumDetailsCollectionDataSource {
		let source = AlbumDetailsCollectionDataSource(collectionView: collectionView, cellProvider: {
			(collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
			
			return nil
		})
		
		return source
	}
	
	private func makeLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
			
			return self.buildTracksLayout()
		}
		
		return layout
	}
																				 
	// MARK: - Tracks Layout
	
	private func buildTracksLayout() -> NSCollectionLayoutSection? {
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
											  heightDimension: .fractionalHeight(1.0))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(58.0))
		let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
		
		let section = NSCollectionLayoutSection(group: group)
		section.contentInsets = NSDirectionalEdgeInsets(top: 8.0,
														leading: 16.0,
														bottom: 8.0,
														trailing: 16.0)
		section.interGroupSpacing = 8.0
		
		return section
	}
	
}
