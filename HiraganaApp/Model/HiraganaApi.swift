//
//  HiraganaApi.swift
//  HiraganaApp
//
//  Created by 柴田晃輔 on 2020/03/10.
//  Copyright © 2020 shibata. All rights reserved.
//

import Alamofire
import SwiftyJSON

final class HiraganaApi {

    private let app_id = "955307517c5183d4db4c5229d3eac6d39dc28f4a4340fd9855b6b2a77ed90a8b"
    private let output_type = "hiragana"
    private let header: HTTPHeaders = ["Content-Type" : "application/json"]

    func requestApi(kanji: String, comletion: @escaping (String?) -> ()) {

        let parameters = [
            "app_id": app_id,
            "sentence": kanji,
            "output_type": output_type
        ]

        AF.request("https://labs.goo.ne.jp/api/hiragana",
          method: .post,
          parameters: parameters as Parameters,
          encoding: JSONEncoding.default, headers: header)
        .responseJSON { response in
            switch response.result {
            case .success:
                let converted = JSON(response.data!)["converted"].stringValue
                comletion(converted)
            case .failure:
                comletion(nil)
                print("API request failure")
            }

        }

    }
}
