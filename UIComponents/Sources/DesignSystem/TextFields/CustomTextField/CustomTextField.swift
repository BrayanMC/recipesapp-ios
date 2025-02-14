//
//  CustomTextField.swift
//  RecipesApp
//
//  Created by Brayan Munoz Campos on 11/02/25.
//

import UIKit

public class CustomTextField: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Properties
    
    internal var id: Int = 0
    internal var isEmojiAllowed: Bool = false
    internal var textFieldType: CustomTextFieldType = .Default
    internal var keyboardType: CustomKeyboardType = .Default
    private let tooltipPadding: CGFloat = 8.0
    private let leadingPadding: CGFloat = 16.0
    private let trailingPadding: CGFloat = 16.0
    internal weak var eventsDelegate: CustomTextFieldEventsProtocol?
    internal var tooltipHeightAndWidth: CustomTextFieldTooltipDimensions = .small
    public var isEmpty: Bool {
        get {
            getTextValue().isEmpty
        }
    }
    
    public var isEnabled: Bool = true {
       didSet {
           textField.isEnabled = isEnabled
       }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initializeView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initializeView()
    }
    
    // MARK: - Private Methods
    
    /// Initializes the view by loading it from the nib and setting up the content view.
    private func initializeView() {
        loadViewFromNib()
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        configureViewStyles()
    }
    
    /// Loads the view from the nib.
    private func loadViewFromNib() {
        let nib = UINib(nibName: String(describing: CustomTextField.self), bundle: .module)
        nib.instantiate(withOwner: self, options: nil)
    }
    
    public func getTextValue() -> String  {
        textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
    }
    
    private func setPlaceholderColor() {
        textField.attributedPlaceholder = NSAttributedString(
            string: textField.placeholder ?? "",
            attributes: [NSAttributedString.Key.foregroundColor: ColorManager.gray4]
        )
    }
    
    private func dissmisKeyboard() {
        endEditing(true)
    }
    
    // MARK: - Search text field
    
    private func applySettingsForSearchField() {
        let dimensions = tooltipHeightAndWidth.size
        let image = UIImage(named: ImageNames.icSearchNormal, in: .module, compatibleWith: nil)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: CGFloat(dimensions.width), height: CGFloat(dimensions.height))
        textField.setLeftViewWithPadding(imageView, padding: 34.0)
        
        textField.leftViewMode = .always
    }
    
    // MARK: - Search text field
    
    private func applySettingsForDefault() {
        switch keyboardType {
        case .Numeric:
            textField.keyboardType = .numberPad
        case .Alphanumeric:
            textField.keyboardType = .namePhonePad
        default:
            textField.keyboardType = .default
        }
    }
    
    // MARK: - keyboard bar button
    
    private func addBarButtonToKeyboard() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = false
        toolBar.sizeToFit()
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(
            title: "keyboard_barButtonItem_title_accept".localized,
            style: UIBarButtonItem.Style.plain,
            target: self,
            action: #selector(textFieldAcceptButtonTapped)
        )
        toolBar.setItems([spaceButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    // MARK: - Public Methods
    
    public func displayView(
        id: Int = 0,
        eventsDelegate: CustomTextFieldEventsProtocol? = nil,
        placeholder: String,
        textFieldType: CustomTextFieldType = .Default,
        keyboardType: CustomKeyboardType = .Default,
        isEmojiAllowed: Bool = false,
        isEnabled: Bool = true
    ) {
        addBarButtonToKeyboard()
        self.id = id
        self.textField.delegate = self
        self.eventsDelegate = eventsDelegate
        self.textFieldType = textFieldType
        self.keyboardType = keyboardType
        self.isEmojiAllowed = isEmojiAllowed
        self.isEnabled = isEnabled
        
        textField.placeholder = placeholder
        setPlaceholderColor()
        
        textField.setPadding(left: leadingPadding, right: trailingPadding)
        
        switch textFieldType {
        case .Search:
            applySettingsForSearchField()
        case .Default:
            applySettingsForDefault()
        }
    }
    
    public func reset() {
        setTextValue(text: "")
    }
    
    public func setTextValue(text: String) {
        textField.text = text
    }
    
    @objc func textFieldAcceptButtonTapped() {
        dissmisKeyboard()
    }
    
    @IBAction func customTextFieldEditingChanged(_ textField: UITextField) {
        switch textFieldType {
        case .Search:
            guard let text = textField.text else { return }
            
            eventsDelegate?.editingChanged(forField: id, text)
        case .Default:
            guard let text = textField.text else { return }
            
            eventsDelegate?.editingChanged(forField: id, text)
        }
    }
}

extension CustomTextField: ViewStylerProtocol {
    
    public func configureViewStyles() {
        textField.font = .museoSansFont(type: .W300, size: 16)
    }
}
