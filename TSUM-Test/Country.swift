//
//  Country.swift
//  TSUM-Test
//
//  Created by Илья Егоров on 29.09.2018.
//  Copyright © 2018 Ilya Egorov. All rights reserved.
//

import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class Country: Object, Mappable {
	
	@objc dynamic var code: String?
	@objc dynamic var name: String?
	@objc dynamic var population = 0
	@objc dynamic var capital: String?
	var currencies = List<Currency>()
	var borders = [String]()
	
	@objc dynamic var isOld = false
	
	var canBeShownInList: Bool {
		return code != nil && name != nil && population != 0
	}
	
	var hasFullInformation: Bool {
		return canBeShownInList && capital != nil && !currencies.isEmpty && !borders.isEmpty
	}
	
	override class func primaryKey() -> String? {
		return "name"
	}
	
	required convenience init?(map: Map) {
		self.init()
	}
	
	func mapping(map: Map) {
		code <- map["alpha3Code"]
		name <- map["name"]
		population <- map["population"]
		capital <- map["capital"]
		currencies <- (map["currencies"], ListTransform<Currency>())
		borders <- map["borders"]
	}
}
