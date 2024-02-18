//
//  Coordinator.swift
//  StackExchange
//
//  Created by Venkatesh Nyamagoudar on 5/23/23.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] {get set}
    
    init(navigationController: UINavigationController)
    
    func start()
}
