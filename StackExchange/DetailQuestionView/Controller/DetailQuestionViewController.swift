//
//  DetailQuestionViewController.swift
//  StackExchange
//
//  Created by Venkatesh Nyamagoudar on 5/24/23.
//

import UIKit

class DetailQuestionViewController: UIViewController {

    @IBOutlet weak var questionsLabel: UILabel!
    @IBOutlet weak var tagsLabel: UILabel!
    @IBOutlet weak var lastEditedLabel: UILabel!
    
    @IBOutlet weak var scoreButton: UIButton!
    
    @IBOutlet weak var answerButton: UIButton!
    @IBOutlet weak var viewButton: UIButton!
    
    @IBOutlet weak var bodyLabel: UILabel!

    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var usernameLabel: UILabel!

    @IBOutlet weak var reputationLabel: UILabel!
    
    var viewModel: DetailQuestionViewViewModel
    
    init(viewModel: DetailQuestionViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Quetion"
        view.backgroundColor = .secondarySystemBackground
        loadData()
    }
    
    private func loadData() {
        viewModel.questionListFetch {[weak self] result in
            switch result {
            case .success(let data):
                self?.updateUI(with: data)
            case .failure(_):
                fatalError()
            }
        }
    }
    
    private func updateUI(with data: DetailQuestion) {
        DispatchQueue.main.async { [weak self] in

            self?.viewModel.getProfileImage(from: data.items[0].owner.profileImage) {[weak self] image, error in
                if error != nil {
                    self?.profileImage.image  = UIImage(systemName: "person.circle")
                }
                self?.profileImage.image = image
            }
            self?.questionsLabel.text = data.items[0].title
            self?.tagsLabel.text = data.items[0].tags.joined(separator: ", ")
            self?.lastEditedLabel.text = String(data.items[0].lastEditDate)
            self?.scoreButton.setTitle(String(data.items[0].score), for: .normal)
            self?.answerButton.setTitle(String(data.items[0].answerCount), for: .normal)
            self?.viewButton.setTitle(String(data.items[0].viewCount), for: .normal)
            self?.bodyLabel.text = data.items[0].body.html2String
            self?.usernameLabel.text = data.items[0].owner.displayName
            self?.reputationLabel.text = String(data.items[0].owner.reputation)
        }
    }

}
