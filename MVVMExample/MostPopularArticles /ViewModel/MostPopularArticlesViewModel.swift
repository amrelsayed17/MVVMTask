//
//  MostPopularArticlesViewModel.swift
//  MVVMExample
//
//  Created by Mac on 1/31/22.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

class MostPopularArticlesViewModel: NSObject {

    var loadingBehavior=BehaviorRelay<Bool>(value: false)
    private var articleModelSubject=PublishSubject<[Result]>()
    var articleModelObservable:Observable<[Result]>{
        return articleModelSubject
    }
    
    func getArticlesData()
    {
        loadingBehavior.accept(true)
        APIServices.instance.getData(url:URL(string:Constants.articles_api)!, method: .get, params: nil, encoding: JSONEncoding.default, headers: nil) { (articleModel:ArticleModel?,errorModel:ArticleModel? , error) in
            
            self.loadingBehavior.accept(false)
            if error != nil {
                AlertMessages.showMessage(title: "Error", body: "Connection Error", theme: .error)
            }
            else if errorModel != nil{
                AlertMessages.showMessage(title: "Error", body: "Connection Error", theme: .error)
            }
            else
            {
                guard let articleModel=articleModel else { return }
                self.articleModelSubject.onNext(articleModel.results ?? [])
            }
        }
    }
}
