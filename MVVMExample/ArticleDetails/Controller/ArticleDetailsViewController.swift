//
//  ArticleDetailsViewController.swift
//  MVVMExample
//
//  Created by Mac on 1/31/22.
//

import UIKit
import RxSwift

class ArticleDetailsViewController: UIViewController {

    
    @IBOutlet weak var article_img: UIImageView!
    @IBOutlet weak var article_desc: UITextView!
    
    var viewModel:ArticleDetailsViewModel=ArticleDetailsViewModel()
    let disposeBag=DisposeBag()
    var model:Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        subscribeToValueChanged()
        viewModel.setValue(article: model!)

    }
    
    func subscribeToValueChanged()
    {
        viewModel.articleModelObservable.subscribe(onNext: { article in
            
            if let url=article.media?[0].mediaMetadata?[0].url
            {
                ImageDownloader.downloadImage(imageView: self.article_img, url:url , placeHolder: "")
            }
            self.article_desc.text=article.abstract ?? ""
        })
        .disposed(by: disposeBag)
                
    }
}
