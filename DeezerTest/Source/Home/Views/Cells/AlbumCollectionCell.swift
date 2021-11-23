//
//  AlbumCollectionCell.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/22/21.
//

import UIKit
import Kingfisher

class AlbumCollectionCell: UICollectionViewCell {
    
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.numberOfLines = 2
		
		return label
	}()
	
	private lazy var imageView: UIImageView = {
		let imageView = UIImageView()
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
		stackView.axis = .vertical
		stackView.spacing = 8.0
		stackView.alignment = .fill
		
		stackView.translatesAutoresizingMaskIntoConstraints = false
		imageView.translatesAutoresizingMaskIntoConstraints = false
		
		stackView.addArrangedSubview(imageView)
		
		let hStackView = UIStackView()
		hStackView.axis = .horizontal
		hStackView.alignment = .top
		
		hStackView.addArrangedSubview(titleLabel)
		stackView.addArrangedSubview(hStackView)
		
		contentView.addSubview(stackView)
		contentView.pin(stackView)
		
		NSLayoutConstraint.activate([
			imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
		])
	}
	
	func configure(with text: String, imageURL: URL) {
		titleLabel.text = text
		imageView.kf.setImage(with: imageURL)
	}
	
}
