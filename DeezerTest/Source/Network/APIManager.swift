//
//  APIManager.swift
//  DeezerTest
//
//  Created by Kim Isle Cortez on 11/20/21.
//

import Foundation
import Alamofire

/// Basic protocol for sending network requests. Only contains basic properties and functions for simplicity.
protocol APIManager {
	static var baseURL: String { get }
	static func request(_ service: APIService, completion: @escaping (Result<Data, Error>) -> Void)
}

/// This implementation wraps Alamofire usage. Should Alamofire be removed, update only this implementation without affecting actual API calls in the app.
class AFAPIManager: APIManager {
	
	internal static var baseURL: String {
		return "https://api.deezer.com"
	}
	
	static func request(_ service: APIService, completion: @escaping (Result<Data, Error>) -> Void) {
		let url = baseURL.appending(service.path)
		let method = HTTPMethod(rawValue: service.method)
		var afHeaders: HTTPHeaders?
		
		if let headers = service.header {
			afHeaders = HTTPHeaders(headers)
		}
		
		AF.request(url, method: method, parameters: service.parameters, headers: afHeaders, interceptor: nil, requestModifier: nil).responseData { dataResponse in
			switch dataResponse.result {
			case .success(let data):
				completion(.success(data))
			case .failure(let afError):
				completion(.failure(afError))
			}
		}
	}
	
}

/// Another wrapper for network implementation
class SomeAPIManager: APIManager {
	
	internal static var baseURL: String {
		return "https://example.com"
	}
	
	static func request(_ service: APIService, completion: @escaping (Result<Data, Error>) -> Void) {
		// TODO: Handle sending of request here
	}
	
}
