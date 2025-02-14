//
//  CustomTextField+UITextFieldDelegate.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit

extension CustomTextField: UITextFieldDelegate {
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (!isEmojiAllowed && string.hasEmoticon()) {
            return false
        }
        
        switch textFieldType {
        case .Search:
            guard CharacterSet(
                charactersIn: "0123456789QWERTYUIOPASDFGHJKLÑZXCVBNMqwertyuiopasdfghjklñzxcvbnm "
            ).isSuperset(
                of: CharacterSet(charactersIn: string)
            ) else {
                return false
            }
            
            return true
        case .Default:
            return true
        }
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        eventsDelegate?.editingDidBegin(forField: id, text)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField.text == "") {
            reset()
        }
        
        guard let text = textField.text else { return }
        
        eventsDelegate?.editingDidEnd(forField: id, text)
    }
}
