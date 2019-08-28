//
//  ControllerProtocol.swift
//  EventBriteSample
//
//  Created by Rajneesh Kumar on 28/08/19.
//  Copyright © 2019 Rajneesh Kumar. All rights reserved.
//

import Foundation
import UIKit
/// This protocol provide default `identifire` for your Class
/// The default identifire is your class name. You can customize it by providing `identifire` property.
protocol Identifiable: AnyObject {
    static var identifire: String { get }
}
// Default value of `identifire`: Your class name
extension Identifiable where Self: NSObject {
    static var identifire: String { return className }
}

public protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}
extension StoryboardIdentifiable where Self: UIViewController {
    public static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
