//
//  ViewModel.swift
//  HiraganaApp
//
//  Created by 柴田晃輔 on 2020/03/10.
//  Copyright © 2020 shibata. All rights reserved.
//

import RxSwift
import RxCocoa

final class ViewModel {
    var kanji: String!
    var hiragana = BehaviorRelay<String>(value: "")

    private let hiraganaApi = HiraganaApi()

    func convertKanji() {
        // API実行リクエスト
        hiraganaApi.requestApi(kanji: kanji) { converted in
            if let converted = converted {
                // ViewControllerへaccept
                self.hiragana.accept(converted)
            } else {
                print("Returned nil")
            }
        }

    }
    
}
