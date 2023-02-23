//
//  Presenter.swift
//  CryptoViper
//
//  Created by Merve Nurgül BAĞCI on 23.02.2023.
//

import Foundation

enum NetworkError : Error {
    case NetworkFailed
    case ParsingFailed
}

protocol AnyPresenter {
    var router : AnyRouter? {get set}
    var interactor : AnyInteractor? {get set}
    var view : AnyView? {get set}
    
    func interactorDidDownloadCrypto(result : Result<[Crypto],Error>)
}

class CryptoPresenter : AnyPresenter {
    var view: AnyView?
    var router: AnyRouter?
    var interactor: AnyInteractor?{
        didSet{
            interactor?.downloadCryptos()
        }
    }
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>) {
        switch result {
        case .success(let cryptos):
            view?.update(with: cryptos)
        case .failure(_):
            view?.update(with: "Error!")
        }
    }
}
