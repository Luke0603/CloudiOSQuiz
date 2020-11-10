//
//  PhotosViewController.swift
//  iOSQuiz
//
//  Created by 陳博竣 on 2020/11/9.
//

import UIKit

class PhotosViewController: UIViewController {

    lazy var contentView: UIView = {
        let view = PhotosView(self)
        return view
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        super.viewDidLoad()
        layout()
    }
    
    private func layout() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
}
