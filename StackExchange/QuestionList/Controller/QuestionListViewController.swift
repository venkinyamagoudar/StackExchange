//
//  ViewController.swift
//  StackExchange
//
//  Created by Venkatesh Nyamagoudar on 5/23/23.
//

import UIKit


protocol QuestionListingViewControllerDelegate {
    func navigateToDetailView()
}

class QuestionListViewController: UIViewController {
    
    var viewModel: QuestionsListViewModel?
    
    var delegate: QuestionListingViewControllerDelegate?
    
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        view.sizeToFit()
        return view
    }()
    
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
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 20
        tableView.isScrollEnabled = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Question List"
        
        loadData()
        questionListingTableview.delegate = self
        questionListingTableview.dataSource = self
        
        view.addSubview(containerView)
        containerView.addSubview(questionListingTableviewContainer)
        questionListingTableviewContainer.addSubview(questionListingTableview)
        setUpConstraints()
        
        questionListingTableview.register(QuestionTableViewCell.self, forCellReuseIdentifier: "QuestionTableViewCell")
        questionListingTableview.rowHeight = UITableView.automaticDimension
    }
    
    private func setUpConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        //Add constraints to container
        constraints.append(containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0))
        
        //Add constraints to stopWatchContainerView
        constraints.append(questionListingTableviewContainer.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8))
        constraints.append(questionListingTableviewContainer.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8))
        constraints.append(questionListingTableviewContainer.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: -16))
        constraints.append(questionListingTableviewContainer.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -16))
        
        
        //Add constraints to stopWatchTableview
        constraints.append(questionListingTableview.leadingAnchor.constraint(equalTo: questionListingTableviewContainer.leadingAnchor, constant: 0))
        constraints.append(questionListingTableview.topAnchor.constraint(equalTo: questionListingTableviewContainer.topAnchor, constant: 0))
        constraints.append(questionListingTableview.widthAnchor.constraint(equalTo: questionListingTableviewContainer.widthAnchor, constant: 0))
        constraints.append(questionListingTableview.heightAnchor.constraint(equalTo: questionListingTableviewContainer.heightAnchor, constant: 0))
        
        //Activate
        NSLayoutConstraint.activate(constraints)
    }
    
    
    private func loadData() {
        viewModel?.extractJsonData(from: "https://api.stackexchange.com/2.2/questions?site=stackoverflow&order=desc&sort=votes&tagged=swiftui&pagesize=30", completion: { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let data):
                self.viewModel?.parseJsonData(jsonData: data) { result in
                    switch result {
                    case .success(let jsonData):
                        self.viewModel?.questionList = jsonData.items
                    case .failure(let jsonError):
                        print(jsonError.localizedDescription)
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

extension QuestionListingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.questionList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "QuestionTableViewCell") as! QuestionTableViewCell
        if var viewModel = viewModel {
            cell.answerButton.setTitle(String(viewModel.questionList[indexPath.row].answerCount), for: .normal)
            cell.scoreButton.setTitle(String(viewModel.questionList[indexPath.row].answerCount), for: .normal)
            cell.seenButton.setTitle(String(viewModel.questionList[indexPath.row].viewCount), for: .normal)
            cell.quetionLabel.text = viewModel.questionList[indexPath.row].title
            cell.topicsLabel.text = viewModel.questionList[indexPath.row].tags.joined(separator: ", ")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
