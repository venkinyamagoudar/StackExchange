//
//  DetailViewCoordinator.swift
//  StackExchange
//
//  Created by Venkatesh Nyamagoudar on 5/23/23.
//

import UIKit

class DetailQuestionViewCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let dataManager = DetailQuetoinDataManager()
        let viewModel = DetailQuestionViewViewModel(dataManager: dataManager)
        
        let detailQuestionViewController = DetailQuestionViewController(viewModel: viewModel)
    
        
        navigationController.pushViewController(detailQuestionViewController, animated: true)
    }
}
