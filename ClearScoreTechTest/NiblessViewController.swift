//
//  NiblessViewController.swift
//  ClearScoreTechTest
//
//  Created by Sophie Clark on 18/03/2022.
//

import UIKit

open class NiblessViewController: UIViewController {
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable,
    message: "Loading this view controller from a nib or storyboards is unsupported, please use initializer with parameters instead."
    )
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @available(*, unavailable,
    message: "Loading this view controller from a nib or storyboards is unsupported, please use initializer with parameters instead."
    )
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
}

open class NiblessView: UIView {
    public init() {
        super.init(frame: .zero)
    }
    
    @available(*, unavailable,
    message: "Loading this view from a nib or storyboards is unsupported, please use initializer with parameters instead."
    )
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
