//
//  ViewController.swift
//  HiraganaApp
//
//  Created by 柴田晃輔 on 2020/03/09.
//  Copyright © 2020 shibata. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {

    @IBOutlet weak var kanjiTextView: UITextView!
    @IBOutlet weak var hiraganaTextView: UITextView!
    @IBOutlet weak var convertButton: UIButton!

    private let disposeBag = DisposeBag()
    private let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        kanjiTextView.delegate = self

        setupView()
        setupButton()
        dataBind()

    }

    private func setupView() {
        // 漢字入力フォームの設定
        kanjiTextView.layer.borderWidth = 1.0
        kanjiTextView.layer.borderColor = UIColor.gray.cgColor
        kanjiTextView.layer.cornerRadius = 10.0
        kanjiTextView.layer.masksToBounds = true

        // ひらがな出力フォームの設定
        hiraganaTextView.layer.borderWidth = 1.0
        hiraganaTextView.layer.borderColor = UIColor.gray.cgColor
        hiraganaTextView.layer.cornerRadius = 10.0
        hiraganaTextView.layer.masksToBounds = true


        // 変換ボタンの設定
        convertButton.backgroundColor = .gray
        convertButton.isEnabled = false

        //　ナビゲーションバーの設定
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "AppTheme")
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    private func setupButton() {

        // ボタン活性/非活性の設定
        kanjiTextView.rx.text
            .subscribe(onNext: { text in
                if text!.count > 0 {
                    self.convertButton.isEnabled = true
                    self.convertButton.backgroundColor = UIColor(named: "AppTheme")
                } else {
                    self.convertButton.isEnabled = false
                    self.convertButton.backgroundColor = .gray
                }
            })
            .disposed(by: disposeBag)

        // ボタンタップ時の動作
        convertButton.rx.tap
            .subscribe { [weak self] _ in
                self?.viewModel.convertKanji()
        }.disposed(by: disposeBag)
    }

    private func dataBind() {
        // 漢字入力をbind
        kanjiTextView.rx.text.orEmpty
            .bind(to: viewModel.kanji)
            .disposed(by: disposeBag)

        // ひらがな出力をbind
        viewModel.hiragana
            .bind(to: hiraganaTextView.rx.text)
            .disposed(by: disposeBag)
    }
    
}

extension ViewController: UITextViewDelegate {

    // return押下時にキーボードを閉じる
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            kanjiTextView.resignFirstResponder()
            return false
        }
        return true
    }
}

