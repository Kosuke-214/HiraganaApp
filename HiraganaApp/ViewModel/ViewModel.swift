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
    var kanji = BehaviorRelay<String>(value: "")
    var hiragana = BehaviorRelay<String>(value: "")

    private let hiraganaApi = HiraganaApi()

    func convertKanji() {
        hiraganaApi.requestApi(kanji: kanji.value) { converted in
            if let converted = converted {
                self.hiragana.accept(converted)
            } else {
                print("Returned nil")
            }
        }

    }
    
}
