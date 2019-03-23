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
    associatedtype StyleType

    var viewModel: ViewModelType! { get set }
    var style: StyleType { get set }
    
    static var storyboard: String { get }
}

public extension Componentable {
    
    public static func create<GenericVC: Componentable>(viewModel: GenericVC.ViewModelType, style: GenericVC.StyleType) -> GenericVC where GenericVC : UIViewController {
        
        guard var component = (UIStoryboard.init(name: self.storyboard, bundle: Bundle.main).instantiateViewController(withIdentifier: self.storyboard) as? GenericVC) else {
            fatalError("Could not create component")
        }
        component.viewModel = viewModel
        component.style = style
        
        return component
    }
    
    public static func create<GenericVC: Componentable>(
        style: GenericVC.StyleType,
        viewModelProvider: (_ GenericVC: GenericVC) -> (GenericVC.ViewModelType)) -> GenericVC where GenericVC : UIViewController {

            guard var component = (UIStoryboard.init(name: self.storyboard, bundle: Bundle.main).instantiateViewController(withIdentifier: self.storyboard) as? GenericVC) else {
            fatalError("Could not create component") }
        component.loadViewIfNeeded()
        component.viewModel = viewModelProvider(component)
        component.style = style
        
        return component
    }
}
