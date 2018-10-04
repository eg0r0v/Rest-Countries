//
//  CountriesProvider.swift
//  TSUM-Test
//
//  Created by Илья Егоров on 29.09.2018.
//  Copyright © 2018 Ilya Egorov. All rights reserved.
//

import Moya

enum CountriesProvider: BaseProvider {
	case all
	case name(name: String)
}

extension CountriesProvider: TargetType {
	var path: String {
		switch self {
		case .all:
			return "all"
		case .name(name: let countryName):
			return "name/\(countryName)"
		}
	}
	
	var parameters: [String: String] {
		switch self {
		case .all:
			return ["fields": "alpha3Code;name;population"]
		case .name(name: _):
			return ["fullText": "true", "fields":"alpha3Code;name;population;capital;currencies;borders"]
		}
	}
	
	var task: Task {
		return .requestParameters(parameters: parameters, encoding: parameterEncoding)
	}
}
