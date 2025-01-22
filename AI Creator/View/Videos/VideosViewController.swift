//
//  VideosViewController.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 22.01.25.
//

import AICreatorViewModel
import SnapKit
import StoreKit

class VideosViewController: BaseViewController, UICollectionViewDelegate {

    var viewModel: ViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        makeButtonsAction()
    }

    override func setupUI() {
        super.setupUI()

        self.view.backgroundColor = .black

        setupConstraints()
    }

    override func setupViewModel() {
        super.setupViewModel()
    }

    func setupConstraints() {

    }

}

//MARK: Make buttons actions
extension VideosViewController {

    private func makeButtonsAction() {
        
    }
}

extension VideosViewController: IViewModelableController {
    typealias ViewModel = IVideosViewModel
}

//MARK: Preview
import SwiftUI

struct VideosViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let videosViewController = VideosViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<VideosViewControllerProvider.ContainerView>) -> VideosViewController {
            return videosViewController
        }

        func updateUIViewController(_ uiViewController: VideosViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<VideosViewControllerProvider.ContainerView>) {
        }
    }
}
