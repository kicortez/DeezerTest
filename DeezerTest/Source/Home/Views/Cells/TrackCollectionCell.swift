//
//  TrackCollectionCell.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/23/21.
//

import UIKit

class TrackCollectionCell: UICollectionViewCell {
    
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		
		return label
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
		
		stackView.addArrangedSubview(titleLabel)
		
		contentView.addSubview(stackView)
		contentView.pin(stackView)
	}
	
	func configure(with text: String) {
		titleLabel.text = text
	}
	
}
