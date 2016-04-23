//
// This file is part of Akane
//
// Created by JC on 09/11/15.
// For the full copyright and license information, please view the LICENSE
// file that was distributed with this source code
//

import Foundation
import HasAssociatedObjects

var ComponentViewLifecycleAttr = "ComponentViewLifecycleAttr"

/**
ComponentView is used on an `UIView` in order to associate it to a 
`ComponentViewModel` implementing its business logic.

- *Future enhancements:* this protocol will be generic once we will be able to 
use generics with Storyboard/Xib
*/
public protocol ComponentView : class, ViewObserver, HasAssociatedObjects {
    /**
    Define the bindings between the fields (IBOutlet) and the ComponentViewModel
    
    - parameter observer:  The observer to use for defining  and registering 
    bindings
    - parameter viewModel: The `ComponentViewModel` associated to the `UIView`
    */
    func bindings(observer: ViewObserver, viewModel: AnyObject)
}

extension ComponentView {
    // FIXME make var weak
    public weak var componentLifecycle: Lifecycle? {
        get { return self.associatedObjects[ComponentViewLifecycleAttr] as? Lifecycle }
        set { self.associatedObjects[ComponentViewLifecycleAttr] = newValue }
    }

    /**
    `ComponentViewController` class associated to the `ComponentView`
    
    - returns: The `ComponentViewController` type. 
    The Default implementation returns `ComponentViewController.self`
    */
    public static func componentControllerClass() -> ComponentViewController.Type {
        return ComponentViewController.self
    }
}

extension ComponentView {
    public func observe<AnyValue>(value: AnyValue) -> AnyObserver<AnyValue> {
        let observation = AnyObserver(value: value)

        self.observerCollection?.append(observation)

        return observation
    }

    public func observe(value: Command) -> CommandObserver {
        let observation = CommandObserver(command: value)

        self.observerCollection?.append(observation)

        return observation
    }

    public func observe<ViewModelType : ComponentViewModel>(value: ViewModelType) -> ViewModelObserver<ViewModelType> {
        let observation = ViewModelObserver<ViewModelType>(lifecycle: self.componentLifecycle!)

        self.observerCollection?.append(observation)

        return observation
    }
}