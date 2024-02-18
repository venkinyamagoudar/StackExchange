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
        let dataManager = QuestionListDataManager()
        let viewModel = QuestionsListViewModel(dataManger: dataManager)
        
        let questionListController = QuestionListViewController(viewModel: viewModel)
        navigationController.viewControllers = [questionListController]
        navigationController.navigationBar.prefersLargeTitles = true
        
        questionListController.delegate = self
    }
    
    func pushToDetailviewController() {
        let detailQuetionViewCoordinator = DetailQuestionViewCoordinator(navigationController: self.navigationController)
        childCoordinators.append(detailQuetionViewCoordinator)
        detailQuetionViewCoordinator.start()
    }
}

extension QuestionListCoordinator: QuestionListViewControllerDelegate {
    func navigateToDetailView() {
        pushToDetailviewController()
    }
}
