/* This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. */

import Foundation
import SnapKit

protocol SearchSuggestionsPromptViewDelegate: class {
    func searchSuggestionsPromptViewEnable(_ searchSuggestionsPromptView: SearchSuggestionsPromptView)
    func searchSuggestionsPromptViewDisable(_ searchSuggestionsPromptView: SearchSuggestionsPromptView)
}

class SearchSuggestionsPromptView: UIView {
    weak var delegate: SearchSuggestionsPromptViewDelegate?
    static let respondedToSearchSuggestionsPrompt = "SearchSuggestionPrompt"
    private let buttonBorderMiddle = UIView()
    private let buttonBorderTop = UIView()
    private let disableButton = InsetButton()
    private let enableButton = InsetButton()
    private let promptContainer = UIView()
    private let promptCornerRadius: CGFloat = 12
    private let promptMessage = UILabel()
    private let promptTitle = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        
        promptContainer.backgroundColor = UIConstants.Photon.Ink70.withAlphaComponent(0.9)
        promptContainer.layer.cornerRadius = promptCornerRadius
        addSubview(promptContainer)
        
        promptContainer.snp.makeConstraints{ make in
            make.top.equalTo(self).offset(8)
            make.bottom.equalTo(self).offset(-8)
            make.leading.equalTo(self).offset(6)
            make.trailing.equalTo(self).offset(-6)
        }
        
        promptTitle.text = UIConstants.strings.searchSuggestionsPromptTitle
        promptTitle.textColor = UIConstants.Photon.Grey10
        promptTitle.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        promptTitle.textAlignment = NSTextAlignment.center
        promptTitle.numberOfLines = 0
        promptTitle.lineBreakMode = .byWordWrapping
        promptContainer.addSubview(promptTitle)

        promptTitle.snp.makeConstraints{ make in
            make.top.equalTo(promptContainer).offset(20)
            make.leading.equalTo(promptContainer).offset(10)
            make.trailing.equalTo(promptContainer).offset(-10)
        }
        
        promptMessage.text = String(format: UIConstants.strings.searchSuggestionsPromptMessage, AppInfo.productName)
        promptMessage.textColor = UIConstants.Photon.Grey10
        promptMessage.font = UIFont.systemFont(ofSize: 14)
        promptMessage.textAlignment = NSTextAlignment.center
        promptMessage.numberOfLines = 0
        promptMessage.lineBreakMode = .byWordWrapping
        promptContainer.addSubview(promptMessage)
        
        promptMessage.snp.makeConstraints { make in
            make.top.equalTo(promptTitle.snp.bottom).offset(5)
            make.leading.equalTo(promptContainer).offset(10)
            make.trailing.equalTo(promptContainer).offset(-10)
        }
        
        buttonBorderTop.backgroundColor = UIConstants.Photon.Grey10.withAlphaComponent(0.2)
        addSubview(buttonBorderTop)
        
        buttonBorderTop.snp.makeConstraints { make in
            make.top.equalTo(promptMessage.snp.bottom).offset(20)
            make.leading.trailing.equalTo(promptContainer)
            make.height.equalTo(0.5)
        }
        
        buttonBorderMiddle.backgroundColor = UIConstants.Photon.Grey10.withAlphaComponent(0.2)
        addSubview(buttonBorderMiddle)
        
        buttonBorderMiddle.snp.makeConstraints { make in
            make.top.equalTo(buttonBorderTop.snp.bottom)
            make.bottom.equalTo(promptContainer)
            make.width.equalTo(0.5)
            make.height.equalTo(40)
            make.centerX.equalTo(self)
        }

        disableButton.accessibilityIdentifier = "SearchSuggestionsPromptView.disableButton"
        disableButton.setTitle(UIConstants.strings.searchSuggestionsPromptDisable, for: .normal)
        disableButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        disableButton.layer.cornerRadius = 8.0
        disableButton.addTarget(self, action: #selector(didPressDisable), for: .touchUpInside)
        addSubview(disableButton)

        disableButton.snp.makeConstraints { make in
            make.top.equalTo(buttonBorderTop.snp.bottom)
            make.bottom.leading.equalTo(promptContainer)
            make.trailing.equalTo(buttonBorderMiddle.snp.leading)
        }
        
        enableButton.accessibilityIdentifier = "SearchSuggestionsPromptView.enableButton"
        enableButton.setTitle(UIConstants.strings.searchSuggestionsPromptEnable, for: .normal)
        enableButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        enableButton.layer.cornerRadius = 8.0
        enableButton.addTarget(self, action: #selector(didPressEnable), for: .touchUpInside)
        addSubview(enableButton)

        enableButton.snp.makeConstraints { make in
            make.top.equalTo(buttonBorderTop.snp.bottom)
            make.bottom.trailing.equalTo(promptContainer)
            make.leading.equalTo(buttonBorderMiddle.snp.trailing)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didPressDisable() {
        delegate?.searchSuggestionsPromptViewDisable(self)
    }
    
    @objc private func didPressEnable() {
        delegate?.searchSuggestionsPromptViewEnable(self)
    }
}
