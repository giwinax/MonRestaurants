//
//  NavigationController.swift
//  MonRestaurants
//
//  Created by s b on 26.04.2022.
//

import UIKit

class NavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }

}
