//
//  ViewController.swift
//  twelve ft
//
//  Created by Nicolas Camenisch on 10.08.22.
//

import Cocoa
import SafariServices
import WebKit

let extensionBundleIdentifier = "camenisch.nicolas.twelve-ft.Extension"

class ViewController: NSViewController {

    @IBOutlet weak var stateLabel: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        SFSafariExtensionManager.getStateOfSafariExtension(withIdentifier: extensionBundleIdentifier) { (state, error) in
            guard let state = state, error == nil else {
                // Insert code to inform the user that something went wrong.
                return
            }

            DispatchQueue.main.async {
                if state.isEnabled {
                    self.stateLabel.stringValue = "You can turn off 12ft’s extension in Safari Extensions preferences."
                } else {
                    self.stateLabel.stringValue = "You can turn on 12ft’s extension in Safari Extensions preferences."
                }
            }
        }
    }

    @IBAction func quitButtonPressed(_ sender: Any) {
        SFSafariApplication.showPreferencesForExtension(withIdentifier: extensionBundleIdentifier) { error in
            DispatchQueue.main.async {
                NSApplication.shared.terminate(nil)
            }
        }
    }

    @IBAction func helpButtonPressed(_ sender: Any) {
        guard let url = URL(string: "https://github.com/NMAC427/12ft") else { return }
        NSWorkspace.shared.open(url)
    }
}
