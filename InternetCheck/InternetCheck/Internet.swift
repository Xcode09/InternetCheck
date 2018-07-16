//
//  Internet.swift
//  InternetCheck
//
//  Created by Muhammad Ali on 16/07/2018.
//  Copyright © 2018 Muhammad Ali. All rights reserved.
//

import SystemConfiguration

open class InternetCheck{
    public static func Isinternetavailbe()->Bool{
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let quotee = withUnsafePointer(to: &zeroAddress, {
            
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                
                SCNetworkReachabilityCreateWithAddress(nil, $0)
                
            }
            
        })
        var falg = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(quotee!, &falg) == false{
            return false
        }
        let isReachable = falg == .reachable
        let needsConnection = falg == .connectionRequired
        return isReachable && needsConnection
    }
}
