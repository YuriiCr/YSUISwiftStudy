//
//  ImageView.swift
//  YSSwiftStudy
//
//  Created by Yurii Sushko on 04.11.17.
//  Copyright © 2017 Yurii Sushko. All rights reserved.
//

import UIKit

class ImageView: YSView {

    //MARK: Public properties

    var imageModel: ImageModel? {
        didSet {
            self.observationController = self.imageModel?.controller(with: self)
        }
    }

    var imageView: UIImageView? {
        willSet {  newValue.map { self.addSubview($0)}}
        didSet { oldValue?.removeFromSuperview() }
    }

    var  observationController: ObservableObject.ObservationController? {
        didSet {
            let controller = self.observationController
            let loadingView = self.loadingView

            controller?[.didLoad] = { [weak self, weak loadingView] model, _ in
                loadingView?.state = .hidden
                self?.fillWith(model: model as? ImageModel)
            }

            controller?[.willLoad] = { [weak loadingView] _, _ in
                loadingView?.state = .visible
            }

            controller?[.loadingFailed] = { [weak loadingView]  _, _ in
                loadingView?.state = .hidden
            }
        }
    }

    // MARK: Override methods

    override func awakeFromNib() {
        super.awakeFromNib()
        self.initSubviews()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView = UIImageView(frame: self.bounds)
        self.initSubviews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initSubviews()

    }

    // MARK: Private methods

    func fillWith(model: ImageModel?) {
        self.imageView?.image = model?.image
    }

    func initSubviews() {
        let imageView = UIImageView(frame: self.bounds)
        imageView.autoresizingMask = .autoresizeAll

        self.imageView = imageView
    }

}
