//
//  CustomTextFieldEventsProtocol.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

@MainActor
/// Protocol to handle various text field events.
public protocol CustomTextFieldEventsProtocol: AnyObject {
    /// Called when editing begins in a text field.
    /// - Parameters:
    ///   - id: The identifier of the text field.
    ///   - text: The current text in the text field.
    func editingDidBegin(forField id: Int, _ text: String)
    
    /// Called when editing ends in a text field.
    /// - Parameters:
    ///   - id: The identifier of the text field.
    ///   - text: The current text in the text field.
    func editingDidEnd(forField id: Int, _ text: String)
    
    /// Called when the text in a text field changes.
    /// - Parameters:
    ///   - id: The identifier of the text field.
    ///   - text: The current text in the text field.
    func editingChanged(forField id: Int, _ text: String)
}
