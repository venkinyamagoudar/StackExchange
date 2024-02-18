//
//  QuestionListViewCell.swift
//  StackExchange
//
//  Created by Venkatesh Nyamagoudar on 5/23/23.
//

import UIKit

class QuestionListTableViewCell: UITableViewCell {
    
    static var identifier = "QuestionListTableViewCell"
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    var quetionTitleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HeadLine", size: 20)
        label.numberOfLines = 4
        label.backgroundColor = .clear
        return label
    }()
    
    var tagsLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Subhead", size: CGFloat(12))
        label.backgroundColor = .clear
        label.numberOfLines = 2
        return label
    }()
    
    var lastTimeEditedLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "System", size: CGFloat(20))
        label.numberOfLines = 2
        label.backgroundColor = .clear
        return label
    }()
    
    
    var scoreButton: UIButton = {
        let button = UIButton(type: .custom)
        button.clipsToBounds = true
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName:"pencil.tip.crop.circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.tintColor = .tintColor
        return button
    }()
    
    var answerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.tintColor = .tintColor
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName:"ellipsis.bubble.fill"), for: .normal)
        return button
    }()
    
    var viewButton: UIButton = {
        let button = UIButton(type: .custom)
        button.clipsToBounds = true
        button.setTitle("", for: .normal)
        button.setImage(UIImage(systemName:"eye"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = true
        button.tintColor = .tintColor
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(containerView)
        containerView.addSubview(quetionTitleLabel)
        containerView.addSubview(tagsLabel)
        containerView.addSubview(lastTimeEditedLabel)
        containerView.addSubview(scoreButton)
        containerView.addSubview(answerButton)
        containerView.addSubview(viewButton)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        //Add constraints
        constraints.append(containerView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor))
        constraints.append(containerView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(containerView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor))
        constraints.append(containerView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor))
        
        
        constraints.append(quetionTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8))
        constraints.append(quetionTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16))
        constraints.append(quetionTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16))
        
        constraints.append(tagsLabel.topAnchor.constraint(equalTo: quetionTitleLabel.bottomAnchor, constant: 8))
        constraints.append(tagsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16))
        constraints.append(tagsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16))
        
        constraints.append(lastTimeEditedLabel.topAnchor.constraint(equalTo: tagsLabel.bottomAnchor, constant: 8))
        constraints.append(lastTimeEditedLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16))
        constraints.append(lastTimeEditedLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16))
        
        // Add constraints for the button
        constraints.append(scoreButton.topAnchor.constraint(equalTo: lastTimeEditedLabel.bottomAnchor, constant: 8))
        constraints.append(scoreButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16))
        constraints.append(scoreButton.heightAnchor.constraint(equalToConstant: 25))
        
        constraints.append(answerButton.topAnchor.constraint(equalTo: lastTimeEditedLabel.bottomAnchor, constant: 8))
        constraints.append(answerButton.leadingAnchor.constraint(equalTo: scoreButton.trailingAnchor, constant: 15))
        constraints.append(answerButton.heightAnchor.constraint(equalToConstant: 25))
        
        constraints.append(viewButton.topAnchor.constraint(equalTo: lastTimeEditedLabel.bottomAnchor, constant: 8))
        constraints.append(viewButton.leadingAnchor.constraint(equalTo: answerButton.trailingAnchor, constant: 15))
        constraints.append(viewButton.heightAnchor.constraint(equalToConstant: 25))
        
        //Activate
        NSLayoutConstraint.activate(constraints)
    }
    
    func configure(data: Item) {
        quetionTitleLabel.text = data.title
        tagsLabel.text = data.tags.joined(separator: ", ")
        scoreButton.setTitle(String(data.score), for: .normal)
        answerButton.setTitle(String(data.answerCount), for: .normal)
        viewButton.setTitle(String(data.viewCount), for: .normal)
    }
    
}
