//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Lasha Maruashvili on 11.01.22.
//

import UIKit
import Kingfisher
import Core

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with article: Article) {
        self.titleLabel.text = article.title
        self.descriptionLabel.text = article.articleDescription
        self.dateLabel.text = article.publishedAt
        guard let imageUrl = URL(string: article.urlToImage) else {
            coverImageView.image = nil
            return
        }
        coverImageView.kf.setImage(with: imageUrl, placeholder: nil)
    }

}
