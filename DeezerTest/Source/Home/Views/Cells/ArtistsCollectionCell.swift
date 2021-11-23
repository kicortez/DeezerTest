//
//  TopArtistsCollectionCell.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/20/21.
//

import UIKit
import Kingfisher

class ArtistsCollectionCell: UICollectionViewCell {
	
	private lazy var nameLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 2
		
		return label
	}()
	
	private lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		return imageView
	}()
	
	private lazy var disclosureImageView: UIImageView = {
		let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		
		setupViews()
	}
	
	private func setupViews() {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = 8.0
		stackView.alignment = .center
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		
		stackView.addArrangedSubview(imageView)
		stackView.addArrangedSubview(nameLabel)
		stackView.addArrangedSubview(disclosureImageView)
		
		contentView.addSubview(stackView)
		contentView.pin(stackView)
		
		NSLayoutConstraint.activate([
			imageView.heightAnchor.constraint(equalToConstant: 50),
			imageView.widthAnchor.constraint(equalToConstant: 50),
			disclosureImageView.heightAnchor.constraint(equalToConstant: 16),
			disclosureImageView.widthAnchor.constraint(equalToConstant: 16),
		])
	}
	
	func configure(with text: String, imageURL: URL) {
		nameLabel.text = text
		imageView.kf.setImage(with: imageURL)
	}
	
}
