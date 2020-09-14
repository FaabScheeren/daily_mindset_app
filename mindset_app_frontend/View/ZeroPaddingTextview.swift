//
//  ZeroPaddingTextview.swift
//  mindset_app_frontend
//
//  Created by Fabio Scheeren on 17/08/2020.
//  Copyright © 2020 Fabio Scheeren. All rights reserved.
//

import UIKit

@IBDesignable class ZeroPaddingTextView: UITextView {

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    func setup() {
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
    }
    
}
