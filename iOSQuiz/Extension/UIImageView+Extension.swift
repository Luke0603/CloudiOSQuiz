//
//  UIImageView+Extension.swift
//  iOSQuiz
//
//  Created by 陳博竣 on 2020/11/9.
//

import Foundation
import AlamofireImage

extension UIImageView {
    func setImageUrl(_ url : String?) {
        if(url != nil){
            let url = URL(string: url!)!
            self.af.setImage(withURL: url)
        }
    }
}
