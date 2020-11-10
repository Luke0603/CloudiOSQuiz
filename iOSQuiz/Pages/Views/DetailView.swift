//
//  DetailView.swift
//  iOSQuiz
//
//  Created by 陳博竣 on 2020/11/9.
//

import UIKit

class DetailView: UIView {
    
    var photos: Photos
    
    var photoImgView = UIImageView()
    
    var idLabel = UILabel()
    
    var titleLabel = UILabel()
    
    init(_ photos: Photos) {
        self.photos = photos
        super.init(frame: .zero)
        layout()
        update()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(photoImgView)
        addSubview(idLabel)
        addSubview(titleLabel)
        
        photoImgView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(photoImgView.snp.width)
            make.centerX.equalToSuperview()
        }
        
        idLabel.snp.makeConstraints { (make) in
            make.height.equalTo(30)
            make.left.equalToSuperview().offset(25)
            make.right.equalToSuperview()
            make.top.equalTo(photoImgView.snp.bottom).offset(10)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(idLabel.snp.left)
            make.right.equalToSuperview().offset(-25)
            make.top.equalTo(idLabel.snp.bottom).offset(10)
        }
    }
    
    func update() {
        photoImgView.setImageUrl(photos.url)
        idLabel.text = "id: \(photos.id!)"
        titleLabel.text = "title: \(photos.title!)"
        titleLabel.numberOfLines = 0
    }
}
