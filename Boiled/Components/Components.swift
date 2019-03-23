//
//  Components.swift
//  eRaceLeague-iOS
//
//  Created by Terrick Mansur on 4/9/18.
//  Copyright © 2018 Arubook N.V. All rights reserved.
//

import UIKit

public class Components {

    static func viewController(storyboardFile: String) -> UIViewController {
        return UIStoryboard.init(name: storyboardFile, bundle: Bundle.main).instantiateViewController(withIdentifier: storyboardFile)
    }    
}

public protocol Componentable {
    
    associatedtype ViewModelType

    var viewModel: ViewModelType! { get set }
    
    static var storyboard: String { get }
}

public extension Componentable {
    
    public static func create<GenericVC: Componentable>(viewModel: GenericVC.ViewModelType) -> GenericVC where GenericVC : UIViewController {
        
        guard  let classType = NSClassFromString(self.storyboard),
            var component = (UIStoryboard.init(name: self.storyboard, bundle: Bundle(for: classType)).instantiateViewController(withIdentifier: self.storyboard) as? GenericVC) else {
            fatalError("Could not create component")
        }
        
        component.loadViewIfNeeded()
        component.viewModel = viewModel
        
        return component
    }
    
    public static func create<GenericVC: Componentable>(viewModelProvider: (_ GenericVC: GenericVC) -> (GenericVC.ViewModelType)) -> GenericVC where GenericVC : UIViewController {

        guard let classType = NSClassFromString(self.storyboard),
                var component = (UIStoryboard.init(name: self.storyboard, bundle: Bundle(for: classType)).instantiateViewController(withIdentifier: self.storyboard) as? GenericVC) else {
            fatalError("Could not create component") }

        component.loadViewIfNeeded()
        component.viewModel = viewModelProvider(component)
        
        return component
    }
}
