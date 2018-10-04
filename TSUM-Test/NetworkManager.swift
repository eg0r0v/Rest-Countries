//
//  NetworkManager.swift
//  TSUM-Test
//
//  Created by Илья Егоров on 04.10.2018.
//  Copyright © 2018 Ilya Egorov. All rights reserved.
//

import Alamofire
import RxCocoa

class NetworkManager {
	
	static let shared = NetworkManager()
	private let reachabilityManager = NetworkReachabilityManager()
	private var wasUnreachable = false
	private var didChangeStateToOnline = true
	
	private(set) var isOnline: BehaviorRelay<NetworkReachabilityManager.NetworkReachabilityStatus> = BehaviorRelay(value: .unknown)
	
	func startNetworkReachabilityObserver() {
		reachabilityManager?.listener = listener
		reachabilityManager?.startListening()
	}
	
	private func listener(_ status: NetworkReachabilityManager.NetworkReachabilityStatus) {
		isOnline.accept(status)
	}
}
