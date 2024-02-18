//
//  QuestionTableViewCell.swift
//  StackExchange
//
//  Created by Venkatesh Nyamagoudar on 5/23/23.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var quetionLabel: UILabel!
    @IBOutlet weak var topicsLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var scoreButton: UIButton!
    @IBOutlet weak var answerButton: UIButton!
    @IBOutlet weak var seenButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
