//
//  EffectsViewController.swift
//  AI Creator
//
//  Created by Er Baghdasaryan on 22.01.25.
//

import AICreatorViewModel
import SnapKit
import StoreKit

class EffectsViewController: BaseViewController, UICollectionViewDelegate {

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
extension EffectsViewController {

    private func makeButtonsAction() {
        
    }
}

extension EffectsViewController: IViewModelableController {
    typealias ViewModel = IEffectsViewModel
}

//MARK: Preview
import SwiftUI

struct EffectsViewControllerProvider: PreviewProvider {

    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }

    struct ContainerView: UIViewControllerRepresentable {
        let effectsViewController = EffectsViewController()

        func makeUIViewController(context: UIViewControllerRepresentableContext<EffectsViewControllerProvider.ContainerView>) -> EffectsViewController {
            return effectsViewController
        }

        func updateUIViewController(_ uiViewController: EffectsViewControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<EffectsViewControllerProvider.ContainerView>) {
        }
    }
}
