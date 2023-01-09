//
//  Coordinator.swift
//  Running_Hi
//
//  Created by 안종표 on 2022/12/19.
//

import UIKit
import Foundation

class Coordinator{
    var childCoordinaotors: [UUID: Coordinator] = [:]
    
    var identifier: UUID
    var navigationController: UINavigationController
    
    init(identifier: UUID, navigationController: UINavigationController) {
        self.identifier = identifier
        self.navigationController = navigationController
    }
}
