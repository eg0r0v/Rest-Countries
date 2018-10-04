//
//  BaseProvider.swift
//  TSUM-Test
//
//  Created by Илья Егоров on 29.09.2018.
//  Copyright © 2018 Ilya Egorov. All rights reserved.
//

import Moya

protocol BaseProvider { }

extension BaseProvider {
	var baseURL: URL {
		return URL(string: "https://restcountries.eu/rest/v2/")!
	}
	
	var headers: [String : String]? {
		return nil
	}
	
	var method: Moya.Method {
		return .get
	}
	
	var parameterEncoding: ParameterEncoding {
		return URLEncoding.default
	}
	
	var sampleData: Data {
		return "Not used?".data(using: .utf8)!
	}
}
