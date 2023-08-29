//
//  ViewController.swift
//  QSC
//
//  Created by Zack Sai on 5/1/23.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let contentView = ProjectsView()
        let hostingController = UIHostingController(rootView: contentView)
        addChild(hostingController)
        view.insertSubview(hostingController.view, at: 0)
        hostingController.view.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostingController.didMove(toParent: self)
    }


}

