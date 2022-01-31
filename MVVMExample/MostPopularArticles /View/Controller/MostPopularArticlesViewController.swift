//
//  MostPopularArticlesViewController.swift
//  MVVMExample
//
//  Created by Mac on 1/31/22.
//

import UIKit
import RxSwift
import RxCocoa

class MostPopularArticlesViewController: UIViewController {

    @IBOutlet weak var articleTableView: UITableView!
    let refreshControl = UIRefreshControl()

    var articlesViewModel=MostPopularArticlesViewModel()
    let disposeBag=DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        subscribeToArticleSelection()
        subscribeToLoading()
        subscribeToResponse()
        getArticls()

    }

    func setupTableView()
    {
        articleTableView.register(UINib(nibName:MostPopularArticlesTableViewCell.mostPopularArticlesTableViewCell , bundle: nil), forCellReuseIdentifier: MostPopularArticlesTableViewCell.mostPopularArticlesTableViewCell)
        refreshControl.addTarget(self, action: #selector(self.refreshTable(_:)), for: .valueChanged)
        articleTableView.addSubview(refreshControl)
    }

    @objc func refreshTable(_ sender: AnyObject) {
       getArticls()
    }
    
    func subscribeToResponse()
    {
        articlesViewModel.articleModelObservable.bind(to: articleTableView.rx.items(cellIdentifier: MostPopularArticlesTableViewCell.mostPopularArticlesTableViewCell, cellType: MostPopularArticlesTableViewCell.self)){ row,article,cell in
            
            cell.cellConfigration(article: article)
            
        }.disposed(by: disposeBag)
    }
    
    func getArticls()
    {
        articlesViewModel.getArticlesData()
    }
    
    func subscribeToArticleSelection()
    {
        Observable
            .zip(articleTableView.rx.itemSelected,articleTableView.rx.modelSelected(Result.self))
            .bind{ article in
                self.performSegue(withIdentifier: "showArticle", sender: article.1)
            }
            .disposed(by: disposeBag)
    }
    
    func subscribeToLoading()
    {
        articlesViewModel.loadingBehavior.subscribe(onNext: { isLoading in
            if(isLoading)
            {
                self.showIndicator(withTitle: "Loading ...", and: "")
            }
            else
            {
                self.hideIndicator()
                self.refreshControl.endRefreshing()
            }
        }).disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "showArticle")
        {
            let vc:ArticleDetailsViewController=segue.destination as! ArticleDetailsViewController
            vc.model=sender as? Result
        }
    }


}
