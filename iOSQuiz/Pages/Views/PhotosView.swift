//
//  PhotosView.swift
//  iOSQuiz
//
//  Created by 陳博竣 on 2020/11/9.
//

import UIKit

class PhotosView: UIView {
    let viewModel = PhotosViewModel()
    let viewController: UIViewController
    var fullScreenSize :CGSize! = UIScreen.main.bounds.size
    
    lazy var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: CGFloat(fullScreenSize.width)/4, height: CGFloat(fullScreenSize.width)/4)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        
        return collectionView
    }()
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
        super.init(frame: .zero)
        initPrivate()
        fetchData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initPrivate() {
        backgroundColor = .white
        addSubview(photosCollectionView)
        
        photosCollectionView.snp.makeConstraints { (make) in
            make.size.equalToSuperview()
        }
    }
    
    private func fetchData() {
        viewModel.fetchPhotos { [weak self] in
            DispatchQueue.main.async {
                self?.photosCollectionView.reloadData()
            }
        }
    }
}

extension PhotosView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell {
            cell.update(photos: viewModel.items[indexPath.item])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photos = viewModel.items[indexPath.item]
        let vc = DetailViewController(photos)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}

extension PhotosView {
    class PhotoCell: UICollectionViewCell {
        var bgImgView = UIImageView()
        var idLabel = UILabel()
        var titleLabel = UILabel()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            initPrivate()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            initPrivate()
        }
        
        func initPrivate() {
            contentView.addSubview(bgImgView)
            contentView.addSubview(idLabel)
            contentView.addSubview(titleLabel)
            
            bgImgView.snp.makeConstraints { (make) in
                make.size.equalToSuperview()
            }
            
            idLabel.snp.makeConstraints { (make) in
                make.height.equalTo(30)
                make.center.equalToSuperview()
            }
            
            titleLabel.snp.makeConstraints { (make) in
                make.height.equalTo(30)
                make.top.equalTo(idLabel.snp.bottom)
                make.left.right.equalToSuperview()
            }
        }
        
        func update(photos: Photos) {
            idLabel.text = "\(photos.id!)"
            titleLabel.text = "\(photos.title!)"
            bgImgView.setImageUrl(photos.thumbnailUrl)
        }
    }
}
