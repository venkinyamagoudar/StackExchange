//
//  QuestionListCoordinator.swift
//  StackExchange
//
//  Created by Venkatesh Nyamagoudar on 5/23/23.
//

import UIKit

class QuestionListCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        let viewModel = QuestionsListViewModel()
        let dataManager = QuestionListDataManager()
        
        let questionListController = QuestionListViewController()
        questionListController.delegate = self
        questionListController.viewModel = viewModel
        navigationController.viewControllers = [questionListController]
        navigationController.navigationBar.prefersLargeTitles = true
    }
}

extension QuestionListCoordinator: QuestionListViewControllerDelegate {
    func navigateToDetailView() {
        
    }
}
