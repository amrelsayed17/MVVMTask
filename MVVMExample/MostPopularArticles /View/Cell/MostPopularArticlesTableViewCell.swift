//
//  MostPopularArticlesTableViewCell.swift
//  MVVMExample
//
//  Created by Mac on 1/31/22.
//

import UIKit

class MostPopularArticlesTableViewCell: UITableViewCell {

    @IBOutlet weak var article_img: UIImageView!
    @IBOutlet weak var article_title: UILabel!
    
    static var mostPopularArticlesTableViewCell="MostPopularArticlesTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func cellConfigration(article:Result) {
        article_title.text=article.title ?? ""
        if let url=article.media?[0].mediaMetadata?[0].url
        {
            ImageDownloader.downloadImage(imageView: article_img, url: url, placeHolder: "")
        }

    }
    
}
