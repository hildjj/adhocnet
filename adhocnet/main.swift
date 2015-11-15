//
//  main.swift
//  adhocnet
//
//  Created by Joe Hildebrand on 11/14/15.
//  Copyright © 2015 Joe Hildebrand. All rights reserved.
//

import Foundation
import CoreWLAN

let args = Process.arguments
if args.count < 3 {
    let p = args[0].componentsSeparatedByString("/")

    print("Usage: \(p.last!) <SSID> <Password>")
    exit(64)
}
let networkName = args[1]
let password = args[2]


if let iface = CWWiFiClient.sharedWiFiClient().interface() {
    do {
        try iface.startIBSSModeWithSSID(
            networkName.dataUsingEncoding(NSUTF8StringEncoding)!,
            security: CWIBSSModeSecurity.WEP104,
            channel: 11,
            password: password as String
        )
        print("Success")
    } catch let error as NSError {
        print("Error", error)
        exit(1)
    }
} else {
    print("Invalid interface")
    exit(1)
}
