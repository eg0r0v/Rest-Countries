//
//  CountriesService.swift
//  TSUM-Test
//
//  Created by Илья Егоров on 29.09.2018.
//  Copyright © 2018 Ilya Egorov. All rights reserved.
//

import Moya
import Moya_ObjectMapper
import RxSwift

class CountriesService {
	
	static let shared = CountriesService()
	
	private let rxCountriesServiceProvider = MoyaProvider<CountriesProvider>()

	func getCountriesRequest() -> Single<[Country]> {
		return rxCountriesServiceProvider.rx.request(.all)
				.mapArray(Country.self)
	}
	
	func getCountryRequest(name: String) -> Single<[Country]> {
		return rxCountriesServiceProvider.rx.request(.name(name: name))
				.mapArray(Country.self)
	}
}
