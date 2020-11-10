//
//  IndexViewController.swift
//  iOSQuiz
//
//  Created by 陳博竣 on 2020/11/9.
//

import UIKit
import SnapKit

class IndexViewController: UIViewController {

    lazy var apiButton: UIButton = {
        var button = self.createTextButton("Request API")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
    }

    private func layout() {
        view.backgroundColor = .white
        
        view.addSubview(apiButton)
        apiButton.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    private func bind() {
        apiButton.addTarget(self, action: #selector(IndexViewController.searchPhotos), for: .touchUpInside)
    }
    
    @objc private func searchPhotos() {
        let vc: PhotosViewController = PhotosViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func createTextButton(_ text: String) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return button
    }
}
