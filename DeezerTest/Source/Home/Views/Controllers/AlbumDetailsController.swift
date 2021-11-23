//
//  AlbumDetailsController.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/22/21.
//

import UIKit
import Combine
import Kingfisher

enum AlbumDetailsCollectionDataWrapper: Hashable {
	case track(track: Track)
}

internal typealias AlbumDetailsCollectionDataSource = UICollectionViewDiffableDataSource<Int, AlbumDetailsCollectionDataWrapper>
internal typealias AlbumDetailsCollectionSnapshot = NSDiffableDataSourceSnapshot<Int, AlbumDetailsCollectionDataWrapper>

class AlbumDetailsController: UIViewController {
	
	private lazy var dataSource: AlbumDetailsCollectionDataSource = makeDataSource()

	private lazy var collectionView: UICollectionView = {
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
		
		collectionView.register(cell: TrackCollectionCell.self)
		
		return collectionView
	}()
	
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
	private lazy var releaseDateLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
	private lazy var albumImageView: UIImageView = {
		let imageView = UIImageView()
		return imageView
	}()
	
	weak var delegate: HomeControllerDelegate?
	
	private var data: [AlbumDetailsCollectionDataWrapper] = []
	private var albumViewModel: AlbumViewModel = AlbumViewModel()
	
	private var cancellables: Set<AnyCancellable> = Set()
	
	static func generate(with albumViewModel: AlbumViewModel) -> AlbumDetailsController {
		let controller = AlbumDetailsController()
		controller.albumViewModel = albumViewModel
		
		return controller
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupViews()
		setupSubscribers()
		
		albumViewModel.getAlbumTracks()
	}
	
	private func setupViews() {
		view.backgroundColor = .systemBackground
		
		let mainStackView = UIStackView()
		mainStackView.axis = .vertical
		mainStackView.spacing = 8.0
		
		let topStackView = UIStackView()
		topStackView.axis = .horizontal
		topStackView.spacing = 8.0
		
		let labelStackView = UIStackView()
		labelStackView.axis = .vertical
		labelStackView.spacing = 8.0
		
		labelStackView.addArrangedSubview(titleLabel)
		labelStackView.addArrangedSubview(releaseDateLabel)
		titleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
		
		topStackView.addArrangedSubview(albumImageView)
		topStackView.addArrangedSubview(labelStackView)
		
		mainStackView.addArrangedSubview(topStackView)
		mainStackView.addArrangedSubview(collectionView)
		
		view.addSubview(mainStackView)
		
		mainStackView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		albumImageView.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
		
		NSLayoutConstraint.activate([
			mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
			view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: mainStackView.bottomAnchor),
			
			albumImageView.heightAnchor.constraint(equalToConstant: 100),
			albumImageView.widthAnchor.constraint(equalToConstant: 100),
		])
	}
	
	private func setupSubscribers() {
		albumViewModel
			.$tracklist
			.sink { [weak self] tracks in
				self?.data = tracks.map({ .track(track: $0) })
				self?.applySnapshot()
			}
			.store(in: &cancellables)
		
		albumViewModel
			.$album
			.compactMap({ $0 })
			.map({ AlbumUIModel(with: $0) })
			.sink { [weak self] album in
				self?.titleLabel.text = album.title
				self?.albumImageView.kf.setImage(with: album.coverURL)
				self?.releaseDateLabel.text = album.releaseDate
			}
			.store(in: &cancellables)
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
			
			switch itemIdentifier {
			case .track(let track):
				let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrackCollectionCell.reuseIdentifier, for: indexPath)
				
				if let cell = cell as? TrackCollectionCell {
					cell.configure(with: track.title)
				}
				
				return cell
			}
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
