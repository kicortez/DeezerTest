//
//  HomeController.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/20/21.
//

import UIKit

internal typealias HomeControllerCollectionDataSource = UICollectionViewDiffableDataSource<Int, Int>
internal typealias HomeControllerCollectionSnapshot = NSDiffableDataSourceSnapshot<Int, Int>

protocol HomeControllerDelegate: AnyObject {
	// Dummy
	func homeController(_ controller: HomeController, didSelectArtist artist: Int)
}

class HomeController: UIViewController {
	
	private let searchController = UISearchController(searchResultsController: nil)
	
	private lazy var dataSource: HomeControllerCollectionDataSource = makeDataSource()

	private lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
		
		collectionView.register(cell: ArtistsCollectionCell.self)
		
		return collectionView
	}()
	
	weak var delegate: HomeControllerDelegate?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		setupViews()
		applySnapshot()
    }
	
	private func setupViews() {
		view.backgroundColor = .white
		
		setupCollectionView()
		setupSearch()
	}
	
	private func setupSearch() {
		searchController.obscuresBackgroundDuringPresentation = false
		searchController.hidesNavigationBarDuringPresentation = false
		searchController.searchBar.placeholder = "Search"
		
		definesPresentationContext = true
		
		navigationItem.titleView = searchController.searchBar
	}
	
	private func setupCollectionView() {
		collectionView.delegate = self
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(collectionView)
		view.pin(collectionView)
	}
	
	private func applySnapshot() {
		var snapshot = HomeControllerCollectionSnapshot()
		
		// Dummy
		snapshot.appendSections([1])
		snapshot.appendItems([1,2,3,4,5])
		
		dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
	}

}

// MARK: - UICollectionView setup
extension HomeController {
	
	private func makeDataSource() -> HomeControllerCollectionDataSource {
		let source = HomeControllerCollectionDataSource(collectionView: collectionView, cellProvider: {
			(collectionView, indexPath, itemIdentifier) -> UICollectionViewCell? in
			
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistsCollectionCell.reuseIdentifier, for: indexPath)
			
			cell.backgroundColor = .tertiarySystemGroupedBackground
			
			return cell
		})
		
		return source
	}
	
	private func makeLayout() -> UICollectionViewLayout {
		let layout = UICollectionViewCompositionalLayout { (section: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
			
			return self.buildArtistsLayout()
		}
		
		return layout
	}
																				 
	// MARK: - Artists Layout
	
	private func buildArtistsLayout() -> NSCollectionLayoutSection? {
		let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
											  heightDimension: .fractionalHeight(1.0))
		let item = NSCollectionLayoutItem(layoutSize: itemSize)
		
		let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80.0))
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

// MARK: - UICollectionViewDelegate
extension HomeController: UICollectionViewDelegate {
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		delegate?.homeController(self, didSelectArtist: indexPath.item)
	}
	
}
