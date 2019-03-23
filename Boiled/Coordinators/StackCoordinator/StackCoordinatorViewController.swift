//
//  ProfileCoordinatorView.swift
//  eRaceLeague-iOS
//
//  Created by Terrick Mansur on 5/17/18.
//  Copyright © 2018 Arubook N.V. All rights reserved.
//

import UIKit
import ReactiveKit

protocol StackCoordinatorProtocol: ProvidesFooterComponent {
    var title: String { get }
    var components: [UIViewController] { get }
    var footerHeight: CGFloat { get }
    
    func viewDidLoad()
}

extension StackCoordinatorProtocol {
    func viewDidLoad() {}
}

class StackCoordinatorViewController: UIViewController, HasFooterViewProtocol {
    
    struct Output {
        var viewDidAppear: SafeSignal<Void>
        var viewDidLoad: SafeSignal<Void>
    }
    
    var coordinator: StackCoordinatorProtocol!
    
    var output: Output {
        return Output(viewDidAppear: self.viewDidAppearSubject.toSignal(),
                      viewDidLoad: viewDidLoadSubject.toSignal())
    }
    
    // # MARK: IBOutlets
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var stackViewHeight: NSLayoutConstraint!

    // # MARK: HasFooterViewProtocol
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var footerHeight: NSLayoutConstraint!

    // MARK: Privates
    private let viewDidAppearSubject = SafePublishSubject<Void>()
    private let viewDidLoadSubject = SafePublishSubject<Void>()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = coordinator?.title

        addFooter(footerProvider: coordinator)
        coordinator.viewDidLoad()
        
        viewDidLoadSubject.next()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.viewDidAppearSubject.next()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLayoutSubviews() {
        coordinator.components.forEach { stackable in
            self.addChild(stackable)
            stackView.addArrangedSubview(stackable.view)
        }
        
        super.viewDidLayoutSubviews()
    }
}
