//
//  Component+Coordinator.swift
//  eRaceLeague-iOS
//
//  Created by Terrick Mansur on 5/28/18.
//  Copyright © 2018 Arubook N.V. All rights reserved.
//

import UIKit

extension Coordinator {
    public static func stackCoordinator(coordinator: StackCoordinatorProtocol) -> StackCoordinatorViewController {

        guard let stackCoordinatorViewController = UIStoryboard.init(name: "StackCoordinator", bundle: Bundle.main).instantiateViewController(withIdentifier: "StackCoordinator") as? StackCoordinatorViewController else {
            fatalError("Could not create Coordinator")
        }
        
        stackCoordinatorViewController.coordinator = coordinator
        
        return stackCoordinatorViewController
    }
}
