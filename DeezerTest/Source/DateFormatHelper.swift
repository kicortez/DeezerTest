//
//  DateFormatHelper.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/23/21.
//

import Foundation

class DateFormatHelper{

	private let dateFormatter = DateFormatter()
	
	static let shared: DateFormatHelper = DateFormatHelper()

	func date(from string: String, format: String) -> Date? {
		dateFormatter.dateFormat = format
		return dateFormatter.date(from: string)
	}
	
	func string(from date: Date, format: String) -> String {
		dateFormatter.dateFormat = format
		return dateFormatter.string(from: date)
	}
	
}
	
