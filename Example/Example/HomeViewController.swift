//
//  ViewController.swift
//  Example
//
//  Created by Martin MOIZARD-LANVIN on 15/09/16.
//  Copyright © 2016 Akane. All rights reserved.
//

import UIKit
import Akane

class HomeViewController: UIViewController, ComponentController {
    typealias ViewType = SearchAuthorsView

    lazy private(set) var navbarItemDisplayer: NavbarItemDisplayer = NavbarItemDisplayer(content: self.navigationItem)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = SearchAuthorsViewModel()
    }

    func didLoadComponent() {
        self.navbarItemDisplayer.bindings(self.observer, props: "Search")
    }
}


