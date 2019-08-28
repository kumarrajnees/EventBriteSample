//
//  ClassName.swift
//  EventBriteSample
//
//  Created by Rajneesh Kumar on 28/08/19.
//  Copyright © 2019 Rajneesh Kumar. All rights reserved.
//

import Foundation
import UIKit
protocol ClassNameProtocol {
    static var className: String {get}
    var className: String {get}
}
extension ClassNameProtocol {
    public static var className: String {
        return String(describing: self)
    }
    public var className: String {
        return type(of: self).className
    }
}
extension NSObject: ClassNameProtocol {}
