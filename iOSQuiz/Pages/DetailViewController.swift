//
//  DetailViewController.swift
//  iOSQuiz
//
//  Created by 陳博竣 on 2020/11/9.
//

import UIKit

class DetailViewController: UIViewController {

    var photos: Photos
    
    lazy var contentView: UIView = {
        let view = DetailView(photos)
        return view
    }()
    
    init(_ photos: Photos) {
        self.photos = photos
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
