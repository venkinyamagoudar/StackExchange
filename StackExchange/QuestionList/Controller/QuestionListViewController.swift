//
//  ViewController.swift
//  StackExchange
//
//  Created by Venkatesh Nyamagoudar on 5/23/23.
//

import UIKit

protocol QuestionListViewControllerDelegate {
    func navigateToDetailView()
}

// This protocols can be only used by refernce types
//protocol QuestionListViewControllerDelegate: class {
//    func navigateToDetailView()
//}

class QuestionListViewController: UIViewController {
    
    var viewModel: QuestionsListViewModel
    var delegate: QuestionListViewControllerDelegate?
    
    init(viewModel: QuestionsListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var questionListingTableviewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.sizeToFit()
        return view
    }()
    
    var questionListingTableview: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .secondarySystemBackground
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 20
        tableView.isScrollEnabled = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        title = "Question List"
        
        questionListingTableview.delegate = self
        questionListingTableview.dataSource = self
        
        view.addSubview(questionListingTableviewContainer)
        questionListingTableviewContainer.addSubview(questionListingTableview)
        
        questionListingTableview.register(QuestionListTableViewCell.self, forCellReuseIdentifier: QuestionListTableViewCell.identifier)
        loadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        //Add constraints to stopWatchContainerView
        constraints.append(questionListingTableviewContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8))
        constraints.append(questionListingTableviewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8))
        constraints.append(questionListingTableviewContainer.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -16))
        constraints.append(questionListingTableviewContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -16))
        
        
        //Add constraints to stopWatchTableview
        constraints.append(questionListingTableview.leadingAnchor.constraint(equalTo: questionListingTableviewContainer.leadingAnchor, constant: 0))
        constraints.append(questionListingTableview.topAnchor.constraint(equalTo: questionListingTableviewContainer.topAnchor, constant: 0))
        constraints.append(questionListingTableview.widthAnchor.constraint(equalTo: questionListingTableviewContainer.widthAnchor, constant: 0))
        constraints.append(questionListingTableview.heightAnchor.constraint(equalTo: questionListingTableviewContainer.heightAnchor, constant: 0))
        
        //Activate
        NSLayoutConstraint.activate(constraints)
    }
    
    
    private func loadData() {
        viewModel.questionListFetch(completion: { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async { [weak self] in
                    self?.viewModel.questionList = data
                    self?.questionListingTableview.reloadData()
                }
            case .failure(_):
                fatalError("Error while getting data")
            }
        })
    }
}

extension QuestionListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.questionList?.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionListTableViewCell.identifier, for: indexPath) as! QuestionListTableViewCell
        if let questionList = viewModel.questionList?.items {
            cell.configure(data: questionList[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.navigateToDetailView()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
