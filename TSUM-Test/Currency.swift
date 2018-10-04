//
//  Currency.swift
//  TSUM-Test
//
//  Created by Илья Егоров on 03.10.2018.
//  Copyright © 2018 Ilya Egorov. All rights reserved.
//

import RealmSwift
import ObjectMapper

class Currency: Object, Mappable {
	
	@objc dynamic var code: String?
	@objc dynamic var name: String?
	@objc dynamic var symbol: String?
	
	override class func primaryKey() -> String? {
		return "code"
	}
	
	required convenience init?(map: Map) {
		self.init()
	}
	
	func mapping(map: Map) {
		code <- map["code"]
		name <- map["name"]
		symbol <- map["symbol"]
	}
}
