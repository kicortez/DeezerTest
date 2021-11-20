//
//  UICollectionView+Extensions.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/20/21.
//

import Foundation
import UIKit

extension UICollectionReusableView {

	static var reuseIdentifier: String {
		return String(describing: self)
	}

}

extension UICollectionView {

	func register<T: UICollectionViewCell>(cell: T.Type) {
		register(cell, forCellWithReuseIdentifier: cell.reuseIdentifier)
	}

}
