//
//  FlowViewController.swift
//  eRaceLeague-iOS
//
//  Created by Terrick Mansur on 6/16/18.
//  Copyright © 2018 Arubook N.V. All rights reserved.
//

import UIKit
import ReactiveKit

public protocol FlowViewModelProtocol {
    var root: UIViewController { get }
    var show: SafePublishSubject<UIViewController> { get }
    var present: SafePublishSubject<FlowController.Presentation> { get }
    var dismiss: SafePublishSubject<FlowController.Dismissal> { get }
    var goBack: SafePublishSubject<Void> { get }
}

public class FlowController: NSObject {
    
    public struct Presentation {
        
        let viewController: UIViewController
        let animated: Bool
        let completion: (() -> Void)?
        
        init(viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
            self.viewController = viewController
            self.animated = animated
            self.completion = completion
        }
    }
    
    public struct Dismissal {
        
        let animated: Bool
        let completion: (() -> Void)?

        init(animated: Bool, completion: (() -> Void)?) {
            self.animated = animated
            self.completion = completion
        }
    }
    
    public let root: UIViewController

    
    // # MARK: Private Attributes

    private let viewModel: FlowViewModelProtocol
    private let navigationController: UINavigationController

    public init(viewModel: FlowViewModelProtocol, navigationController: UINavigationController? = nil) {
        self.viewModel = viewModel
        
        if let navigationController = navigationController {
            self.navigationController = navigationController
            self.root = self.viewModel.root
        } else {
            self.navigationController = UINavigationController(rootViewController: self.viewModel.root)
            self.root = self.navigationController
        }

        super.init()

        self.viewModel.show.observeNext { [weak self] viewController in
            self?.navigationController.show(viewController, sender: nil)
        }.dispose(in: bag)
        
        self.viewModel.present.observeNext { [weak self] presentation in
            self?.navigationController.present(presentation.viewController, animated: presentation.animated, completion: presentation.completion)
        }.dispose(in: bag)
        
        self.viewModel.goBack.observeNext { [weak self] dismissal in
            self?.navigationController.popViewController(animated: true)
        }.dispose(in: bag)
    }
}
